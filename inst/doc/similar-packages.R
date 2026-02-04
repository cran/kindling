## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    fig.width = 7,
    fig.height = 5
)

## ----comparison_table, echo=FALSE---------------------------------------------
comparison = data.frame(
    Feature = c(
        "**Primary Focus**",
        "**Design Philosophy**",
        "**Architectures**",
        "**Code Generation**",
        "**tidymodels Integration**",
        "**Formula Syntax**",
        "**Layer-specific Activations**",
        "**GPU Support**",
        "**Explainability/xAI**",
        "**Statistical Inference**",
        "**Custom Loss Functions**",
        "**For whom?**"
    ),
    kindling = c(
        "Architectural versatility & flexibility, statistical modelling, and code generation",
        "Three-level API (code gen, training, ML framework (currently tidymodels) integration)",
        "Versatile — Feedforward Neural Networks (DNN/FFNN/MLP), Recurrent Neural Networks (RNN, LSTM, GRU), and more (in the future)",
        "Yes (inspect & modify torch code)",
        "Full (parsnip models & tuning)",
        "Yes",
        "Yes",
        "Yes",
        "Garson's & Olden's algorithms, vip integration, and more in the future",
        "Not yet implemented",
        "Yes",
        "Wanted versatile architectures (more in the future), fine-grained control, tidymodels users"
    ),
    brulee = c(
        "Production-ready statistical models",
        "Batteries-included with sensible defaults",
        "MLP, Linear/Logistic/Multinomial regression",
        "No",
        "Full (official tidymodels package)",
        "Yes",
        "No",
        "Yes",
        "Limited",
        "No",
        "No",
        "Wants standard supervised learning, stable production models"
    ),
    cito = c(
        "Statistical inference & interpretation",
        "User-friendly with comprehensive xAI pipeline",
        "Fully-connected networks, CNNs",
        "No",
        "No (standalone package)",
        "Yes",
        "No",
        "Yes (CPU, GPU, MacOS)",
        "Extensive (PDP, ALE, variable importance, etc.)",
        "Yes (confidence intervals, p-values via bootstrap)",
        "Yes",
        "Do ecological modeling, interpretable models, statistical inference"
    ),
    luz = c(
        "Training loop abstraction",
        "High-level API reducing boilerplate",
        "Any torch nn_module",
        "No",
        "No (standalone package)",
        "No (uses torch modules directly)",
        "No (also uses torch modules directly)",
        "Yes (automatic device placement)",
        "No",
        "No",
        "Yes",
        "Wants custom architectures, users needing human-friendly training loop control"
    ),
    stringsAsFactors = FALSE
)

knitr::kable(
    comparison, 
    col.names = c("Feature", "kindling", "brulee", "cito", "luz"),
    label = "Table of comparison"
)

