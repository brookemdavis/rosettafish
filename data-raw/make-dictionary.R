library(dplyr)
rosetta_terms <- as.data.frame(readr::read_csv("inst/extdata/terms.csv"))

# # read in my terms
# new_terms <- read.csv("R:/SCIENCE/Chinook_QAMS_program/5Yr_Review/5Year_Review_Revisions_InProgress/French Fig Labels.csv", encoding = "UTF-8")
# names(new_terms)[1] <- "english"
#
# rosetta_terms <- full_join(rosetta_terms, new_terms)

language <- "english"
rosetta_terms <- rosetta_terms[order(rosetta_terms[[language]]), , drop = FALSE]
row.names(rosetta_terms) <- NULL
readr::write_csv(rosetta_terms, "inst/extdata/terms.csv")

df <- rosetta_terms
df$english <- tolower(df$english)
df$french <- tolower(df$french)
df$inuktitut <- tolower(df$inuktitut)

#dups <- union(which(duplicated(df$english)), which(duplicated(df$french)))
dups <- which(duplicated(df$english))

if(length(dups>0)){
  stop("The following lines have duplicates: ", paste(sort(dups) + 1, collapse = ", "))
}

usethis::use_data(rosetta_terms, overwrite = TRUE, internal = TRUE)

devtools::install(quick = TRUE, dependencies = FALSE)

