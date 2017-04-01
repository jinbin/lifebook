
hitchhike <- read.csv("/Users/jinbin/lifebook/data/hitchhike.csv")

print("2017年顺风出行次数: ")
print(length(hitchhike$money))
print("总收入: ") 
print(sum(hitchhike$money))
print("平均客单价: ")
print(mean(hitchhike$money))

kuaiche <- read.csv("/Users/jinbin/lifebook/data/kuaiche.csv")

print("2017年快车出行次数: ")
print(length(kuaiche$money))
print("总收入: ") 
print(sum(kuaiche$money))
print("平均客单价: ")
print(mean(kuaiche$money))

shua <- read.csv("/Users/jinbin/lifebook/data/shua.csv")

print("2017年刷单次数: ")
print(length(shua$money))
print("总收入: ")
print(sum(shua$money))
print("平均客单价: ")
print(mean(shua$money))

print("2017年PartTime总收入: ")
print(sum(hitchhike$money) + sum(kuaiche$money) + sum(shua$money))
