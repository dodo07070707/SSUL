library(readxl)
library(dplyr)
library(tidyr)

firstaid_2018 <- read_excel("data/firstaid_2018.xlsx")
firstaid_2020 <- read_excel("data/firstaid_2020.xlsx")
firstaid_2021 <- read_excel("data/firstaid_2021.xlsx")

summarize_data <- function(data) {
  data %>% 
    summarise(
      elementary_count = sum(`초등`),
      midhighschool_count = sum(`중고등`)
    )
}

#수치 출력용
result_list <- list(
  firstaid_2018 = result_2018,
  firstaid_2020 = result_2020,
  firstaid_2021 = result_2021
)


years <- c("2018", "2020", "2021")
elementary_counts <- c(result_2018$elementary_count, result_2020$elementary_count, result_2021$elementary_count)
midhighschool_counts <- c(result_2018$midhighschool_count, result_2020$midhighschool_count, result_2021$midhighschool_count)

plot(1:length(years), elementary_counts, type = "l", col = "blue", ylim = range(0, max(elementary_counts, midhighschool_counts)),
     xlab = "Year", ylab = "Count", main = "Elementary and Mid/High School First Aid Education Cases (2018-2021)", 
     xaxt = "n")  # x 축 눈금을 나중에 추가할 것임

lines(1:length(years), midhighschool_counts, type = "l", col = "red")

axis(1, at = 1:length(years), labels = years)

legend("topright", legend=c("Elementary Count", "Mid/High School Count"), col=c("blue", "red"), lty=1, cex=0.8)

str(result_list)

