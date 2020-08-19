#' @title Get Assay Data
#'
#' @description Retrieves and cleans assay results from Victor ouput file
#'
#' @param file The output file from the Victor run
#'
#' @return A dataframe of the assay results is returned
#'
#' @importFrom readxl read_excel
#' @export
get_assay_data <- function(file) {
  assay_data <- readxl::read_excel(file, sheet = "Plate_Page1", col_names = FALSE, range = readxl::cell_rows(7:14))
  assay_data <- as.matrix(assay_data)
  colnames(assay_data) <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")
  rownames(assay_data) <- c("A", "B", "C", "D", "E", "F", "G", "H")

  return(assay_data)
}

#' @title Get Metadata
#'
#' @description Retrieves metadata from Victor ouput file
#'
#' @param file The output file from the Victor run
#'
#' @return A list of metadata is returned
#' @importFrom stats na.omit
#' @importFrom readxl read_excel
#' @export
get_metadata <- function(file) {
  metadata <- list()
  metadata_df <- na.omit(readxl::read_excel(file, sheet = "Protocol", col_names = FALSE, range = readxl::cell_rows(4:45)))
  metadata[["protocol_name"]] <- strsplit(as.character(metadata_df[1, ]), " +")[[1]][4]
  plate_map <- metadata_df[21:28, ]
  colnames(plate_map) <- NULL
  metadata[["plate_map"]] <- plate_map
  metadata[["assay_id"]] <- strsplit(as.character(metadata_df[34, ]), " +")[[1]][4]
  date_str <- strsplit(as.character(metadata_df[32, ]), " +")[[1]][4:6]
  metadata[["date_measured"]] <- paste0(date_str[2])
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
import_victor_file <- function(filename) {
  data <- list()
  data[["assay_data"]] <- get_assay_data(file = filename)
  data[["metadata"]] <- get_metadata(file = filename)
  return(data)
}

#' @title Select Data
#'
#' @description Selects columns and rows from assay data to analyze
#'
#' @param data The assay data object.
#' @param columns The rows to select.
#' @param rows The rows to select.
#'
#' @return Returns a subsetted data object.
#' @export
select_data <- function(data, columns, rows) {
  data <- data[columns, rows]
  colnames(data) <- NULL
  rownames(data) <- NULL
}
