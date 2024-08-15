#' @title Plotly chart editor input control
#' @description Create a Plotly chart editor input control.
#' @param inputId The Shiny ID of the UI component.
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#' @export
plotly_editor <- function(inputId) {
  reactR::createReactShinyInput(
    inputId,
    "plotly_editor",
    htmltools::htmlDependency(
      name = "react-chart-editor",
      version = "0.46.1",
      src = "www/reactcharteditor/plotly_editor",
      script = "plotly_editor.js"
    ),
    default = list(data = list(), layout = list()),
    configuration = list(),
    \(...) htmltools::tags$div(style = "div.fold { box-sizing: 'content-box'; }", ...)
  )
}

#' @title Update a Plotly react-chart-editor UI component
#' @export
#' @param session The Shiny session object in which the chart editor is to be updated.
#' @param inputId The ID of the DOM object to which to pass a message.
#' @param value A value to pass along in a message to the DOM object specified by `inputId`.
#' @param configuration A configuration object for the editor component.
update_plotly_editor <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
