#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

select_from <- c("HW1","HW2","HW3","HW4","HW5","HW6","HW7","HW8","HW9","QZ1","QZ2","QZ3","QZ4","Test1","Test2","Homework","Quiz","Lab","Overall")
grade <- unique(sort(raw_scores$Grade))
frequency <- table(raw_scores$Grade)
proportion <- prop.table(table(raw_scores$Grade))
helper_table <- data.frame(grade)
helper_table$Freq <- frequency
helper_table$Prop <- round(proportion,2)
helper_table <- helper_table[c(2,1,3,5,4,6,8,7,9,10,11),]

install.packages("shiny")
library(shiny)

ui <- shinyUI(pageWithSidebar(
  headerPanel("Grade Distribution"),
    sidebarPanel(conditionalPanel(condition = "input.tabselected==1",dataTableOutput(outputId="distribution")),
      conditionalPanel(condition = "input.tabselected==2",selectInput(inputId="sel_1",label="X-axis variable",choices=select_from),sliderInput(inputId = "bin",label = "Bin Width",min=1,max=10,value=5)),
      conditionalPanel(condition = "input.tabselected==3",selectInput(inputId="sel_2",label ="X-axis variable",choices=select_from),selectInput(inputId='sel_3',label="Y-axis variable",choices=select_from),sliderInput(inputId="opacity",label="Opacity",min=0,max=1,step=0.1,value=0.5), radioButtons(inputId="method",label="Show line",choices=c("none","lm","loess")))
    ), mainPanel(tabsetPanel
            (tabPanel("Barchart",value=1,uiOutput("bar1"),ggvisOutput("bar1_ui")),
              tabPanel("Histogram",value=2, uiOutput("hist1"), ggvisOutput("hist1-ui"),verbatimTextOutput("summary")),
              tabPanel("Scatterplot",value=3,uiOutput("scatter1"),ggvisOutput("scatter1_ui"), verbatimTextOutput("cor")),id = "tabselected"))
))



server <- function(input,output){
  output$distribution <- renderDataTable({helper_table})
  helper_table %>% ggvis(~grade,~Freq) %>% layer_bars(fill := "lightblue",width=0.8,stroke := "lightblue") %>% add_axis("y",title="frequency") %>% bind_shiny("bar1","bar1_ui")
  hist_plot <- reactive({
    xvar <- prop("x", as.symbol(input$sel_1))
    histogram <- raw_scores %>%
      ggvis(x = xvar) %>%
      layer_histograms(stroke := 'white', width = input$bin, fill := "grey")
  })
  hist_plot %>% bind_shiny("hist1","hist1_ui")
  output$summary <- renderPrint({print_stats(summary_stats((select(raw_scores,input$sel_1))))})
  scatter <- reactive({
    xvar <- prop("x",as.symbol(input$sel_2))
    yvar <- prop("y",as.symbol(input$sel_3))
    if (input$method == "none"){
      scatterplot <- raw_scores %>% ggvis(x= xvar,y= yvar) %>% layer_points(opacity := input$opacity)}
    else {
      scatterplot <- raw_scores %>% ggvis(x= xvar,y= yvar) %>% layer_points(opacity := input$opacity) %>% layer_model_predictions(model = input$method)}
    })
  scatter %>% bind_shiny("scatter1","scatter1_ui")
  output$cor <- renderText({cor(select(raw_scores,input$sel_2),select(raw_scores,input$sel_3))})
}


# Run the application 
shinyApp(ui = ui, server = server)

