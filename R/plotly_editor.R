#' @title Plotly Editor
#'
#' @description Create a Plotly chart editor input control.
#'

#'

#' @title plotly_editor
#' @export
plotly_editor <- function(inputId) {
  reactR::createReactShinyInput(
    inputId,
    "plotly_editor",
    htmltools::htmlDependency(
      name = "plotly_editor-input",
      version = "1.0.0",
      src = "www/reactChartEditorTest/plotly_editor",
      package = "reactChartEditorTest",
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