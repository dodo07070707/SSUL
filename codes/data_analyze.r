library(readxl)
library(dplyr)
library(ggplot2)
file_path <- "data/SchoolAccident_2019~2023.xlsx"

# 시트 이름 리스트
sheet_names <- c("2019", "2020", "2021", "2022", "2023")

# 빈 리스트를 생성하여 데이터프레임 저장
data_frames <- list()

# for 문을 사용하여 각 시트를 읽어오기
for (sheet in sheet_names) {
  data_frames[[sheet]] <- read_excel(file_path, sheet = sheet)
}

# 각 데이터프레임을 변수로 저장
df_2019 <- data_frames[["2019"]]
df_2020 <- data_frames[["2020"]]
df_2021 <- data_frames[["2021"]]
df_2022 <- data_frames[["2022"]]
df_2023 <- data_frames[["2023"]]

# 사고 장소별 사고 횟수 계산
accident_counts <- list()
for (year in sheet_names) {
  accident_counts[[year]] <- data_frames[[year]] %>%
    group_by(사고장소) %>%
    summarise(count = n()) %>%
    mutate(year = year)
}

combined_data <- bind_rows(accident_counts)

ggplot(combined_data, aes(x = year, y = count, group = 사고장소, color = 사고장소)) +
  geom_line() +
  geom_point() +
  labs(title = "사고 장소별 사고 횟수 변화 추이 (2019-2023)",
       x = "년도",
       y = "사고 횟수",
       color = "사고 장소") +
  theme_minimal()
