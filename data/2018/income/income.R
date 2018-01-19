#!/usr/bin/env RScript

target <- 45000

cal <- function(source){
  file <- paste("/Users/jinbin/lifebook/data/2018/income/", source, ".csv", sep="")
  source_data <- read.csv(file)

  line <- paste("2018年", source, "笔数: ", sep="")
  print(line)
  print(length(source_data$money))
  print("总收入: ")
  print(sum(source_data$money))
  print("平均笔单价: ")
  print(mean(source_data$money))

  return(sum(source_data$money))
}

sum = cal("income")

print("2018年PartTime总收入: ")
print(sum)
print("完成度: ")
obj <- paste(round(sum / target * 100, 2), "%")
print(obj)
