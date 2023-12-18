# library(here)

raw = read.csv(here::here("00-data", "a-raw", "Raw Sample Data Undersize - RERUN - 30NOV2023.csv"))

### test

plot(raw$size, raw$S470, log = 'x')
plot(raw$size, raw$TD, log = 'x')

library(npreg)

mod.ss <- ss(raw$size, raw$S470, nknots = 10)
mod.ss

#####

mod.smsp <- smooth.spline(raw$size, raw$TD2, nknots = 50)
mod.smsp
str(mod.smsp)

plot(raw$size, raw$TD2, log = 'x')
lines( mod.smsp$x, mod.smsp$y, lty = 3, col = 3, lwd = 2)

malvern_bins = c(0.01,	0.0114,	0.0129,	0.0147,	0.0167,	0.0189,	0.0215,	0.0244,	0.0278,	0.0315,	0.0358,	0.0407,	0.0463,	0.0526,	0.0597,	0.0679,	0.0771,	0.0876,	0.0995,	0.113, 0.128,	0.146,	0.166,	0.188,	0.214,	0.243,	0.276,	0.314,	0.357,	0.405,	0.46,	0.523,	0.594,	0.675,	0.767,	0.872,	0.991,	1.13,	1.28,	1.45,	1.65,	1.88,	2.13,	2.42,	2.75,	3.12,	3.55,	4.03,	4.58,	5.21,	5.92,	6.72,	7.64,	8.68,	9.86,	11.2,	12.7,	14.5,	16.4,	18.7,	21.2,	24.1,	27.4,	31.1,	35.3,	40.1,	45.6,	51.8,	58.9,	66.9,	76,	86.4,	98.1,	111, 127,	144,	163,	186,	211,	240,	272,	310,	352,	400,	454,	516,	586,	666,	756,	859,	976,	1110,	1260,	1430,	1630,	1850,	2100,	2390,	2710,	3080,	3500)

pred = predict(mod.smsp, malvern_bins)
str(pred)

points(pred$x, pred$y, col = 2)

#####

predall = pred

predall.dat = as.data.frame(predall)

#####

predall.dat = cbind(predall.dat, pred$y)

#####

write.csv(predall.dat, "predall.csv")

