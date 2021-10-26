library(dplyr)
library(data.table)
library(plotly)

# Read File Path
all_paths <- list.files(path = "Data/05/01",
                        full.names = TRUE)

# Read File Content
all_content <- all_paths %>% lapply(read.csv, header = FALSE) 

# Read File Name
all_filenames <- all_paths %>%
  basename() %>%
  as.list()

# Combine File Content List File Name List
all_lists <- mapply(c, all_content, all_filenames, SIMPLIFY = FALSE)

# Unlist All Lists Change Column Name
all_result <- rbindlist(all_lists, fill = TRUE)

sw_1 <- data.frame(all_lists[[1]]$V1)

for (i in 2:218) {
  sw_1 <- cbind(sw_1, all_lists[[i]]$V1)
}

fname <- c()

for (i in 1:218) {
  fname <- append(fname, all_lists[[i]][[2]])
}

fname <- as.Date(fname)

sw_1 <- data.frame(t(sw_1))

rownames(sw_1) <- fname

tablet <- data.frame(t(data.frame(table(sw_1[1]))$Freq))

for (i in 2:218) {
  tablet <- rbind(tablet, data.frame(table(sw_1[i]))$Freq)
}

colnames(tablet) <- data.frame(table(sw_1[1]))$Var1

tablet$date <- fname

fig <- plot_ly(tablet, x = ~date, y = ~-1, type = 'bar', name = 'Missing Value')
fig <- fig %>% add_trace(y = ~2.20778, name = 'Low Consumption')
fig <- fig %>% add_trace(y = ~4.33249, name = 'Medium Consumption')
fig <- fig %>% add_trace(y = ~6.45719, name = 'High Consumption')
fig <- fig %>% layout(yaxis = list(title = 'Count'), barmode = 'stack')

fig

colnames(tablet) <- c('Missing Value', 'Low', 'Medium', 'High', 'Date')

write.csv(tablet, file = 'tablet.csv')
