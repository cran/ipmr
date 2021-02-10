## ----eval = FALSE-------------------------------------------------------------
#  
#  library(ipmr)
#  
#  data_list = list(
#    s_int     = 1.03,
#    s_slope   = 2.2,
#    s_dd      = -0.7,
#    g_int     = 8,
#    g_slope   = 0.92,
#    sd_g      = 0.9,
#    f_r_int   = 0.09,
#    f_r_slope = 0.05,
#    f_s_int   = 0.1,
#    f_s_slope = 0.005,
#    f_s_dd    = -0.03,
#    mu_fd     = 9,
#    sd_fd     = 2
#  )
#  
#  # Now, simulate some random intercepts for growth, survival, and offspring production
#  
#  g_r_int   <- rnorm(5, 0, 0.3)
#  s_r_int   <- rnorm(5, 0, 0.7)
#  f_s_r_int <- rnorm(5, 0, 0.2)
#  
#  nms <- paste("r_", 1:5, sep = "")
#  
#  names(g_r_int) <- paste("g_", nms, sep = "")
#  names(s_r_int) <- paste("s_", nms, sep = "")
#  names(f_s_r_int) <- paste("f_s_", nms, sep = "")
#  
#  params     <- c(data_list, g_r_int, s_r_int, f_s_r_int)
#  

## ----eval = FALSE-------------------------------------------------------------
#  
#  dd_ipm <- init_ipm(sim_gen = "simple", di_dd = "dd", det_stoch = "det")

## ----eval = FALSE-------------------------------------------------------------
#  dd_ipm <- define_kernel(
#    proto_ipm        = dd_ipm,
#    name             = "P_yr",
#    formula          = s_yr * g_yr,
#    family           = "CC",
#    s_yr             = plogis(s_int + s_r_yr + s_slope * size_1 + s_dd * sum(n_size_t) * d_size),
#    g_yr             = dnorm(size_2, g_mu_yr, sd_g),
#    g_mu_yr          = g_int + g_r_yr + g_slope * size_1,
#    data_list        = params,
#    states           = list(c("size")),
#    has_hier_effs    = TRUE,
#    levels_hier_effs = list(yr = 1:5),
#    evict_cor        = TRUE,
#    evict_fun        = truncated_distributions("norm", "g_yr")
#  )
#  

## ----eval = FALSE-------------------------------------------------------------
#  
#  dd_ipm <- define_kernel(
#    proto_ipm        = dd_ipm,
#    name             = "F_yr",
#    formula          = f_r * f_s_yr * f_d,
#    family           = "CC",
#    f_r              = plogis(f_r_int + f_r_slope * size_1),
#    f_s_yr           = exp(f_s_int + f_s_r_yr + f_s_slope * size_1 + f_s_dd * sum(n_size_t) * d_size),
#    f_d              = dnorm(size_2, mu_fd, sd_fd),
#    data_list        = params,
#    states           = list(c("size")),
#    has_hier_effs    = TRUE,
#    levels_hier_effs = list(yr = 1:5),
#    evict_cor        = TRUE,
#    evict_fun        = truncated_distributions("norm", "f_d")
#    )
#  

## ----eval = FALSE-------------------------------------------------------------
#   dd_ipm <-  dd_ipm %>%
#    define_impl(
#      make_impl_args_list(
#        kernel_names = c("P_yr", "F_yr"),
#        int_rule     = rep("midpoint", 2),
#        state_start    = rep("size", 2),
#        state_end      = rep("size", 2)
#      )
#    ) %>%
#    define_domains(
#      size = c(0, 50, 200)
#    ) %>%
#    define_pop_state(
#      n_size = runif(200)
#    ) %>%
#    make_ipm(
#      iterate = TRUE,
#      iterations = 50,
#      kernel_seq = sample(1:5, 50, replace = TRUE)
#    )
#  
#  

## ----eval = FALSE-------------------------------------------------------------
#  time_step_lams <- lambda(dd_ipm, type_lambda = "all")
#  stoch_lam      <- lambda(dd_ipm, type_lambda = "stochastic", burn_in = 0.15)
#  
#  pop_sizes <- colSums(dd_ipm$pop_state$n_size)
#  
#  plot(pop_sizes, type = "l")
#  

