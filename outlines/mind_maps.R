
# install.packages("remotes")
# remotes::install_github("pzhaonet/mindr")

library(mindr)

create_mindmaps <- function(input_file) {

  input <- input_file
  input_txt <- readLines(input, encoding = "UTF-8")

  ## Convert to mind map text, markdown outline, and HTML widget
  mm_output <- mm(input_txt, output_type = c("mindmap", "markdown", "widget"))
  mm_output

}

ch7_v1_v2_outline_widget <- create_mindmaps(input_file = "ch7_toc.Rmd")$widget

ch8_v1_v2_outline_widget <- create_mindmaps(input_file = "ch8_toc.Rmd")$widget


# Open widgets in RStudio Viewer

ch7_v1_v2_outline_widget
ch8_v1_v2_outline_widget

v2_outline_widget <- create_mindmaps(input_file = "07-sampling.Rmd")$widget
v1_outline_widget <- create_mindmaps(input_file = "07-sampling-OLD.Rmd")$widget

