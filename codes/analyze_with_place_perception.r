library(readxl)
library(dplyr)
library(tidyr)

file_path <- "data/SchoolAccident_2019~2023.xlsx"

sheet_names <- c("2019", "2020", "2021", "2022", "2023")
data_frames <- list()

for (sheet in sheet_names) {
  data_frames[[sheet]] <- read_excel(file_path, sheet = sheet)
}

accident_counts <- list()
total_counts <- list()

# 연도별 사고 장소별 사고 횟수 및 총 사고 횟수 계산
for (year in sheet_names) {
  yearly_data <- data_frames[[year]] %>%
    group_by(사고장소) %>%
    summarise(count = n()) %>%
    mutate(year = year)
  
  total_count <- yearly_data %>%
    summarise(total = sum(count)) %>%
    mutate(year = year)
  
  accident_counts[[year]] <- yearly_data
  total_counts[[year]] <- total_count
}

# 2023년 데이터의 "교외"를 "교외활동"으로 변경
accident_counts[["2023"]] <- accident_counts[["2023"]] %>%
  mutate(사고장소 = ifelse(사고장소 == "교외", "교외활동", 사고장소))

# 연도별 총 사고 횟수를 합치기
total_counts_df <- bind_rows(total_counts)

# 각 연도의 데이터에 총 사고 횟수를 합치고 비율 계산
for (year in sheet_names) {
  accident_counts[[year]] <- accident_counts[[year]] %>%
    left_join(total_counts_df, by = "year") %>%
    mutate(rate = count / total) %>%
    select(사고장소, year, rate)
}

# 데이터프레임 병합
combined_data <- bind_rows(accident_counts)

# 데이터프레임을 wide format으로 변환
wide_data <- combined_data %>%
  pivot_wider(names_from = year, values_from = rate, values_fill = list(rate = 0))

# 사고 장소별로 꺾은선 그래프 그리기
unique_places <- unique(combined_data$사고장소)
years <- as.numeric(sheet_names)

plot(years, rep(0, length(years)), type = "n", ylim = c(0, max(wide_data[, -1], na.rm = TRUE)),
     xlab = "년도", ylab = "사고 비율", main = "사고 장소별 사고 비율 변화 추이 (2019-2023)")

colors <- rainbow(length(unique_places))

for (i in 1:length(unique_places)) {
  place <- unique_places[i]
  rates <- as.numeric(wide_data[wide_data$사고장소 == place, -1])
  lines(years, rates, type = "o", col = colors[i], pch = 16)
}

legend("topleft", legend = unique_places, col = colors, pch = 16, title = "사고 장소")