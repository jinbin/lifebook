#!/usr/bin/env RScript

library(hash)

stock <- read.csv("/Users/jinbin/lifebook/data/investment/股票.csv")

sum <- 0
h_last_price = hash()
for(x in 1:length(stock$date)){
  if(stock$date[x] == "2016-12-30"){
    sum = sum + stock$share[x] * stock$price[x]
    stock_list <- c(stock_list[1:x-1], gsub(" ", "", stock$stock[x]))
    .set(h_last_price, keys = gsub(" ", "", stock$stock[x]), values = gsub(" ", "", stock$price[x]))
  }
}
print(paste("2016年年底本金: ", sum, seq=""))

add <- 0
for(x in 1:length(stock$date)){
  if(stock$date[x] != "2016-12-30"){
    if(stock$share[x] > 0){
      add = add + stock$share[x] * stock$price[x]
    }
  }
}
print(paste("2017年新增资金: ", add, seq=""))
print(paste("2017年总投入资金: ", add + sum, seq=""))

#获取每种stock的current_share
h_current_share = hash()
for(i in 1:length(stock_list)){
  current_share <- 0
  for(x in 1:length(stock$date)){
    if(gsub(" ", "", stock$stock[x]) == stock_list[i]){
      current_share = current_share + stock$share[x]
    }
  }
  .set(h_current_share, keys = stock_list[i], values = current_share)
}

#获取每种stock的current_price
h_current_price = hash()
for(x in 1:length(stock$date)){
  if(stock$date[x] == "N/A"){
    .set(h_current_price, keys = gsub(" ", "", stock$stock[x]), values = stock$price[x])
  }
}

#获取每种stock的current_market_value
current_sum <- 0
print("2017年目前持股情况: ")
for(i in 1:length(stock_list)){
  if(h_current_share[[stock_list[i]]] != 0){
    print(paste(stock_list[i], "持有股数: ", h_current_share[[stock_list[i]]]), seq="")
    print(paste(stock_list[i], "每股现价: ", h_current_price[[stock_list[i]]]), seq="")
    print(paste(stock_list[i], "每股涨幅(跌幅): ", strtrim((as.numeric(h_current_price[[stock_list[i]]]) - as.numeric(h_last_price[[stock_list[i]]]))/as.numeric(h_last_price[[stock_list[i]]]) * 100, 5), "%", seq=""))
    current_sum = current_sum + h_current_share[[stock_list[i]]] * as.numeric(h_current_price[[stock_list[i]]])
  }
}
for(x in 1:length(stock$date)){
  if(stock$date[x] != "2016-12-30"){
    if(stock$share[x] < 0){
      current_sum = current_sum - stock$share[x] * stock$price[x]
    }
  }
}

print(paste("2017年总市值: ", current_sum, seq=""))

profit <- current_sum - add - sum
print(paste("2017年总盈利(亏损): ", profit, seq=""))

growth_rate <- (current_sum - add - sum) / (add + sum) * 100
print(paste("整体增长(下降)率: ", strtrim(growth_rate, 5), "%", seq=""))
