#' Download files of the 'Portal da Transparencia'
#'
#' This function can be used to download a dataset from the 'Portal da Transparencia'
#' of Brazil - \url{http://www.portaltransparencia.gov.br}.
#'
#' @param opendata A character or numeric that indicates a dataset selected for download.
#' See valid options in 'Details'.
#' @param reference A character string or numeric input thats indicates a date reference to download.
#' Valid date which may be 'yyyy' for year, 'mm' for month, 'dd' day or the join of these
#' (yyyymm, yyyymmdd). See valid options in 'Details'.
#' @param destfile A character string with the name where the downloaded file is saved.
#' If missing, the file will be saved to the current directory.
#' @param filename File name to dataset. By default, the file name is the title of 'opendata'
#' with the 'reference' and '.zip' extension.
#' @param download.file.mode  The mode with which to write the file. If download.file.mode is not found
#' and the operating system is windows, it will use the "wb".
#' @param ... Others arguments of the \code{\link[utils:download.file]{download.file}} function.
#'
#' @details
#' The function downloads files available in the repository of transparency portal -
#' website of the federal government of Brazil on public transparency, with budgetary
#' data and government management. The data disclosed in the Portal come from various
#' sources of government information. See http://www.portaltransparencia.gov.br/.
#'
#' The function arguments are specifications about the data set to be downloaded.
#' 'opendata' is related to the content of the data, 'reference' to the date of
#' availability of the file in the portal, 'destfile' to the location to be saved and
#' 'filename' is the name of the file to be saved.
#' Other '...' arguments are related to the download.file function of the 'utils' package.
#'
#' It is suggested that the values for '...' be reported only if the default setting
#' does not work. See \code{\link[utils:download.file]{download.file}} for more
#' information about these arguments and proxy settings.
#'
#' Valid options for 'opendata' and 'reference' arguments:
#'
#' \tabular{lllll}{
#' id \tab description                                         \tab opendata                 \tab reference       \cr
#' 1  \tab Bolsa familia pagamentos                            \tab bolsa-familia-pagamentos \tab yyyymm          \cr
#' 2  \tab Bolsa familia saques                                \tab bolsa-familia-saques     \tab yyyymm          \cr
#' 3  \tab Erradicacao do trabalho infantil PETI               \tab peti                     \tab yyyymm          \cr
#' 4  \tab Garantia safra                                      \tab garantia-safra           \tab yyyymm          \cr
#' 5  \tab Seguro defeso pescador artesanal                    \tab seguro-defeso            \tab yyyymm          \cr
#' 6  \tab Cartao pagamento compras centralizadas              \tab cpcc                     \tab yyyymm          \cr
#' 7  \tab Cartao pagamento da defesa civil CPDC               \tab cpdc                     \tab yyyymm          \cr
#' 8  \tab Cartao pagamento governo federal CPGF               \tab cpgf                     \tab yyyymm          \cr
#' 9  \tab Convenios                                           \tab convenios                \tab yyyymmdd        \cr
#' 10 \tab Documentos empenho, liquidacao e pagamento          \tab despesas                 \tab yyyymmdd        \cr
#' 11 \tab Execucao da despesa                                 \tab despesas-execucao        \tab yyyymm          \cr
#' 12 \tab Recursos transferidos                               \tab transferencias           \tab yyyymm          \cr
#' 13 \tab Imoveis funcionais                                  \tab imoveis-funcionais_md    \tab yyyymmdd        \cr
#' 14 \tab Imoveis funcionais                                  \tab imoveis-funcionais_mre   \tab yyyymmdd        \cr
#' 15 \tab Imoveis funcionais                                  \tab imoveis-funcionais_pr    \tab yyyymmdd        \cr
#' 16 \tab Imoveis funcionais                                  \tab imoveis-funcionais_spu   \tab yyyymmdd        \cr
#' 17 \tab Contratacoes                                        \tab compras                  \tab yyyymm          \cr
#' 18 \tab Licitacoes                                          \tab licitacoes               \tab yyyymm          \cr
#' 19 \tab Orcamento da despesa                                \tab orcamento-despesa        \tab yyyy            \cr
#' 20 \tab Execucao da receita                                 \tab receitas                 \tab yyyy            \cr
#' 21 \tab Empresas inidoneas e suspensas                      \tab ceis                     \tab yyyymmdd        \cr
#' 22 \tab Empresas punidas                                    \tab cnep                     \tab yyyymmdd        \cr
#' 23 \tab Entidades sem fins lucrativos impedidas             \tab cepim                    \tab yyyymmdd        \cr
#' 24 \tab Cadastro de expulsoes da administracao federal CEAF \tab ceaf                     \tab yyyymmdd        \cr
#' 25 \tab Dirigentes de empresas                              \tab dirigentes               \tab yyyymm          \cr
#' 26 \tab Servidores civis do executivo federal               \tab servidores_civis         \tab yyyymm          \cr
#' 27 \tab Servidores militares do executivo federal           \tab servidores_militares     \tab yyyymm          \cr
#' 28 \tab Viagens a servico                                   \tab viagens                  \tab yyyy
#' }
#'
#' @examples
#' potr_download(opendata = 19, reference = 2019)
#' potr_download(opendata = 19, reference = 2019, destfile = "~/")
#' potr_download(opendata = 19, reference = 2019, destfile = "~/", filename = "orcamento")
#' potr_download(opendata = "19", reference = "2019")
#' potr_download(opendata = "19", reference = "2019", destfile = "~/")
#' potr_download(opendata = "19", reference = "2019", destfile = "~/", filename = "orcamento")
#' potr_download(opendata = "orcamento-despesa", reference = "2019")
#' potr_download(opendata = "orcamento-despesa", reference = 2019, destfile = "~/")
#' potr_download(opendata = "orcamento-despesa", reference = 2019, destfile = "~/", filename = "orcamento")
#' @export
potr_download <- function(opendata, reference, destfile, filename, download.file.mode, ...) {
  if (missing(opendata) || missing(reference)) {
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)}
  if (any(opendata == potrdt$dataset)) {
    potrdt <- potrdt[which(potrdt$dataset == opendata), ]
  } else if (any(as.character(opendata) == potrdt$id)) {
    potrdt <- potrdt[potrdt$id == as.numeric(opendata), ]
  } else {
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)}
  if (!nchar(reference) == nchar(potrdt$formatdate)) {
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)}
  if (missing(filename)) {
    filename <- paste0(potrdt$dataset, "_", reference, ".zip")
  } else if (!grepl(pattern = ".zip*", x = filename)) {
    filename <- paste0(filename, ".zip")}
  if (missing(destfile)) {
    destfile <- filename
  } else {
    if (grepl("/", substr(destfile, nchar(destfile), nchar(destfile)))) {
      destfile <- paste0(destfile, filename)
    } else {
      destfile <- paste0(destfile, "/", filename)}
  }
  potrurl <-
    paste0(
      potrurl,
      unlist(strsplit(potrdt$dataset, split = "_"))[1],
      "/",
      reference,
      ifelse(potrdt$subitem == "", "", paste0("_", potrdt$subitem)))
  if (missing(download.file.mode) && Sys.info()["sysname"] == "Windows") {
    download.file.mode <- "wb"}
  download.file(url = potrurl, destfile = destfile, mode = download.file.mode, ...)
  invisible(potrurl)
}
