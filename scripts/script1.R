#wlaczenia bibliotek
library(tm)

#zmiana katakogu roboczego
workDir <- "D:\\212038\\PJN\\textMining12S"
setwd(workDir)

#definicja katakogow projectu
inputDir <- ".\\data"
outputDir <- ".\\results"
scriptDir <- ".\\scripts"

#utworzenia katalogu wyjsciowego
dir.create (outputDir, showWarning = FALSE)

#utworzenie korpusu dokumentow
corpusDir <- paste(
  inputDir,
  "\\",
  "Literatura - streszczenia - oryginał",
  sep=""
)
corpus <- VCorpus(
  DirSource(
    corpusDir,
    pattern ="*.txt",
    encoding = "UTF-8"
  ),
  readerControl = list(
    language = "pl_PL"
  )
)

#wtepne przetwarzanie
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))
stoplistFile <- paste(
  inputDir,
  "\\",
  "stopwords_pl.txt",
  sep=""
)
stoplist <- readLines(
  stoplistFile,
  encoding = "UTS=8"
)
corpus <- tm_map(corpus, removeWords, stoplist)
corpus <- tm_map(corpus, stripWhitespace)