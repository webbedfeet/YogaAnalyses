ProjTemplate::reload()
library(zdeviceR)
# Nicole analysis -----------------------------------------------------------------------------

dat <- readRDS('data/raw/Nicole.rds')

d1 = dat$Sound %>% filter(Time < 3000)
params = yaml::read_yaml('_config_audio.yml')
signal <- AudioProcessing(d1, params = params)
signal$Mins <- signal$Time / 60


# Downsampling for visualization (to be included in zdeviceR) ---------------------------------

## Downsample to capture every 16th observation
dsample <- seq(1, 255, by=16)
secs = sort(unique(floor(signal$Time)))
nsecs <- length(secs)
indx <- rep(256*secs, rep(16, nsecs)) + rep(dsample, nsecs)
sig2 <- signal[indx,]

plot(signal~Mins, data = sig2, type='l')

pks = find_peaks(sig2$signal, m = 24)
sig2$Time[pks]
abline(v = sig2$Mins[pks], lty=2)
