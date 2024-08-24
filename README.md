# SSUL+
**Subject**
공공데이터포털과 학교안전공제중앙회의 데이터를 이용하여 학교 안전사고 분석  
**Developer**
김도윤  
**Used Stack**
R  

# 필요한 라이브러리 불러오기
```
install.packages("readxl")  # readxl 패키지 설치  
install.packages("dplyr")    # dplyr 패키지 설치
install.packages("tidyr") # tidyr 패키지 설치
library(readxl)  # readxl 라이브러리 불러오기  
library(dplyr)   # dplyr 라이브러리 불러오기
library(tidyr) # tidyr 라이브러리 불러오기 
```

# 주요 데이터 수치  
**물리적힘 노출 분석 자료 - 학교안전공제중앙회_학교안전사고데이터**  
2019년 : 54844건  
2020년 : 16089건  
2021년 : 38622건  
2022년 : 64844건  
2023년 : 74451건  
  
**응급처치교육 분석 자료 - 소방청_대국민 응급처치교육 추진 실적**  
2018년 : 342331건 / 333054건  
2020년 : 72344건 / 71703건  
2021년 : 167418건 / 129397건  

# 분석 자료
![KakaoTalk_20240717_181613749](https://github.com/user-attachments/assets/0945008f-43eb-4e15-821b-60fdd279df2c)
![KakaoTalk_20240717_112305919](https://github.com/user-attachments/assets/f9030c0f-0cc0-42e7-96af-5df85b6e7991)  

# 사용 데이터 주소
학교안전공제중앙회_학교안전사고데이터 - https://www.xn--289axkt9l0mao04fs9c7wrl7hfxc.com/index.php    
소방청_대국민 응급처치교육 추진 실적 - https://www.data.go.kr/data/15063551/fileData.do  

