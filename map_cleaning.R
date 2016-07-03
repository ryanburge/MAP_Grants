
## I did a bunch of cleaning on this in excel before I read it into R. Just needed to get the important columns into numeric format. 
map <- read.csv("D:/MAP_Grants/map2.csv", stringsAsFactors = FALSE)

map$Payout <- gsub(',', '', map$Payout)
map$Payout <- gsub('\\$', '', map$Payout)
map$Awards <- gsub(',', '', map$Awards)
map$Awards <- as.numeric(map$Awards)
map$Payout <- as.numeric(map$Payout)
map$Payout[is.na(map$Payout)] <- 0

pub <- subset(map, Type == "Public-4 year")
pub4 <- aggregate(pub$Payout, list(pub$Year), sum)
pub2 <- subset(map, Type == "Public-2 year")
pub2 <- aggregate(pub2$Payout, list(pub2$Year), sum)
priv4 <- subset(map, Type == "Private-4 year")
priv4 <- aggregate(priv4$Payout, list(priv4$Year), sum)
priv2 <- subset(map, Type == "Private-2 year")
priv2 <- aggregate(priv2$Payout, list(priv2$Year), sum)
hosp <- subset(map, Type == "Hospital Schools")
hosp <- aggregate(hosp$Payout, list(hosp$Year), sum)
profit <- subset(map, Type == "For Profit")
profit <- aggregate(profit$Payout, list(profit$Year), sum)

pub4$Type <- c("Public-4 Year")
pub2$Type <- c("Public-2 Year")
priv2$Type <- c("Private-2 Year")
priv4$Type <- c("Private-4 Year")
profit$Type <- c("For Profit")
hosp$Type <- c("Hospital Schools")
all <- rbind(pub2, pub4, priv2, priv4, profit, hosp)
all$year <- all$Group.1
all$Group.1 <- NULL
all$amount <- all$x
all$x <- NULL

ggplot(data = all, aes(x = year, y = amount/1000, color = Type, label = Type)) + geom_line(aes(group = Type)) + geom_point()

ggplot(data = public, aes(x = Year, y = Payout/1000, color = Abb, label = Abb)) + geom_line(aes(group = Abb)) + geom_point()

p <- plot_ly(public, x = Year, y = Payout/1000, name = "Total Assets", color = Abb)
p

theme(text=element_text(size=16, family="Calibri"))




