% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/internal-lin_alg.R, R/utils-export.R
\name{is_conv_to_asymptotic}
\alias{is_conv_to_asymptotic}
\alias{is_conv_to_asymptotic.ipmr_ipm}
\alias{conv_plot}
\alias{conv_plot.ipmr_ipm}
\title{Check for model convergence to asymptotic dynamics}
\usage{
is_conv_to_asymptotic(ipm, tolerance, burn_in)

\method{is_conv_to_asymptotic}{ipmr_ipm}(ipm, tolerance = 1e-06, burn_in = 0.1)

conv_plot(ipm, iterations, log, show_stable, burn_in, ...)

\method{conv_plot}{ipmr_ipm}(
  ipm,
  iterations = NULL,
  log = NULL,
  show_stable = TRUE,
  burn_in = 0.1,
  ...
)
}
\arguments{
\item{ipm}{An object returned by \code{make_ipm()}.}

\item{tolerance}{The tolerance for convergence in lambda or, in the case of stochastic models, the cumulative mean of log(lambda).}

\item{burn_in}{The proportion of iterations to discard. Default is 0.1 (i.e.
first 10\% of iterations in the simulation). Ignored for deterministic
models.}

\item{iterations}{The range of iterations to plot \code{lambda} for. The default
is every iteration.}

\item{log}{A logical indicating whether to log transform \code{lambda}. This
defaults to TRUE for stochastic models and FALSE for deterministic models.}

\item{show_stable}{A logical indicating whether or not to draw a line indicating
population stability at \code{lambda = 1}.}

\item{...}{Further arguments to \code{plot}.}
}
\value{
\code{is_conv_to_asymptotic}: Either \code{TRUE} or \code{FALSE}.
\code{conv_plot}: code{ipm} invisibly.
}
\description{
Checks for convergence to asymptotic dynamics numerically and
visually. \code{is_conv_to_asymptotic} checks whether
\code{lambda[iterations - 1]} equals \code{lambda[iterations]} within the
specified tolerance, \code{tolerance}. \code{conv_plot} plots the time series of
\code{lambda} (or \code{log(lambda)}). For stochastic models, a cumulative mean of
log(lambda) is used to check for convergence.
}
\details{
Plotting can be controlled by passing additional graphing parameters
to \code{...}.
}
\examples{
data(gen_di_det_ex)

proto <- gen_di_det_ex$proto_ipm \%>\%
  define_pop_state(n_ht = runif(200),
                   n_b  = 200000)

ipm <- make_ipm(proto)

is_conv_to_asymptotic(ipm, tolerance = 1e-5)
conv_plot(ipm)

}
