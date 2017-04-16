
#Loading the rvest package
library('rvest')

#Sprcifying the url for desired website to be scrapped
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'

#Reading the HTML code from the website
webpage <- read_html(url)







#Using CSS selectors to scrap the title section
title_data_html <- html_nodes(webpage,'.lister-item-header a')

#Converting the title data to text
title_data <- html_text(title_data_html)

#Let's have a look at the title
head(title_data)

[1] "Sing"          "Moana"         "Moonlight"     "Hacksaw Ridge"
[5] "Passengers"    "Trolls"  







#Using CSS selectors to scrap the rankings section
rank_data_html <- html_nodes(webpage,'.text-primary')

#Converting the ranking data to text
rank_data <- html_text(rank_data_html)

#Let's have a look at the rankings
head(rank_data)

[1] "1." "2." "3." "4." "5." "6."

#Data-Preprocessing: Converting rankings to numerical
rank_data<-as.numeric(rank_data)

#Let's have another look at the rankings
head(rank_data)

[1] 1 2 3 4 5 6




#Using CSS selectors to scrap the description section
description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')

#Converting the description data to text
description_data <- html_text(description_data_html)

#Let's have a look at the description data
head(description_data)

[1] "\nIn a city of humanoid animals, a hustling theater impresario's attempt to save his theater with a singing competition becomes grander than he anticipates even as its finalists' find that their lives will never be the same."
[2] "\nIn Ancient Polynesia, when a terrible curse incurred by the Demigod Maui reaches an impetuous Chieftain's daughter's island, she answers the Ocean's call to seek out the Demigod to set things right."                        
[3] "\nA chronicle of the childhood, adolescence and burgeoning adulthood of a young, African-American, gay man growing up in a rough neighborhood of Miami."                                                                         
[4] "\nWWII American Army Medic Desmond T. Doss, who served during the Battle of Okinawa, refuses to kill people, and becomes the first man in American history to receive the Medal of Honor without firing a shot."                 
[5] "\nA spacecraft traveling to a distant colony planet and transporting thousands of people has a malfunction in its sleep chambers. As a result, two passengers are awakened 90 years early."                                      
[6] "\nAfter the Bergens invade Troll Village, Poppy, the happiest Troll ever born, and the curmudgeonly Branch set off on a journey to rescue her friends."                                                                          


#Data-Preprocessing: removing '\n'
description_data<-gsub("\n","",description_data)

#Let's have another look at the description data
head(description_data)

[1] "In a city of humanoid animals, a hustling theater impresario's attempt to save his theater with a singing competition becomes grander than he anticipates even as its finalists' find that their lives will never be the same."
[2] "In Ancient Polynesia, when a terrible curse incurred by the Demigod Maui reaches an impetuous Chieftain's daughter's island, she answers the Ocean's call to seek out the Demigod to set things right."                        
[3] "A chronicle of the childhood, adolescence and burgeoning adulthood of a young, African-American, gay man growing up in a rough neighborhood of Miami."                                                                         
[4] "WWII American Army Medic Desmond T. Doss, who served during the Battle of Okinawa, refuses to kill people, and becomes the first man in American history to receive the Medal of Honor without firing a shot."                 
[5] "A spacecraft traveling to a distant colony planet and transporting thousands of people has a malfunction in its sleep chambers. As a result, two passengers are awakened 90 years early."                                      
[6] "After the Bergens invade Troll Village, Poppy, the happiest Troll ever born, and the curmudgeonly Branch set off on a journey to rescue her friends."                                                                          





#Using CSS selectors to scrap the Movie runtime section
runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')

#Converting the runtime data to text
runtime_data <- html_text(runtime_data_html)

#Let's have a look at the runtime
head(runtime_data)

[1] "108 min" "107 min" "111 min" "139 min" "116 min" "92 min" 

#Data-Preprocessing: removing mins and convering it to numerical
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)

#Let's have another look at the runtime data
head(rank_data)

[1] 1 2 3 4 5 6




#Using CSS selectors to scrap the Movie genre section
genre_data_html <- html_nodes(webpage,'.genre')

#Converting the genre data to text
genre_data <- html_text(genre_data_html)

#Let's have a look at the runtime
head(genre_data)

[1] "\nAnimation, Comedy, Family            "   
[2] "\nAnimation, Adventure, Comedy            "
[3] "\nDrama            "                       
[4] "\nBiography, Drama, History            "   
[5] "\nAdventure, Drama, Romance            "   
[6] "\nAnimation, Adventure, Comedy            "

#Data-Preprocessing: removing \n
genre_data<-gsub("\n","",genre_data)

#Data-Preprocessing: removing excess spaces
genre_data<-gsub(" ","",genre_data)


#taking only the first genre of each movie
genre_data<-gsub(",.*","",genre_data)


#Convering each genre from text to factor
genre_data<-as.factor(genre_data)

#Let's have another look at the genre data
head(genre_data)

[1] Animation Animation Drama     Biography Adventure Animation
10 Levels: Action Adventure Animation Biography Comedy Crime Drama ... Thriller







#Using CSS selectors to scrap the IMDB rating section
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')

#Converting the ratings data to text
rating_data <- html_text(rating_data_html)

#Let's have a look at the ratings
head(rating_data)

[1] "7.2" "7.7" "7.6" "8.2" "7.0" "6.5"

#Data-Preprocessing: converting ratings to numerical
rating_data<-as.numeric(rating_data)

#Let's have another look at the ratings data
head(rating_data)

[1] 7.2 7.7 7.6 8.2 7.0 6.5




#Using CSS selectors to scrap the metascore section
metascore_data_html <- html_nodes(webpage,'.metascore')

#Converting the runtime data to text
metascore_data <- html_text(metascore_data_html)

#Let's have a look at the metascore data
head(metascore_data)

[1] "59        " "81        " "99        " "71        " "41        "
[6] "56        "

#Data-Preprocessing: removing extra space in metascore
metascore_data<-gsub(" ","",metascore_data)

#Lets check the length of metascore data
length(metascore_data)

[1] 96

for (i in c(39,73,80,89)){
  a<-metascore_data[1:(i-1)]
  b<-metascore_data[i:length(metascore_data)]
  
  metascore_data<-append(a,list("NA"))
  metascore_data<-append(metascore_data,b)
  
}

#Data-Preprocessing: converting metascore to numerical
metascore_data<-as.numeric(metascore_data)

#Let's have another look at length of the metascore data
length(metascore_data)

[1] 100

#Let's look at summary statistics
summary(metascore_data)

Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  23.00   47.00   60.00   60.22   74.00   99.00       4 


#Using CSS selectors to scrap the votes section
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')

#Converting the votes data to text
votes_data <- html_text(votes_data_html)

#Let's have a look at the votes data
head(votes_data)

[1] "40,603"  "91,333"  "112,609" "177,229" "148,467" "32,497" 

#Data-Preprocessing: removing commas 
votes_data<-gsub(",","",votes_data)

#Data-Preprocessing: converting votes to numerical
votes_data<-as.numeric(votes_data)

#Let's have another look at the votes data
head(votes_data)

[1]  40603  91333 112609 177229 148467  32497






#Using CSS selectors to scrap the gross revenue section
gross_data_html <- html_nodes(webpage,'.ghost~ .text-muted+ span')

#Converting the gross revenue data to text
gross_data <- html_text(gross_data_html)

#Let's have a look at the votes data
head(gross_data)

[1] "$269.36M" "$248.04M" "$27.50M"  "$67.12M"  "$99.47M"  "$153.67M"

#Data-Preprocessing: removing '$' and 'M' signs 
gross_data<-gsub("M","",gross_data)
gross_data<-substring(gross_data,2,6)


#Lets check the length of gross data
length(gross_data)

[1] 86

#Filling missing entries with NA
for (i in c(17,39,49,52,57,64,66,73,76,77,80,87,88,89)){
  a<-gross_data[1:(i-1)]
  b<-gross_data[i:length(gross_data)]
  
  gross_data<-append(a,list("NA"))
  gross_data<-append(gross_data,b)
  
}


#Data-Preprocessing: converting gross to numerical
gross_data<-as.numeric(gross_data)


#Let's have another look at the gross data
length(gross_data)

[1] 100

summary(gross_data)

Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.08   15.52   54.69   96.91  119.50  530.70      14 

#Using CSS selectors to scrap the directors section
directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')

#Converting the directors data to text
directors_data <- html_text(directors_data_html)

#Let's have a look at the directors data
head(directors_data)

[1] "Christophe Lourdelet" "Ron Clements"         "Barry Jenkins"       
[4] "Mel Gibson"           "Morten Tyldum"        "Walt Dohrn"   

#Data-Preprocessing: converting directors data into factors
directors_data<-as.factor(directors_data)








#Using CSS selectors to scrap the actors section
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')

#Converting the gross actors data to text
actors_data <- html_text(actors_data_html)

#Let's have a look at the actors data
head(actors_data)

[1] "Matthew McConaughey" "Auli'i Cravalho"     "Mahershala Ali"     
[4] "Andrew Garfield"     "Jennifer Lawrence"   "Anna Kendrick"   

#Data-Preprocessing: converting actorrs data into factors
actors_data<-as.factor(actors_data)





movies_df<-data.frame(Rank = rank_data, Title = title_data, Description = description_data, 
                      Runtime = runtime_data, Genre = genre_data, Rating = rating_data, 
                      Metascore = metascore_data, Votes = votes_data, Gross_Earning_in_Mil = gross_data, 
                      Director = directors_data, Actor = actors_data)


str(movies_df)

'data.frame':	100 obs. of  11 variables:
  $ Rank                : num  1 2 3 4 5 6 7 8 9 10 ...
$ Title               : Factor w/ 99 levels "10 Cloverfield Lane",..: 66 53 54 32 58 93 8 43 97 7 ...
$ Description         : Factor w/ 100 levels "19-year-old Billy Lynn is brought home for a victory tour after a harrowing Iraq battle. Through flashbacks the film shows what"| __truncated__,..: 57 59 3 100 21 33 90 14 13 97 ...
$ Runtime             : num  108 107 111 139 116 92 115 128 111 116 ...
$ Genre               : Factor w/ 10 levels "Action","Adventure",..: 3 3 7 4 2 3 1 5 5 7 ...
$ Rating              : num  7.2 7.7 7.6 8.2 7 6.5 6.1 8.4 6.3 8 ...
$ Metascore           : num  59 81 99 71 41 56 36 93 39 81 ...
$ Votes               : num  40603 91333 112609 177229 148467 ...
$ Gross_Earning_in_Mil: num  269.3 248 27.5 67.1 99.5 ...
$ Director            : Factor w/ 98 levels "Andrew Stanton",..: 17 80 9 64 67 95 56 19 49 28 ...
$ Actor               : Factor w/ 86 levels "Aaron Eckhart",..: 59 7 56 5 42 6 64 71 86 3 ...



library('ggplot2')

qplot(data = movies_df,Runtime,fill = Genre,bins = 30)
#Adventure

ggplot(movies_df,aes(x=Runtime,y=Rating))+
  geom_point(aes(size=Votes,col=Genre))
#Action

ggplot(movies_df,aes(x=Runtime,y=Gross_Earning_in_Mil))+
  geom_point(aes(size=Rating,col=Genre))
#Animation              
