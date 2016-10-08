
is_attached <- function(x) {
  paste0("package:", x) %in% search()
}

my_libraries <- function(...) {
  load <- c("ggplot2", "tibble", "tidyr", "readr", "purrr", "dplyr",
            "RODBC","lubridate") 
  
  needed <- load[!is_attached(load)]
  
  if (length(needed) == 0)
    return()
  
  packageStartupMessage(paste0("Loading package: ", needed, collapse = "\n"))
  lapply(needed, library, character.only = TRUE, warn.conflicts = FALSE)
  

}

search()
my_libraries()

