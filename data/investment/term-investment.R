#!/usr/bin/env RScript

library(hash)

stock <- read.csv("/Users/jinbin/lifebook/data/investment/term-investment.csv")

print("2017年定期投资总投入: ")
print(sum(stock$money[stock$money > 0]))
print("2017年定期投资总回报: ")
print(-sum(stock$money[stock$money < 0]))
