
#' @title Get Assay Data
#'
#' @description Retrieves and cleans assay results from Victor ouput file
#'
#' @param file The output file from the Victor run
#'
#' @return A dataframe of the assay results is returned
#' @export
get_assay_data <- function(file, column_names = FALSE) {
  assay_data <- na.omit(readxl::read_excel(file, sheet = "Plate_Page1", col_names = column_names, range = readxl::cell_rows(7:14)))
  if (column_names != FALSE) {
    assay_data <- as.matrix(assay_data)
  } else {
    assay_data <- as.matrix(assay_data)
    colnames(assay_data) <- NULL
  }
  return(assay_data)
}

#' @title Get Metadata
#'
#' @description Retrieves metadata from Victor ouput file
#'
#' @param file The output file from the Victor run
#'
#' @return A list of metadata is returned
#' @export
get_metadata <- function(file) {
  metadata <- list()
  metadata_df <- na.omit(readxl::read_excel(file, sheet = "Protocol", col_names = FALSE, range = readxl::cell_rows(4:45)))
  metadata[["protocol_name"]] <- strsplit(as.character(metadata_df[1, ]), " +")[[1]][4]
  plate_map <- metadata_df[22:29, ]
  colnames(plate_map) <- NULL
  metadata[["plate_map"]] <- plate_map
  metadata[["assay_id"]] <- strsplit(as.character(metadata_df[35, ]), " +")[[1]][4]
  date_str <- strsplit(as.character(metadata_df[36, ]), " +")[[1]][4:6]
  metadata[["date_measured"]] <- paste0(date_str[1], sep = " ", "at ", date_str[2], sep = " ", date_str[3])
  return(metadata)
}

#' @title Add Metadata
#'
#' @description Adds additional metadata to the metadata list
#'
#' @param metadata The input metadata list
#' @param title The title or descriptor of the metadata
#' @param data The output file from the Victor run
#'
#' @return An updated list of metadata is returned
#' @export
add_metadata <- function(metadata, title, data) {
  metadata[[title]] <- data
  return(metadata)
}

#' @title Import Victor File
#'
#' @description Imports and manipulates the victor file
#'
#' @param filename The output file from the Victor run
#'
#' @return Returns a list of assay and metadata from a Victor file
#' @export
import_victor_file <- function(filename, experiment_columns) {
  data <- list()
  data[["assay_data"]] <- get_assay_data(file = filename, column_names = experiment_columns)
  data[["metadata"]] <- get_metadata(file = filename)
  return(data)
}

#' @title Select Rows
#'
#' @description Selects rows from assay data to analyze
#'
#' @param data The assay data object.
#' @param rows The rows to select.
#'
#' @return Returns a data object with rows selected.
#' @export
select_rows <- function(data, rows) {
  dplyr::slice(as.data.frame(data), rows)
}

