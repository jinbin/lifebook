#!/usr/bin/env Rscript

cal <- function(source){
  file <- paste("/Users/jinbin/lifebook/data/income/", source, ".csv", sep="")
  source_data <- read.csv(file)

  line <- paste("2017年", source, "次数: ", sep="")
  print(line)
  print(length(source_data$money))
  print("总收入: ")
  print(sum(source_data$money))
  print("平均客单价: ")
  print(mean(source_data$money))

  return(sum(source_data$money))
}

sum1 = cal("顺风车")
sum2 = cal("快车")
sum3 = cal("刷单")

print("2017年PartTime总收入: ")
print(sum1 + sum2 + sum3)
