## ----message=FALSE------------------------------------------------------------
library(tidyverse)
library(moderndive)
library(infer)




## ----echo=-1------------------------------------------------------------------
almonds_bowl <- read_rds("rds/almonds_bowl.rds")
almonds_bowl |> 
  summarize(population_mean = mean(weight), 
            population_sd = sd(weight))


## ----echo=FALSE---------------------------------------------------------------
almonds_bowl <- read_rds("rds/almonds_bowl.rds")
if (!file.exists("rds/almonds_sample_100.rds")) {
  set.seed(20)
  almonds_sample_100 <- almonds_bowl |>
    rep_slice_sample(n = 100, replace = TRUE, reps = 1)
  write_rds(almonds_sample_100, "rds/almonds_sample_100.rds")
} else {
  almonds_sample_100 <- read_rds("rds/almonds_sample_100.rds")
}
almonds_sample_100


## -----------------------------------------------------------------------------
almonds_sample_100 |> 
  summarize(mean_weight = mean(weight), 
            sd_weight = sd(weight), 
            sample_size = n())






## -----------------------------------------------------------------------------
pnorm(1)


## ----normal-curve-shaded-1----------------------------------------------------
 ggplot(NULL, aes(c(-4,4))) +
  geom_area(stat = "function", fun = dnorm, fill = "grey50", xlim = c(-4, 1)) +
  geom_area(stat = "function", fun = dnorm, fill = "grey100", xlim = c(1, 4)) +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = 1)


## ----normal-curve-shaded-2----------------------------------------------------
 ggplot(NULL, aes(c(-4,4))) +
  geom_area(stat = "function", fun = dnorm, fill = "grey100", xlim = c(-4, -1)) +
    geom_area(stat = "function", fun = dnorm, fill = "grey80", xlim = c(-1, 1)) +
  geom_area(stat = "function", fun = dnorm, fill = "grey100", xlim = c(1, 4)) +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = c(-1,1))


## -----------------------------------------------------------------------------
pnorm(1) - pnorm(-1)


## -----------------------------------------------------------------------------
pnorm(2) - pnorm(-2)


## -----------------------------------------------------------------------------
qnorm(0.84)


## ----normal-curve-shaded-3----------------------------------------------------
 ggplot(NULL, aes(c(-4,4))) +
  geom_area(stat = "function", fun = dnorm, fill = "grey100", xlim = c(-4, -2)) +
    geom_area(stat = "function", fun = dnorm, fill = "grey80", xlim = c(-2, 2)) +
  geom_area(stat = "function", fun = dnorm, fill = "grey100", xlim = c(2, 4)) +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = NULL) + 
  annotate(geom="text", x=2, y=-0.01, label="q",
              color="blue")


## -----------------------------------------------------------------------------
q <- qnorm(0.975)
q


## -----------------------------------------------------------------------------
qnorm(0.99)




## -----------------------------------------------------------------------------
almonds_bowl |> 
  summarize(sigma = sd(weight))
almonds_sample_100 |> 
  summarize(mean_weight = mean(weight),
            sample_size = n())


## -----------------------------------------------------------------------------
xbar <- 3.682 
se_xbar <- 0.392/sqrt(100)
lower_bound <- xbar - 1.96 *  se_xbar
upper_bound <- xbar + 1.96 *  se_xbar
c(lower_bound, upper_bound)




## -----------------------------------------------------------------------------
almonds_sample_100 |> 
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight),
            sample_size = n())


## -----------------------------------------------------------------------------
qt(0.975, df = 100 - 1)


## -----------------------------------------------------------------------------
xbar <- 3.682 
se_xbar <- 0.362/sqrt(100)
lower_bound <- xbar - 1.98 *  se_xbar
upper_bound <- xbar + 1.98 *  se_xbar
c(lower_bound, upper_bound)




















## ----eval=FALSE---------------------------------------------------------------
## almonds_sample %>%
##   rep_sample_n(size = 50, replace = TRUE, reps = 1000)


## ----eval=FALSE---------------------------------------------------------------
## almonds_sample %>%
##   rep_sample_n(size = 50, replace = TRUE, reps = 1000) %>%
##   group_by(replicate)


## ----eval=FALSE---------------------------------------------------------------
## almonds_sample %>%
##   rep_sample_n(size = 50, replace = TRUE, reps = 1000) %>%
##   group_by(replicate) %>%
##   summarize(mean_weight = mean(weight))


## ----eval=FALSE---------------------------------------------------------------
## almonds_sample %>%
##   summarize(stat = mean(weight))


## ----eval=FALSE---------------------------------------------------------------
## almonds_sample %>%
##   specify(response = weight) %>%
##   calculate(stat = "mean")




## -----------------------------------------------------------------------------
almonds_sample %>% 
  specify(response = weight)


## ----eval=FALSE---------------------------------------------------------------
## almonds_sample %>%
##   specify(formula = weight ~ NULL)




## ----eval=FALSE---------------------------------------------------------------
## almonds_sample %>%
##   specify(response = weight) %>%
##   generate(reps = 1000, type = "bootstrap")








## ----eval=FALSE---------------------------------------------------------------
## bootstrap_distribution <- almonds_sample %>%
##   specify(response = weight) %>%
##   generate(reps = 1000) %>%
##   calculate(stat = "mean")
## bootstrap_distribution








## ----eval=FALSE---------------------------------------------------------------
## visualize(bootstrap_distribution)








## -----------------------------------------------------------------------------
percentile_ci <- bootstrap_distribution %>% 
  get_confidence_interval(level = 0.95, type = "percentile")
percentile_ci


## ----eval=FALSE---------------------------------------------------------------
## visualize(bootstrap_distribution) +
##   shade_confidence_interval(endpoints = percentile_ci)




## ----eval=FALSE---------------------------------------------------------------
## visualize(bootstrap_distribution) +
##   shade_ci(endpoints = percentile_ci, color = "hotpink", fill = "khaki")


## -----------------------------------------------------------------------------
standard_error_ci <- bootstrap_distribution %>% 
  get_confidence_interval(type = "se", point_estimate = x_bar)
standard_error_ci


## ----eval=FALSE---------------------------------------------------------------
## visualize(bootstrap_distribution) +
##   shade_confidence_interval(endpoints = standard_error_ci)








## -----------------------------------------------------------------------------
mythbusters_yawn




## -----------------------------------------------------------------------------
mythbusters_yawn %>% 
  group_by(group, yawn) %>% 
  summarize(count = n())




## ----eval=FALSE---------------------------------------------------------------
## mythbusters_yawn %>%
##   specify(formula = yawn ~ group)


## -----------------------------------------------------------------------------
mythbusters_yawn %>% 
  specify(formula = yawn ~ group, success = "yes")


## -----------------------------------------------------------------------------
first_six_rows <- head(mythbusters_yawn)
first_six_rows


## -----------------------------------------------------------------------------
first_six_rows %>% 
  sample_n(size = 6, replace = TRUE)


## ----eval=FALSE---------------------------------------------------------------
## mythbusters_yawn %>%
##   specify(formula = yawn ~ group, success = "yes") %>%
##   generate(reps = 1000, type = "bootstrap")




## ----eval=FALSE---------------------------------------------------------------
## mythbusters_yawn %>%
##   specify(formula = yawn ~ group, success = "yes") %>%
##   generate(reps = 1000, type = "bootstrap") %>%
##   calculate(stat = "diff in props")


## ----eval=FALSE---------------------------------------------------------------
## bootstrap_distribution_yawning <- mythbusters_yawn %>%
##   specify(formula = yawn ~ group, success = "yes") %>%
##   generate(reps = 1000, type = "bootstrap") %>%
##   calculate(stat = "diff in props", order = c("seed", "control"))
## bootstrap_distribution_yawning




## ----eval=FALSE---------------------------------------------------------------
## visualize(bootstrap_distribution_yawning) +
##   geom_vline(xintercept = 0)



## -----------------------------------------------------------------------------
bootstrap_distribution_yawning %>% 
  get_confidence_interval(type = "percentile", level = 0.95)



## -----------------------------------------------------------------------------
obs_diff_in_props <- mythbusters_yawn %>% 
  specify(formula = yawn ~ group, success = "yes") %>% 
  # generate(reps = 1000, type = "bootstrap") %>% 
  calculate(stat = "diff in props", order = c("seed", "control"))
obs_diff_in_props


## -----------------------------------------------------------------------------
myth_ci_se <- bootstrap_distribution_yawning %>% 
  get_confidence_interval(type = "se", point_estimate = obs_diff_in_props)
myth_ci_se

