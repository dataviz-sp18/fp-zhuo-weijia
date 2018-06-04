# Customer Behaviour Research of Spotify

## Introduction

This research tries to answer the research question: `How Music Preferences Differ by Regions?  ` We aim to find music preferences of different regions; these preferences include `Danceability`,  `Energy`,  `Tempo`, `Acoustics`, `Instrumentalness` and others. The dataset was obtainted from Kaggle.com, spanning year 2017. The data includes information about the track names, number of streams, countries, features describing the song, the url, etc.

The audio features include:

- Danceability - How suitable a track is for dancing based on a combination of musical elements.
- Energy - Measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy.
- Loudness - The overall loudness of a track in decibels (dB). 
- Mode - Mode indicates the modality (major or minor) of a track.Speechiness - Detects the presence of spoken words in a track based on values from 0 to 1.The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value.
- Acousticness - A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.	
- Instrumentalness  - 	Predicts whether a track contains no vocals. 
- Liveness - Detects the presence of an audience in the recording.  A value above 0.8 provides strong likelihood that the track is live.	
- Valence - A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track.	
- Tempo - A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track.
- Duration_ms  - The duration of the track in milliseconds.

## Methods

The interactive visualisations are displayed on a `Shiny` app that can be accessed at _________. We analysed the overall trend of songs in 2017 and then divide by coutries. A variety of graphs are build to show our results including an interactive box plot, an interactive map, an interactive bubble plot, stacked bar plot and heatmaps. All interactive graphs except the heatmaps can be accessed on the shiny app page, this markdown shows the samples of the graphs.

## Results

We first looked at some general trend of pop songs in 2017. The below heatmap is displaying top 50 songs in 2017. The ranks are shown by the size of the blocks and  highlighed by color; a cooler color represents a less popular song. 

From the graph, it is obvious that track 'Shape of You' ranks the first and far leading the game. 

![image](https://user-images.githubusercontent.com/22485624/40893020-4ea0c95a-6764-11e8-8959-c2f6fac2a774.png)

Next we plot the most popular artist of 2017. Again, Ed Shareen has led the game and is far more popular than other artists.

![image](https://user-images.githubusercontent.com/22485624/40893470-f27dccd8-6766-11e8-9206-f0a5f009eddd.png)

We then plotted a box plot to show the skewnewss and outliers for each have the lowest energy, she also have the lowest liveness yet the highest mode. France has the lowest mode and Philippines have the lowest level of tempo. The interactive map give a clearer look at how each feature is distributed in each region.

![image](https://user-images.githubusercontent.com/22485624/40894828-c798e3f8-6771-11e8-9c9b-54861c7dea95.png)

A series of feature maps are ploted by ggmap. For example, from the map of dancability below, the United States and the south of South America people favor more dancable music.

![image](https://user-images.githubusercontent.com/22485624/40895495-7f67fe76-6775-11e8-9379-07d930c939d1.png)

The below displays a sample of the interactive bubble chart. The chart shows that with a given danceability score, how energy associates with speechiness. For example, when danceability is between 0.7 and 0.8, the US has a lower energy yet a higher speechiness.

![image](https://user-images.githubusercontent.com/22485624/40895978-f384834a-6777-11e8-9fac-b7d1645a6a3a.png)

We then want to see the top hit songs for each region. Ed Sheeran's ['Thinking Out Loud'](https://www.youtube.com/watch?v=lp-EO5I60KA) ranks the first in the UK, Japan and Mexico and his ['Shape of You' ](https://www.youtube.com/watch?v=JGwWNGJdvx8) ranks the second in the UK, Japan, Mexico and Singapore and the first in Taiwan. ['Closer' ](https://www.youtube.com/watch?v=PT2_F-1esPk) ranks the third in all countries below.

![image](https://user-images.githubusercontent.com/22485624/40895826-2e015b7a-6777-11e8-8125-018f7f33362b.png)

We believe our research has some marketing value that the company can promote songs more efficiently with a certain country's characteristics.