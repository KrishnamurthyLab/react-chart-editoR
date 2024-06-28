#' @title React Chart Editor
#' @description Create a Plotly react-chart-editor component UI element. Running
#'   this function makes your application take a dependency on the
#'   react-chart-editor React component, retrieved through the jsdelivr CDN as a
#'   side effect. It uses reactR to create a Shiny Input from the component,
#'   returning the HTML that can be included anywhere in your application's UI
#'   code.
#' @param id The HTML element id of the react-chart-editor to create.
#' @param editButtonEventName The name of the input event that will be available
#'   under input$editButtonEventName, for example.
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#' @export
reactChartEditor <- function(id, editButtonEventName) {
  .NotYetUsed(editButtonEventName)
  sourceURL <- "https://cdn.jsdelivr.net/npm/react-chart-editor@0.46.1/lib/"
  css <- r"(*.react-chart-editor ~ div.fold { box-sizing: content-box; })"
  reactR::createReactShinyInput(
    inputId = id,
    class = "react-chart-editor",
    dependencies =
      htmltools::htmlDependency(
                   name = "react-chart-editor",
                   version = "0.46.1",
                   src = sourceURL,
                   script = list(src = "index.js", integrity = "hash"),
                   stylesheet = "react-chart-editor.css"
                 ),
    ## MAYBE TODO: use a default data set with a default layout.
    default = list(data = list(), layout = list()),
    ## MAYBE TODO: use a default configuration.
    configuration = list(),
    container = function(id, class) {
      htmltools::tags$div(inputId = id, class = class, style = css)
    }
  )
}

## MAYBE DONT: it might be better to simply do this directly in JavaScript. It
## doesn't make sense to do pass information like this from JS to R right back
## to JS.
#' @title Message the React Chart Editor
#' @description Message the editor with a list of a value and a configuration.
#' @param session The session object; the current reactive domain.
#' @param inputId The HTML element id of the react-chart-editor to update.
#' @param value The value to pass to the editor through a message.
#' @param configuration The configuration to pass to the editor through a
#'   message.
#' @export
messageReactChartEditor <-
  function(session, inputId, value, configuration)
    session$sendInputMessage(inputId,
                             list(value = value,
                                  if (!is.null(configuration))
                                    configuration = configuration))

## TODO: implement the functionality for this, so that consuming Shiny
## applications don't need to do anything but load the package and specify where
## they'd like their chart editor to live in their application.
#' @title ggplotly
#' @description A wrapper for ggplotly which specifies the default
#'   react-chart-editor ui component to target, and includes the edit button in
#'   the Plotly modebar.
#' @param ... Aguments to pass on to plotly::ggplotly
#' @export
ggplotly <- function(...) {
  plotly::ggplotly(...)
}
