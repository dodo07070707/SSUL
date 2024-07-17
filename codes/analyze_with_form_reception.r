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

# 연도별 사고 형태별 사고 횟수 계산
for (year in sheet_names) {
  yearly_data <- data_frames[[year]] %>%
    group_by(사고형태) %>%
    summarise(count = n()) %>%
    mutate(year = year)
  
  accident_counts[[year]] <- yearly_data
}

# 데이터프레임 병합
combined_data <- bind_rows(accident_counts)

# '낙상' 카테고리 통합
combined_data <- combined_data %>%
  mutate(사고형태 = case_when(
    사고형태 %in% c("낙상-넘어짐", "낙상-미끄러짐", "낙상-떨어짐") ~ "낙상",
    TRUE ~ 사고형태
  ))

# '물리적힘 노출' 데이터만 추출
physical_force_data <- combined_data %>%
  filter(사고형태 == "물리적힘 노출")

# wide format으로 변환
wide_data <- physical_force_data %>%
  pivot_wider(names_from = year, values_from = count, values_fill = list(count = 0))

# '물리적힘 노출' 데이터 그래프 그리기
years <- as.numeric(sheet_names)
counts <- as.numeric(wide_data[1, -1])

plot(years, counts, type = "o", col = "blue", pch = 16, ylim = c(0, max(counts, na.rm = TRUE)),
     xlab = "년도", ylab = "사고 횟수", main = "물리적힘 노출 사고 횟수 변화 추이 (2019-2023)")
