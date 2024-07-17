library(readxl)
library(dplyr)
library(tidyr)
file_path <- "data/SchoolAccident_2019~2023.xlsx"

sheet_names <- c("2019", "2020", "2021", "2022", "2023")
data_frames <- list()

for (sheet in sheet_names) {
  data_frames[[sheet]] <- read_excel(file_path, sheet = sheet)
}

df_2019 <- data_frames[["2019"]]
df_2020 <- data_frames[["2020"]]
df_2021 <- data_frames[["2021"]]
df_2022 <- data_frames[["2022"]]
df_2023 <- data_frames[["2023"]]

accident_counts <- list()
for (year in sheet_names) {
  accident_counts[[year]] <- data_frames[[year]] %>%
    group_by(사고장소) %>%
    summarise(count = n()) %>%
    mutate(year = year)
}

print(accident_counts[["2023"]])

accident_counts[["2023"]] <- accident_counts[["2023"]] %>%
  mutate(사고장소 = ifelse(사고장소 == "교외", "교외활동", 사고장소))

combined_data <- bind_rows(accident_counts)

# wide format 변환
wide_data <- combined_data %>%
  spread(key = year, value = count, fill = 0)

# 장소별로 꺾은선 그래프
unique_places <- unique(combined_data$사고장소)
years <- as.numeric(sheet_names)

plot(years, rep(0, length(years)), type = "n", ylim = c(0, max(wide_data[, -1], na.rm = TRUE)),
     xlab = "년도", ylab = "사고 횟수", main = "사고 장소별 사고 횟수 변화 추이 (2019-2023)")

colors <- rainbow(length(unique_places))

for (i in 1:length(unique_places)) {
  place <- unique_places[i]
  counts <- wide_data[wide_data$사고장소 == place, -1]
  lines(years, counts, type = "o", col = colors[i], pch = 16)
}

legend("topleft", legend = unique_places, col = colors, pch = 16, title = "사고 장소")