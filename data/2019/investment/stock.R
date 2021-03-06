#!/usr/bin/env RScript

library(hash)

stock <- read.csv("/Users/jinbin/lifebook/data/2018/investment/stock.csv")

sum <- 0
h_last_price = hash()
stock_list <- stock$stock[stock$date == "2017-12-30"]
for(x in 1:length(stock$date)){
  if(stock$date[x] == "2017-12-30"){
    sum = sum + stock$share[x] * stock$price[x]
    .set(h_last_price, gsub(" ", "", stock_list[x]), stock$price[x])
  }
}
print(paste("2017年年底本金: ", sum, seq=""))

add <- 0
for(x in 1:length(stock$date)){
  if(stock$date[x] != "2017-12-30"){
    if(stock$share[x] > 0){
      add = add + stock$share[x] * stock$price[x]
    }
  }
}
print(paste("2018年新增资金: ", add, seq=""))
print(paste("目前总投入资金: ", add + sum, seq=""))

#获取每种stock的current_share
h_current_share = hash()
for(i in 1:length(stock_list)){
  .set(h_current_share, gsub(" ", "", stock_list[i]), sum(stock$share[stock$stock == stock_list[i]]))
}

#获取每种stock的current_price
h_current_price = hash()
for(x in 1:length(stock$date)){
  if(stock$date[x] == "N/A"){
    .set(h_current_price, gsub(" ", "", stock$stock[x]), stock$price[x])
  }
}

#.set(h_current_price, keys = stock$stock[stock$date == "N/A"], values = stock$price[stock$date == "N/A"])

#获取每种stock的current_market_value
current_sum <- 0
print("2018年目前持股情况: ")
for(i in 1:length(stock_list)){
  if(h_current_share[[gsub(" ", "", as.character(stock_list[i]))]] != 0){
    current_price <- as.numeric(h_current_price[[gsub(" ", "", as.character(stock_list[i]))]])
    current_share <- as.numeric(h_current_share[[gsub(" ", "", as.character(stock_list[i]))]])
    last_price <- as.numeric(h_last_price[[gsub(" ", "", as.character(stock_list[i]))]])
    
    print(paste(stock_list[i], "持有股数: ", current_share, seq=""))
    print(paste(stock_list[i], "每股现价: ", current_price, seq=""))
    if(last_price != 0){    
      print(paste(stock_list[i], "每股涨幅(跌幅): ", strtrim((current_price - last_price)/last_price * 100, 5), "%", seq=""))
    }
    current_sum = current_sum + current_price * current_share
  }
}

current_value <- current_sum
print(paste("2018年当前持股市值: ", current_value, seq=""))

for(x in 1:length(stock$date)){
  if(stock$share[x] < 0){
    current_sum = current_sum - stock$share[x] * stock$price[x]
  }
}

cash <- 0
for(x in 1:length(stock$date)){
  if(stock$share[x] < 0){
     cash = cash - stock$share[x] * stock$price[x]
  }
}

print(paste("2018年净流入: ", add - cash, seq=""))

profit <- current_sum - add - sum
print(paste("2018年总盈利(亏损): ", profit, seq=""))

growth_rate <- (current_sum - add - sum) / (add + sum - cash) * 100
print(paste("整体增长(下降)率: ", strtrim(growth_rate, 5), "%", seq=""))

