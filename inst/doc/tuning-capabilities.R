## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    # eval = identical(Sys.getenv("BUILD_VIGNETTES"), "true"), 
    eval = identical(Sys.getenv("NOT_CRAN"), "true"), 
    fig.width = 7,
    fig.height = 5,
    warning = FALSE,
    message = FALSE
)

## -----------------------------------------------------------------------------
# # library(kindling)
# # library(tidymodels)
# # library(modeldata)
# 
# box::use(
#     kindling[mlp_kindling, act_funs, args, hidden_neurons, activations, grid_depth],
#     dplyr[select, ends_with, mutate, slice_sample],
#     tidyr[drop_na],
#     rsample[initial_split, training, testing, vfold_cv],
#     recipes[
#         recipe, step_dummy, step_normalize,
#         all_nominal_predictors, all_numeric_predictors
#     ],
#     modeldata[penguins],
#     parsnip[tune, set_mode, fit, augment],
#     workflows[workflow, add_recipe, add_model],
#     dials[learn_rate],
#     tune[tune_grid, show_best, collect_metrics, select_best, finalize_workflow, last_fit],
#     yardstick[metric_set, rmse, rsq],
#     ggplot2[autoplot]
# )

## ----spec---------------------------------------------------------------------
# spec = mlp_kindling(
#     hidden_neurons = tune(),
#     activations = tune(),
#     epochs = 50,
#     learn_rate = tune()
# ) |>
#     set_mode("regression")

## ----data---------------------------------------------------------------------
# penguins_clean = penguins |>
#     drop_na() |>
#     select(body_mass_g, ends_with("_mm"), sex, species) |>
#     mutate(body_mass_kg = body_mass_g / 1000) |>
#     slice_sample(n = 30, by = species)
# 
# set.seed(123)
# split = initial_split(penguins_clean, prop = 0.8, strata = species)
# train = training(split)
# test = testing(split)
# folds = vfold_cv(train, v = 5, strata = body_mass_kg)
# 
# 
# rec = recipe(body_mass_kg ~ ., data = train) |>
#     step_dummy(all_nominal_predictors()) |>
#     step_normalize(all_numeric_predictors())

## ----grid---------------------------------------------------------------------
# set.seed(42)
# depth_grid = grid_depth(
#     hidden_neurons(c(16, 32)),
#     activations(c("relu", "elu", "softshrink(lambd = 0.2)")),
#     learn_rate(),
#     n_hlayer = 1:3,
#     size = 10,
#     type = "latin_hypercube"
# )
# 
# depth_grid

## ----tune---------------------------------------------------------------------
# wflow = workflow() |>
#     add_recipe(rec) |>
#     add_model(spec)
# 
# tune_res = tune_grid(
#     wflow,
#     resamples = folds,
#     grid = depth_grid,
#     metrics = metric_set(rmse, rsq)
# )

## ----results------------------------------------------------------------------
# collect_metrics(tune_res)
# show_best(tune_res, metric = "rmse", n = 5)

## ----final--------------------------------------------------------------------
# best_params = select_best(tune_res, metric = "rmse")
# final_wflow = wflow |>
#     finalize_workflow(best_params)
# 
# final_model = fit(final_wflow, data = train)
# final_model

## ----eval---------------------------------------------------------------------
# final_model |>
#     augment(new_data = test) |>
#     metric_set(rmse, rsq)(
#         truth = body_mass_kg,
#         estimate = .pred
#     )

## ----parametric---------------------------------------------------------------
# spec_manual = mlp_kindling(
#     hidden_neurons = c(50, 15),
#     activations = act_funs(
#         softshrink[lambd = 0.5],
#         relu
#     ),
#     epochs = 150,
#     learn_rate = 0.01
# ) |>
#     set_mode("regression")

