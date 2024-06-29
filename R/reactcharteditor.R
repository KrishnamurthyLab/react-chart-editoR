#' @title React Chart Editor
#' @description Create a Plotly react-chart-editor component UI element. Running
#'   this function makes your application take a dependency on the
#'   react-chart-editor React component, retrieved through the jsdelivr CDN as a
#'   side effect. It uses reactR to create a Shiny Input from the component,
#'   returning the HTML that can be included anywhere in your application's UI
#'   code.
#' @param id The HTML element id of the react-chart-editor UI component being
#'   created.
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#' @export
reactChartEditor <- function(id = "root") {
  jsdelivr <- "https://cdn.jsdelivr.net/npm/"
  css <- r"(div.fold { box-sizing: content-box; })"
  reactR::createReactShinyInput(
            inputId = id,
    class = "react-chart-editor",
    dependencies = list(
      shinyJS =
        htmltools::htmlDependency(
                     name = "plotly.js",
                     version = 2.33.0,
                     src = list(href = paste0(jsdelivr,
                                              "plotly.js@2.33.0/dist/")),
                     script = list(src = "plotly.min.js")),
      reactShinyJS =
        htmltools::htmlDependency(
                     name = "react-shiny.js",
                     version = 2.6.0,
                     src = list(href = paste0(jsdelivr,
                                              "react-plotly.js@2.6.0/")),
                     script = list(src = "factory.min.js")),
      reactShinyEditor =
        htmltools::htmlDependency(
                     name = "react-chart-editor",
                     version = "0.46.1",
                     src = list(href = paste0(jsdelivr,
                                              "react-chart-editor@0.46.1/lib/")),
                     script = list(src = "index.js"),
                     stylesheet = "react-chart-editor.css"
                   )),
    ## MAYBE TODO: use a default data set with a default layout.
    default = list(data = list(), layout = list()),
    ## MAYBE TODO: use a default configuration.
    configuration = list(),
    container = function(id, class) {
      htmltools::tags$div(inputId = id, class = class, style = css)
    }
  )
}

## TODO: make it a getter without options and a setter with options.
#' @title React Chart Editor Configuration
#' @description Set or retrieve the configuration object for your Plotly charts.
#'   This wraps plotly::config to include the editor button, and provides the
#'   opportunity to set a different event name for the edit button. If it is
#'   never called explicitly the default name will be used and the only
#'   customization to the Plotly configuration will be the inclusion of the edit
#'   button.
#' @param ... Arguments to pass along to plotly::config.
#' @importFrom shiny icon
#' @importFrom htmlwidgets JS
#' @export
reactChartEditorConfiguration <-
  function(...) {
    #### NOTE: session$sendInputMessage(inputId, message) :=
    ## $('react-chart-editor').receiveMessage(plot, {
    ##   configuration: [{
    ##     plotId = plot.id
    ##   }]
    ## })
    js <- sprintf(
      r"((plot) => %s.receiveMessage(%s, {configuration:[{plotId: plot.id}]});)",
      getOption("reactChartEditor"), # element
      plot$id # the inputId of the react-chart-editor
    )
    editButton = list(
      name = "Edit",
      icon = shiny::icon("pencil"),
      click = htmlwidgets::JS(js)
    )
    ## TODO: merge the dots with the list if ... contains modeBarButtonsToAdd.
    plotly::config(modeBarButtonsToAdd = list(editButton), ...)
  }

#' @title ggplotly
#' @description A wrapper for ggplotly which specifies the default
#'   react-chart-editor ui component to target, and includes the edit button in
#'   the Plotly modebar.
#' @param ... Aguments to pass on to plotly::ggplotly.
#' @param config The reactChartEditorConfiguration().
#' @importFrom plotly ggplotly
#' @importFrom utils hasName
#' @export
ggplotly <- function(..., config = reactChartEditorConfiguration()) {
  stopifnot(!utils::hasName(..., "config"))
  plotly::ggplotly(..., config = config)
}
