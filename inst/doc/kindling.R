## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.width = 7,
    fig.height = 5
)

## ----eval = FALSE-------------------------------------------------------------
# # install.packages("pak")
# pak::pak("joshuamarie/kindling")
# ## devtools::install_github("joshuamarie/kindling")

## -----------------------------------------------------------------------------
library(kindling)

## ----eval = FALSE-------------------------------------------------------------
# ffnn_generator(
#     nn_name = "MyNetwork",
#     hd_neurons = c(64, 32),
#     no_x = 10,
#     no_y = 1,
#     activations = 'relu'
# )

## ----eval = FALSE-------------------------------------------------------------
# model = ffnn(
#     Species ~ .,
#     data = iris,
#     hidden_neurons = c(10, 15, 7),
#     activations = act_funs(relu, elu), # c("relu", "elu")
#     loss = "cross_entropy",
#     epochs = 100
# )
# 
# predictions = predict(model, newdata = iris)

## ----eval = FALSE-------------------------------------------------------------
# box::use(
#     parsnip[fit, augment],
#     yardstick[metrics]
# )
# 
# nn_spec = mlp_kindling(
#     mode = "classification",
#     hidden_neurons = c(10, 7),
#     activations = act_funs(relu, softshrink = args(lambd = 0.5)),
#     epochs = 100
# )
# 
# nn_fit = fit(nn_spec, Species ~ ., data = iris)
# augment(nn_fit, new_data = iris) |>
#     metrics(truth = Species, estimate = .pred_class)

