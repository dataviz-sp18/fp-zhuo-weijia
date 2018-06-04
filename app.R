
library(rsconnect)

library(shiny)
library(tidyverse)
library(plotly)
library(ggplot2)

library(ggmap)
library(maps)
library(mapdata)
library(dplyr)  
library(ggalt)
require(reshape)

#boxplot
dfff <- get(load("merged.Rdata"))

new = data.frame(table(dfff$country))

dfff$key=dfff$key/10
dfff$loudness=dfff$loudness/10
dfm = melt(dfff[,c(2,10:19)], id='Region')

dffff=unique(dfm)


#map
char = read.csv('country_features.csv')
ab = read.csv('ab.csv')
ab$ab=sapply(ab$ab,tolower)
df = merge(char,ab,by.x='region',by.y='ab')
world <- map_data("world")

#bubble
data <- read_csv("country.csv")

#bar
region2 = c('Japan', 'Great Britain (UK)', 'Mexico','Taiwan','Singapore')
song <- read_csv("data.csv")
songdf = merge(song,ab,by.x='Region',by.y='ab')


ui <- fluidPage(
  column(12, align = 'center',
         titlePanel('How Music Preferences Differ by Region?'),
         h2('Zhuo Leng & Weijia Li'),
         h3('2018-05')),
  
  fluidRow(
    mainPanel(
      tabsetPanel(
        tabPanel(title='Skewness and Outliers',
                 h2('The below graph shows the skewness and outliers Boxplot for each measurement'),
                 mainPanel(plotlyOutput('boxplot'))),
        tabPanel(title='Features Map by Countries',
                 h2('Select a type of audio features to view the color map'),
                 sidebarLayout(
                   sidebarPanel(
                     radioButtons('Features','Features', choices = c('danceability','instrumentalness','loudness','speechiness'),
                                  selected='danceability')),
                   mainPanel(plotlyOutput('map')))
                 ),
        tabPanel(title='Bubble Chart',
                 h2('The below graph shows the relationship among features'),
                 sidebarLayout(
                        sidebarPanel(
                                 sliderInput(
                                   "danceability",
                                   "danceability",
                                   min = 0.5,
                                   max = 0.9,
                                   value = c(0.6, 0.8)
                                 )),
                               mainPanel(plotlyOutput('bubbleplot',width = 400, height = 400)))),
        tabPanel(title='Characteristics of Countries',
                 h2('The below graph shows the freqency countries using Spotify'),
                 mainPanel(plotlyOutput('map2'))
                 ),
        tabPanel(title='Popular Songs by Countries',
                 h2('The below graph shows Top 3 Streamed Songs by Regions'),
                 mainPanel(plotlyOutput('barchart'))
        )
                 )
                 )
        )
  )


server <- function(input, output) {
  
  output$boxplot <- renderPlotly({
    
    p <- plot_ly(dffff, x = ~variable, y = ~value, color = ~variable, type = "box") %>%
      layout(boxmode = "group")
    
    p
  })
  
  
  output$map <- renderPlotly({
    
    dff <- data.frame(region=df$country, 
                      danceability=df$danceability,
                      instrumentalness = df$instrumentalness,
                      loudness = df$loudness,
                      speechiness = df$speechiness,
                      stringsAsFactors=FALSE)
    
    gg1 <- ggplot() + 
      geom_polygon(data = world, aes(x = long, y = lat, group = group),
                   fill = "white", color = "#7f7f7f") + 
      coord_fixed(1.3)
    gg1 + geom_map(data=dff, map=world,
                   aes_string(fill=input$Features, map_id="region"),
                        colour="#7f7f7f", size=0.15) + scale_fill_gradient(low = "white", high = "steelblue")

                                                                           
  })

  output$bubbleplot <- renderPlotly({
    filtered <- data %>%
      filter(danceability >= input$danceability[1],
             danceability <= input$danceability[2]
      )
    ggplot(filtered, aes(country,energy)) +
      labs(subtitle="music energy and speech by countries",
           title="Bubble chart") +
      geom_jitter(aes(col=country, size=speechiness))
    
  })
  
  output$map2 <- renderPlotly({
    
    gg1 <- ggplot() + 
      geom_polygon(data = world, aes(x = long, y = lat, group = group),
                   fill = "white", color = "#7f7f7f") + 
      coord_fixed(1.3)
    gg1 + geom_map(data=new, map=world,
                   aes(fill=Freq, map_id=Var1),
                   colour="#7f7f7f", size=0.15) + scale_fill_gradient(low = "white", high = "darkgreen")
    
    
  })
  
  output$barchart <- renderPlotly({
    
    filtered2 <- songdf %>%
      filter(country %in% region2
      )
    
    filtered2$`Track Name` <- as.character(filtered2$`Track Name`)
    filtered2$count <- as.numeric(ave(filtered2$`Track Name`, filtered2$`Track Name`, FUN = length))

    filtered3 <- filtered2 %>%
      group_by(country,`Track Name`) %>%
      tally(count) %>%
      top_n(3)
    
    ggplot(data = filtered3, aes(x = country, y = n, fill = `Track Name`)) + 
      geom_bar(stat="identity")
    
  })
  
}

shinyApp(ui = ui, server = server)
