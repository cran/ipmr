% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-export.R
\name{use_vr_model}
\alias{use_vr_model}
\title{Predict methods in ipmr}
\usage{
use_vr_model(model)
}
\arguments{
\item{model}{A fitted model object representing a vital rate. Primarily used to avoid
writing the mathematical expression for a vital rate, and using a \code{predict()}
method instead.}
}
\value{
A model object with a \code{"flat_protect"} attribute.
}
\description{
This function is used when a \code{predict} method is incorporated
into the vital rate expressions of a kernel. Generally, ipmr can handle this
without any additional user effort, but some model classes will fail (often
with an obscure error message).
When this happens, \code{use_vr_model} can ensure that model object is
correctly represented in the \code{data_list}.
}
\details{
ipmr usually recognizes model objects passed into the \code{data_list} argument
automatically. Unfortunately, sometimes it'll miss one, and the user will need
to manually protect it from the standard build process. This function
provides a wrapper around that process. Additionally, please file a bug
report here: \url{https://github.com/padrinoDB/ipmr/issues} describing what type
of model you are trying to use so it can be added to later versions of the
package.

Wrap a model object in \code{use_vr_model} when building the \code{data_list}
to pass to \code{define_kernel}.
}
\examples{

data(iceplant_ex)

grow_mod <- lm(log_size_next ~ log_size, data = iceplant_ex)
surv_mod <- glm(survival ~ log_size, data = iceplant_ex, family = binomial())

data_list <- list(
  grow_mod = use_vr_model(grow_mod),
  surv_mod = use_vr_model(surv_mod),
  recruit_mean = 20,
  recruit_sd   = 5
)

}
