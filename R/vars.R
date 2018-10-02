#' @title SRE Expression Test columns
#'
#' @description Use these columns when testing SRE expression.
#' \describe{
#'   \item{Control}{negative control well}
#'   \item{10% FBS}{positive control well}
#'   \item{100 ng/ul EGF}{experimental well}
#'   \item{10% FBS + 100 ng/ul EGF}{experiemental well}
#' }
#' @export
sre_cols <- c("Control", "10% FBS", "100 ng/ul EGF", "10% FBS + 100 ng/ul EGF")

#' @title CRE Expression Test columns
#'
#' @description Use these columns when testing CRE expression.
#' \describe{
#'   \item{Control}{control well}
#'   \item{10 uM Forskolin}{experiemental well}
#' }
#' @export
cre_cols <- c("Control", "10 uM Forskolin")

#' @title AP1 Expression Test columns
#'
#' @description Use these columns when testing AP1 expression.
#' \describe{
#'   \item{Control}{control well}
#'   \item{10 ng/ul PMA}{experiemental well}
#' }
#' @export
ap1_cols <- c("Control", "10 ng/ul PMA")

#' @title NFkB Expression Test columns
#'
#' @description Use these columns when testing NFkB expression.
#' \describe{
#'   \item{Control}{control well}
#'   \item{10 ng/ul TNFa}{experiemental well}
#' }
#' @export
nfkb_cols <- c("Control", "10 ng/ul TNFa")
