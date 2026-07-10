## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = identical(Sys.getenv("NOT_CRAN"), "true"),
    fig.width = 7,
    fig.height = 5,
    warning = FALSE,
    message = FALSE
)

fansi::set_knit_hooks(knitr::knit_hooks)

## ----eval = FALSE-------------------------------------------------------------
# # install.packages("pak")
# pak::pak("joshuamarie/kindling")
# ## devtools::install_github("joshuamarie/kindling")

## -----------------------------------------------------------------------------
# library(kindling)

## ----collapse=FALSE, comment=""-----------------------------------------------
# ffnn_generator(
#     nn_name = "MyFFNN",
#     hd_neurons = c(64, 32, 16),
#     no_x = 10,
#     no_y = 1,
#     activations = 'relu'
# )

## ----comment="", collapse=FALSE-----------------------------------------------
# model = ffnn(
#     Species ~ .,
#     data = iris,
#     hidden_neurons = c(10, 15, 7),
#     activations = act_funs(relu, softshrink[lambd = 0.5], elu),
#     loss = "cross_entropy",
#     epochs = 100
# )
# 
# model

## -----------------------------------------------------------------------------
# predict(model) |>
#     (\(x) table(actual = iris$Species, predicted = x))()

## -----------------------------------------------------------------------------
# sample_iris = dplyr::slice_sample(iris, n = 10, by = Species)
# 
# predict(model, newdata = sample_iris) |>
#     (\(x) table(actual = sample_iris$Species, predicted = x))()

## -----------------------------------------------------------------------------
# # library(kindling)
# # library(parsnip)
# # library(yardstick)
# box::use(
#     kindling[mlp_kindling, rnn_kindling, act_funs, args],
#     parsnip[fit, augment],
#     yardstick[metrics]
# )
# data(Ionosphere, package = "mlbench")
# 
# ionosphere_data = Ionosphere[, -2]
# 
# # Train a feedforward network with parsnip
# mlp_kindling(
#     mode = "classification",
#     hidden_neurons = c(128, 64),
#     activations = act_funs(relu, softshrink[lambd = 0.5]),
#     epochs = 100
# ) |>
#     fit(Class ~ ., data = ionosphere_data) |>
#     augment(new_data = ionosphere_data) |>
#     metrics(truth = Class, estimate = .pred_class)
# 
# # Or try a recurrent architecture (demonstrative example with tabular data)
# rnn_kindling(
#     mode = "classification",
#     hidden_neurons = c(128, 64),
#     activations = act_funs(relu, elu),
#     epochs = 100,
#     rnn_type = "gru"
# ) |>
#     fit(Class ~ ., data = ionosphere_data) |>
#     augment(new_data = ionosphere_data) |>
#     metrics(truth = Class, estimate = .pred_class)

## ----collapse=FALSE, comment=""-----------------------------------------------
# # library(tidymodels)
# box::use(
#     kindling[
#         mlp_kindling, hidden_neurons, activations, output_activation, grid_depth
#     ],
#     parsnip[fit, augment],
#     recipes[recipe],
#     workflows[workflow, add_recipe, add_model],
#     rsample[vfold_cv],
#     tune[tune_grid, tune, select_best, finalize_workflow],
#     dials[grid_random],
#     yardstick[accuracy, roc_auc, metric_set, metrics]
# )
# 
# mlp_tune_spec = mlp_kindling(
#     mode = "classification",
#     hidden_neurons = tune(),
#     activations = tune(),
#     output_activation = tune()
# )
# 
# iris_folds = vfold_cv(iris, v = 3)
# nn_wf = workflow() |>
#     add_recipe(recipe(Species ~ ., data = iris)) |>
#     add_model(mlp_tune_spec)
# 
# nn_grid_depth = grid_depth(
#     hidden_neurons(c(32L, 128L)),
#     activations(c("relu", "elu")),
#     output_activation(c("sigmoid", "linear")),
#     n_hlayer = 2,
#     size = 10,
#     type = "latin_hypercube"
# )
# 
# # This is supported but limited to 1 hidden layer only
# ## nn_grid = grid_random(
# ##     hidden_neurons(c(32L, 128L)),
# ##     activations(c("relu", "elu")),
# ##     output_activation(c("sigmoid", "linear")),
# ##     size = 10
# ## )
# 
# nn_tunes = tune::tune_grid(
#     nn_wf,
#     iris_folds,
#     grid = nn_grid_depth
# )
# 
# best_nn = select_best(nn_tunes)
# best_nn
# final_nn = finalize_workflow(nn_wf, best_nn)
# final_nn_model = fit(final_nn, data = iris)
# final_nn_model
# 
# final_nn_model |>
#     augment(new_data = iris) |>
#     metrics(truth = Species, estimate = .pred_class)

## -----------------------------------------------------------------------------
# garson(model, bar_plot = FALSE)

## -----------------------------------------------------------------------------
# olden(model, bar_plot = FALSE)

## ----fig.height=6, fig.width=8------------------------------------------------
# box::use(
#     vip[vi, vip]
# )
# 
# vi(model) |>
#     vip()

