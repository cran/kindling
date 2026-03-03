## ----setup, include = FALSE, warning=FALSE, message=FALSE---------------------
knitr::opts_chunk$set(
    eval = identical(Sys.getenv("NOT_CRAN"), "true"),
    fig.width = 7,
    fig.height = 5,
    warning = FALSE,
    message = FALSE
)
library(kindling)

## -----------------------------------------------------------------------------
# model = ffnn(
#     Sepal.Length ~ .,
#     data = iris[, 1:4],
#     hidden_neurons = c(64, 32, 16),
#     activations = act_funs(
#         relu,
#         silu,
#         new_act_fn(\(x) torch::torch_tanh(x))
#     ),
#     epochs = 50
# )
# model

## -----------------------------------------------------------------------------
# ffnn(
#     Sepal.Length ~ .,
#     data = iris[, 1:4],
#     hidden_neurons = c(64, 32),
#     activations = act_funs(new_act_fn(\(x) torch::torch_tanh(x))),
#     epochs = 50
# )

## ----eval = FALSE-------------------------------------------------------------
# my_act = new_act_fn(\(x) torch::torch_tanh(x), probe = FALSE)

## -----------------------------------------------------------------------------
# my_act = new_act_fn(\(x) torch::torch_tanh(x), .name = "my_tanh")

## -----------------------------------------------------------------------------
# ffnn(
#     Sepal.Length ~ .,
#     data = iris[, 1:4],
#     hidden_neurons = c(64, 32),
#     activations = act_funs(
#         relu,
#         new_act_fn(\(x) torch::torch_tanh(x), .name = "hyper_tanh")
#     ),
#     epochs = 50
# )

## ----error = TRUE-------------------------------------------------------------
try({
# new_act_fn(\(x) as.numeric(x))
})

## ----error = TRUE-------------------------------------------------------------
try({
# new_act_fn(function() torch::torch_zeros(2))
})

