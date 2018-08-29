ProjTemplate::reload()
library(zdeviceR)

# Nicole’s data -------------------------------------------------------------------------------
datadir <- '~/Dropbox/Baabi_GarfieldDeviceDataDownload/Kashyap Data/Yoga data/'

files <- dir(datadir, pattern = 'txt' )

dat <- readData(file.path(datadir, files[1]))
dat2 <- calibrated_data(dat)
dat2 <- dat2 %>% dplyr::filter(Time < max(Time) - 10)
dygraphs::dygraph(dat2 %>% select(-Time) %>% select(Mins, everything()))

saveRDS(dat, file = 'data/raw/Nicole.rds', compress = T)
