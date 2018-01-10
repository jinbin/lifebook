#!/usr/bin/env RScript

cal <- function(source){
  file <- paste("/Users/jinbin/lifebook/data/2018/income/", source, ".csv", sep="")
  source_data <- read.csv(file)

  line <- paste("2018年", source, "次数: ", sep="")
  print(line)
  print(length(source_data$money))
  print("总收入: ")
  print(sum(source_data$money))
  print("平均客单价: ")
  print(mean(source_data$money))

  return(sum(source_data$money))
}

sum1 = cal("income")

print("2018年PartTime总收入: ")
print(sum1)
