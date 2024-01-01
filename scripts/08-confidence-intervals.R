## ----message=FALSE------------------------------------------------------------
library(tidyverse)
library(moderndive)
library(infer)






## ----message=FALSE------------------------------------------------------------
library(tidyverse)
library(moderndive)
library(infer)








## ----percentile-method, echo=FALSE, message=FALSE, fig.cap="(ref:perc-method)", fig.height=3.4----
ggplot(virtual_resampled_means, aes(x = mean_weight)) +
  geom_histogram(binwidth = 1, color = "white", boundary = 1988) +
  labs(x = "Resample sample mean") +
  scale_x_continuous(breaks = seq(1988, 2006, 2)) +
  geom_vline(xintercept = percentile_ci[[1, 1]], size = 1) +
  geom_vline(xintercept = percentile_ci[[1, 2]], size = 1)




## -----------------------------------------------------------------------------
virtual_resampled_means %>% 
  summarize(SE = sd(mean_weight))




## ----eval=FALSE---------------------------------------------------------------
## standard_error_ci <- bootstrap_distribution %>%
##   get_ci(type = "se", point_estimate = x_bar)
## standard_error_ci






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
bowl %>% 
  summarize(p_red = mean(color == "red"))



## -----------------------------------------------------------------------------
bowl_sample_1




## ----eval=FALSE---------------------------------------------------------------
## bowl_sample_1 %>%
##   specify(response = color)


## -----------------------------------------------------------------------------
bowl_sample_1 %>% 
  specify(response = color, success = "red")


## ----eval=FALSE---------------------------------------------------------------
## bowl_sample_1 %>%
##   specify(response = color, success = "red") %>%
##   generate(reps = 1000, type = "bootstrap")



## ----eval=FALSE---------------------------------------------------------------
## sample_1_bootstrap <- bowl_sample_1 %>%
##   specify(response = color, success = "red") %>%
##   generate(reps = 1000, type = "bootstrap") %>%
##   calculate(stat = "prop")
## sample_1_bootstrap




## -----------------------------------------------------------------------------
percentile_ci_1 <- sample_1_bootstrap %>% 
  get_confidence_interval(level = 0.95, type = "percentile")
percentile_ci_1


## ----eval=FALSE---------------------------------------------------------------
## sample_1_bootstrap %>%
##   visualize(bins = 15) +
##   shade_confidence_interval(endpoints = percentile_ci_1) +
##   geom_vline(xintercept = 0.42, linetype = "dashed")




## -----------------------------------------------------------------------------
bowl_sample_2 <- bowl %>% rep_sample_n(size = 50)
bowl_sample_2


## ----eval=FALSE---------------------------------------------------------------
## sample_2_bootstrap <- bowl_sample_2 %>%
##   specify(response = color,
##           success = "red") %>%
##   generate(reps = 1000,
##            type = "bootstrap") %>%
##   calculate(stat = "prop")
## sample_2_bootstrap




## -----------------------------------------------------------------------------
percentile_ci_2 <- sample_2_bootstrap %>% 
  get_confidence_interval(level = 0.95, type = "percentile")
percentile_ci_2




















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






## ----echo=FALSE---------------------------------------------------------------
set.seed(76)


## ----sampling-distribution-part-deux, fig.show="hold", fig.cap="Previously seen sampling distribution of sample proportion red for $n = 1000$.", fig.height=2----
# Take 1000 virtual samples of size 50 from the bowl:
virtual_samples <- bowl %>% 
  rep_sample_n(size = 50, reps = 1000)
# Compute the sampling distribution of 1000 values of p-hat
sampling_distribution <- virtual_samples %>% 
  group_by(replicate) %>% 
  summarize(red = sum(color == "red")) %>% 
  mutate(prop_red = red / 50)
# Visualize sampling distribution of p-hat
ggplot(sampling_distribution, aes(x = prop_red)) +
  geom_histogram(binwidth = 0.05, boundary = 0.4, color = "white") +
  labs(x = "Proportion of 50 balls that were red", 
       title = "Sampling distribution")


## -----------------------------------------------------------------------------
sampling_distribution %>% summarize(se = sd(prop_red))



## ----echo=FALSE---------------------------------------------------------------
set.seed(76)


## ----eval=FALSE---------------------------------------------------------------
## bootstrap_distribution <- bowl_sample_1 %>%
##   specify(response = color, success = "red") %>%
##   generate(reps = 1000, type = "bootstrap") %>%
##   calculate(stat = "prop")






## -----------------------------------------------------------------------------
bootstrap_distribution %>% summarize(se = sd(stat))









## ----message=FALSE------------------------------------------------------------
conf_ints <- tactile_prop_red %>% 
  rename(p_hat = prop_red) %>% 
  mutate(
    n = 50,
    SE = sqrt(p_hat * (1 - p_hat) / n),
    MoE = 1.96 * SE,
    lower_ci = p_hat - MoE,
    upper_ci = p_hat + MoE
  )








## ----eval=FALSE---------------------------------------------------------------
## # First: Take 100 virtual samples of n=50 balls
## virtual_samples <- bowl %>%
##   rep_sample_n(size = 50, reps = 100)
## 
## # Second: For each virtual sample compute the proportion red
## virtual_prop_red <- virtual_samples %>%
##   group_by(replicate) %>%
##   summarize(red = sum(color == "red")) %>%
##   mutate(prop_red = red / 50)
## 
## # Third: Compute the 95% confidence interval as before
## virtual_prop_red <- virtual_prop_red %>%
##   rename(p_hat = prop_red) %>%
##   mutate(
##     n = 50,
##     SE = sqrt(p_hat*(1-p_hat)/n),
##     MoE = 1.96 * SE,
##     lower_ci = p_hat - MoE,
##     upper_ci = p_hat + MoE
##   )

