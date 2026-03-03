## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    eval = identical(Sys.getenv("NOT_CRAN"), "true"), 
    fig.width = 7,
    fig.height = 5,
    warning = FALSE,
    message = FALSE
)

# Sys.setenv("_R_USE_PIPEBIND_" = TRUE)

## -----------------------------------------------------------------------------
# box::use(
#     kindling[train_nn, act_funs, args],
#     recipes[
#         recipe, step_dummy, step_normalize,
#         all_nominal_predictors, all_numeric_predictors
#     ],
#     rsample[initial_split, training, testing],
#     yardstick[metric_set, rmse, rsq, accuracy, mn_log_loss],
#     dplyr[mutate, select],
#     tibble[tibble]
# )

## ----linear-data--------------------------------------------------------------
# set.seed(42)
# split = initial_split(mtcars, prop = 0.8)
# train = training(split)
# test = testing(split)
# 
# rec = recipe(mpg ~ ., data = train) |>
#     step_normalize(all_numeric_predictors())

## ----linear-fit---------------------------------------------------------------
# lm_nn = train_nn(
#     mpg ~ .,
#     data = train,
#     hidden_neurons = c(),
#     loss = torch::nnf_l1_loss,
#     optimizer = "rmsprop",
#     learn_rate = 0.01,
#     epochs = 200,
#     verbose = FALSE
# )
# 
# lm_nn

## ----linear-eval--------------------------------------------------------------
# preds = predict(lm_nn, newdata = test)
# 
# tibble(
#     truth = test$mpg,
#     estimate = preds
# ) |>
#     metric_set(rmse, rsq)(truth = truth, estimate = estimate)

## ----linear-compare-----------------------------------------------------------
# lm_fit = lm(mpg ~ ., data = train)
# 
# tibble(
#     truth = test$mpg,
#     estimate = predict(lm_fit, newdata = test)
# ) |>
#     metric_set(rmse, rsq)(truth = truth, estimate = estimate)

## ----binary-data--------------------------------------------------------------
# data("Sonar", package = "mlbench")
# 
# sonar = Sonar
# set.seed(42)
# split_s = initial_split(sonar, prop = 0.8, strata = Class)
# train_s = training(split_s)
# test_s = testing(split_s)
# 
# rec_s = recipe(Class ~ ., data = train_s) |>
#     step_normalize(all_numeric_predictors())

## ----binary-fit---------------------------------------------------------------
# logit_nn = train_nn(
#     Class ~ .,
#     data = train_s,
#     hidden_neurons = c(),
#     loss = "cross_entropy",
#     optimizer = "adam",
#     learn_rate = 0.01,
#     epochs = 200,
#     verbose = FALSE
# )
# 
# logit_nn

## ----binary-eval--------------------------------------------------------------
# preds_s = predict(logit_nn, newdata = test_s, type = "response")
# 
# tibble(
#     truth = test_s$Class,
#     estimate = preds_s
# ) |>
#     accuracy(truth = truth, estimate = estimate)

## ----logit-compare------------------------------------------------------------
# box::use(nnet[multinom])
# 
# glm_fit = glm(Class ~ ., data = train_s, family = binomial())
# 
# tibble(
#     truth = test_s$Class,
#     estimate = {
#         as.factor({
#             preds = predict(glm_fit, newdata = test_s, type = "response")
#             ifelse(preds < 0.5, "M", "R")
#         })
#     }
# ) |>
#     accuracy(truth = truth, estimate = estimate)

