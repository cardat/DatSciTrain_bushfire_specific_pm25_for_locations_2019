library(terra)
library(data.table)


# INPUTS ------------------------------------------------------------------

# Study location coordinates
infile.locations <- "data_provided/location_crds.csv"

# predicted PM2.5 and STL NetCDF
infile.pm25 <- "data_provided/bushfiresmoke_subset_v1_3_2019_compressed_20231130_7.nc"

# statistical thresholds for flags (95th percentile; SD of trimmed remainder component)
infile.p95 <- "data_provided/bushfiresmoke_v1_3_2001_2020_pm25_pred_p95.nc"
infile.sd_rem <- "data_provided/bushfiresmoke_v1_3_2001_2020_remainder_trimmed_stdev.nc"



# STUDY LOCATION ----------------------------------------------------------

## Select study location
locations <- read.csv(infile.locations)
locations

# Choose a location to display time-series data
select_loc <- "Hobart"

# Format as vector data with terra package
crds <- locations[locations$name == select_loc, ]
v_loc <- vect(crds, geom = c("x", "y"), crs = "epsg:4283")



# READ PM2.5 --------------------------------------------------------------

## Read NetCDF file with terra --------------------------------------------
# See PM2.5, STL decomposition and statistical flags
r_sds <- sds(infile.pm25)
r_sds

# Read thresholds for calculating statistical flags
r.p95 <- rast(infile.p95)
r.sd_rem <- rast(infile.sd_rem)


## Show PM2.5 rasters for chosen time period ------------------------------
dds <- seq(as.Date("2019-12-18"),
           as.Date("2019-12-25"),
           by = "days")

# Read PM2.5 layer from sds and subset by time
r.pm25 <- r_sds["pm25_pred"]
r_plt <- r.pm25[[which(time(r.pm25) %in% dds)]]

# Plot
r_plt <- project(r_plt, "epsg:4283")
panel(r_plt, col = map.pal("reds"), background = "grey90")



# Replicate plot (subset) from paper --------------------------------------

## Extract timeseries data for study location -----------------------------

## predicted PM2.5 and flags
vars_toget <- c("pm25_pred", "trend", "seasonal", "remainder", "smoke_p95_v1_3", "trimmed_smoke_2SD_v1_3")
loc.pm25 <- lapply(vars_toget, function(i){
  r <- r_sds[i]
  e <- terra::extract(r, terra::project(v_loc, r), ID = F)
  e <- as.data.frame(t(e))
  names(e) <- i
  row.names(e) <- NULL
  
  e$date <- time(r)
  return(e)
})
loc.pm25 <- Reduce(function(x,y) merge(x, y, by = "date"), loc.pm25)

## statistical thresholds
# 95pth percentile (PM2.5 2001-2020)
loc.p95 <- terra::extract(r.p95, terra::project(v_loc, r.p95), ID = F)[[1]]

# 95pth percentile (PM2.5 2001-2020)
loc.sd_rem <- terra::extract(r.sd_rem, terra::project(v_loc, r.sd_rem), ID = F)[[1]]


str(loc.pm25)
summary(loc.pm25)
loc.p95
loc.sd_rem


## Plot with p95 flag -----------------------------------------------------
## Identify probable bushfire days when exceeds 95th percentile
# total PM2.5
plot(loc.pm25$date, loc.pm25$pm25_pred, 
     col = "grey70", type = "l",
     main = select_loc,
     xlab = "Date", ylab = expression("PM"[2.5]*" (µg/m"^3*")")
     )
# add background PM2.5 (trend + seasonal components)
lines(loc.pm25$date, loc.pm25$seasonal + loc.pm25$trend, 
      col = "blue", lty = 2)
# add threshold for identification (95th percentile)
abline(h=loc.p95, col = "red")
# add points showing probable smoke-affected days
points(loc.pm25[loc.pm25$smoke_p95_v1_3 == 1, c("date", "pm25_pred")],
       col = "red", pch = 16)
legend(
  "topleft",
  legend = c(
    expression("daily PM"[2.5]),
    "seasonal + trend",
    expression("95th percentile PM"[2.5]),
    "probable smoke (flag_p95)"
  ),
  lty = c(1, 2, 1, NA),
  pch = c(NA, NA, NA, 16),
  col = c("grey70", "blue", "red", "red")
)


## Plot with 2SD_remainder flag -----------------------------------------------------
plot(loc.pm25$date, loc.pm25$pm25_pred, 
     col = "grey70", type = "l",
     main = select_loc,
     xlab = "Date", ylab = expression("PM"[2.5]*" (µg/m"^3*")")
)
# add background PM2.5 (trend + seasonal components)
lines(loc.pm25$date, loc.pm25$seasonal + loc.pm25$trend, 
      col = "blue", lty = 2)
# add threshold for identification (2*SD(remainder) above background)
lines(loc.pm25$date, (loc.pm25$seasonal + loc.pm25$trend + 2*loc.sd_rem), 
      col = "green")
# add points showing probable smoke-affected days
points(loc.pm25[loc.pm25$trimmed_smoke_2SD_v1_3 == 1, c("date", "pm25_pred")],
       col = "blue", pch = 17)
legend(
  "topleft",
  legend = c(
    expression("daily PM"[2.5]),
    "seasonal + trend",
    "2SD remainder + seasonal + trend",
    "probable smoke (flag_2SD_remainder)"
  ),
  lty = c(1, 2, 1, NA),
  pch = c(NA, NA, NA, 17),
  col = c("grey70", "blue", "green", "blue")
)

