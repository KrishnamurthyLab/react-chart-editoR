#' @title Plotly chart editor input control
#' @description Create a Plotly chart editor input control.
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
    htmltools::tags$div
  )
}

#' @title update_plotly_editor
#' @export
update_plotly_editor <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
