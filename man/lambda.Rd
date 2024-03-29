% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generics.R
\name{lambda}
\alias{lambda}
\alias{lambda.simple_di_det_ipm}
\alias{lambda.simple_di_stoch_kern_ipm}
\alias{lambda.simple_di_stoch_param_ipm}
\alias{lambda.general_di_det_ipm}
\alias{lambda.general_di_stoch_kern_ipm}
\alias{lambda.general_di_stoch_param_ipm}
\alias{lambda.simple_dd_det_ipm}
\alias{lambda.simple_dd_stoch_kern_ipm}
\alias{lambda.simple_dd_stoch_param_ipm}
\alias{lambda.general_dd_det_ipm}
\alias{lambda.general_dd_stoch_kern_ipm}
\alias{lambda.general_dd_stoch_param_ipm}
\title{Compute the per-capita growth rate for an IPM object}
\usage{
lambda(ipm, ...)

\method{lambda}{simple_di_det_ipm}(ipm, type_lambda = "last", log = FALSE, ...)

\method{lambda}{simple_di_stoch_kern_ipm}(ipm, type_lambda = "stochastic", burn_in = 0.1, log = NULL, ...)

\method{lambda}{simple_di_stoch_param_ipm}(ipm, type_lambda = "stochastic", burn_in = 0.1, log = NULL, ...)

\method{lambda}{general_di_det_ipm}(ipm, type_lambda = "last", log = FALSE, ...)

\method{lambda}{general_di_stoch_kern_ipm}(ipm, ..., type_lambda = "stochastic", burn_in = 0.1, log = NULL)

\method{lambda}{general_di_stoch_param_ipm}(ipm, ..., type_lambda = "stochastic", burn_in = 0.1, log = NULL)

\method{lambda}{simple_dd_det_ipm}(ipm, type_lambda = "all", ..., log = FALSE)

\method{lambda}{simple_dd_stoch_kern_ipm}(ipm, ..., type_lambda = "stochastic", burn_in = 0.1, log = NULL)

\method{lambda}{simple_dd_stoch_param_ipm}(ipm, ..., type_lambda = "stochastic", burn_in = 0.1, log = NULL)

\method{lambda}{general_dd_det_ipm}(ipm, type_lambda = "last", ..., log = FALSE)

\method{lambda}{general_dd_stoch_kern_ipm}(ipm, ..., type_lambda = "stochastic", burn_in = 0.1, log = NULL)

\method{lambda}{general_dd_stoch_param_ipm}(ipm, ..., type_lambda = "stochastic", burn_in = 0.1, log = NULL)
}
\arguments{
\item{ipm}{An object returned by \code{make_ipm()}.}

\item{...}{other arguments passed to methods.}

\item{type_lambda}{Either \code{'all'}, \code{'last'},
 or \code{'stochastic'}. \code{'all'}
returns a vector of lambda values for each time step of the simulation (equal
in length to the \code{iterations} argument of \code{make_ipm()}).
\code{'last'} returns the lambda value for the final timestep.
\code{'stochastic'} returns a single value, which by default is
\code{mean(log(lambda(ipm, type_lambda = "all")))}, with the proportion of
\code{burn_in} iterations removed from the beginning of the simulation. Set
\code{log} to \code{FALSE} to get \code{lambda} on the linear scale  for
stochastic models (i.e. \code{exp(mean(log(lambdas)))}).}

\item{log}{Return lambda on the log scale? This is \code{TRUE} by default for
stochastic models, and \code{FALSE} for deterministic models.}

\item{burn_in}{The proportion of iterations to discard. Default is 0.1
(i.e. first 10\% of iterations in the simulation).}
}
\value{
When \code{type_lambda = "all"}, an array. Rows correspond to time
steps, and columns correspond to parameter sets (if any). For other types,
a numeric vector.
}
\description{
Compute the per-capita growth rate for a given model. Can handle
stochastic and deterministic models, and has the option to discard burn in for
stochastic models.
}
