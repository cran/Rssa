\name{Rssa-package}
\alias{Rssa-package}
\alias{Rssa}
\docType{package}
\title{A collection of methods for singular spectrum analysis}
\description{
  Singular Spectrum Analysis (SSA, in short) is a modern non-parametric
  method for the analysis of time series and digital images. This
  package provides a set of fast and reliable implementations of various
  routines to perform decomposition, reconstruction and forecasting.
  A comprehensive description of the methods and functions from Rssa 
  can be found in Golyandina et al (2018). The companion web-site is
  https://ssa-with-r-book.github.io/.
}

\details{
  Typically the use of the package starts with the \emph{decomposition}
  of the time series using \code{\link{ssa}}. After this a suitable
  \emph{grouping} of the elementary time series is required. This can be
  done heuristically, for example, via looking at the plots of the
  decomposition (\code{\link[Rssa:plot.ssa]{plot}}). Alternatively, one
  can examine the so-called w-correlation matrix
  (\code{\link{wcor}}). Automatic grouping can be performed by means of
  \code{\link{grouping.auto}}. 
  In addition, Oblique SSA
  methods can be used to improve the series separability
  (\code{\link[Rssa:iossa]{iossa}}, \code{\link[Rssa:fossa]{fossa}}).

  Next step includes the \emph{reconstruction} of
  the time-series using the selected grouping
  (\code{\link[Rssa:reconstruct.ssa]{reconstruct}}). One ends with
  frequency estimation (\code{\link[Rssa:parestimate]{parestimate}}),
  series forecasting (\code{\link[Rssa:forecast.ssa]{forecast}},
  \code{\link[Rssa:rforecast.ssa]{rforecast}},
  \code{\link[Rssa:vforecast.ssa]{vforecast}})
  and (if any) gap filling (\code{\link[Rssa:gapfill]{gapfill}}, 
  \code{\link[Rssa:igapfill]{igapfill}}). 
}

\references{
  Golyandina N., Korobeynikov A., Zhigljavsky A. (2018):
  \emph{Singular Spectrum Analysis with R.}  Use R!.
    Springer, Berlin, Heidelberg.

  Golyandina, N., Nekrutkin, V. and Zhigljavsky, A. (2001):
  \emph{Analysis of Time Series Structure: SSA and related techniques.}
  Chapman and Hall/CRC. ISBN 1584881941f

  Golyandina, N. and Stepanov, D. (2005): \emph{SSA-based approaches to
    analysis and forecast of multidimensional time series}. In
  Proceedings of the 5th St.Petersburg Workshop on Simulation, June
  26-July 2, 2005, St. Petersburg State University, St. Petersburg,
  293--298. \url{https://www.gistatgroup.com/gus/mssa2.pdf}

  Golyandina, N. and Usevich, K. (2009): \emph{2D-extensions of singular
  spectrum analysis: algorithm and elements of theory.} In Matrix
  Methods: Theory, Algorithms, Applications. World Scientific
  Publishing, 450-474.

  Korobeynikov, A. (2010): \emph{Computation- and space-efficient
    implementation of SSA.} Statistics and Its Interface, Vol. 3, No. 3,
  Pp. 257-268

  Golyandina, N., Korobeynikov, A. (2012, 2014): \emph{Basic Singular Spectrum
    Analysis and Forecasting with R.} Computational Statistics and Data
    Analysis, Vol. 71, Pp. 934-954. \url{https://arxiv.org/abs/1206.6910}

  Golyandina, N., Zhigljavsky, A. (2013): \emph{Singular Spectrum
    Analysis for time series}. Springer Briefs in Statistics. Springer.

  Shlemov, A. and Golyandina, N. (2014): \emph{Shaped extensions of singular
  spectrum analysis}. 21st International Symposium on Mathematical 
  Theory of Networks and Systems, July 7-11, 2014. Groningen, 
  The Netherlands. p.1813-1820. \url{https://arxiv.org/abs/1507.05286}

  Golyandina, N., Korobeynikov, A., Shlemov, A. and Usevich, K. (2015):
  \emph{Multivariate and 2D Extensions of Singular Spectrum Analysis
    with the Rssa Package}. Journal of Statistical Software, Vol. 67, Issue 2.
  \doi{10.18637/jss.v067.i02}
}
\keyword{package}
\seealso{
  \code{\link[Rssa:ssa-input]{ssa-input}},
  \code{\link{ssa}}, \code{\link[Rssa:decompose.ssa]{decompose}},
  \code{\link[Rssa:reconstruct.ssa]{reconstruct}},
  \code{\link{wcor}}, \code{\link[Rssa:plot.ssa]{plot}},
  \code{\link[Rssa:parestimate]{parestimate}},
  \code{\link[Rssa:rforecast.ssa]{rforecast}},
  \code{\link[Rssa:vforecast.ssa]{vforecast}},
  \code{\link[Rssa:forecast.ssa]{forecast}},
  \code{\link[Rssa:iossa]{iossa}},
  \code{\link[Rssa:fossa]{fossa}}
}
\examples{
s <- ssa(co2) # Perform the decomposition using the default window length
summary(s)        # Show various information about the decomposition
plot(s)           # Show the plot of the eigenvalues
r <- reconstruct(s, groups = list(Trend = c(1, 4),
                                  Seasonality = c(2:3, 5:6))) # Reconstruct into 2 series
plot(r, add.original = TRUE)  # Plot the reconstruction

# Simultaneous trend extraction using MSSA
\donttest{
s <- ssa(EuStockMarkets, kind = "mssa")
r <- reconstruct(s, groups = list(Trend = c(1,2)))
plot(r, plot.method = "xyplot", add.residuals = FALSE,
     superpose = TRUE, auto.key = list(columns = 2))
# Trend forecast
f <- rforecast(s, groups = list(Trend = c(1, 2)),
               len = 50, only.new = FALSE)
library(lattice)
xyplot(ts.union(Original = EuStockMarkets, "Recurrent Forecast" = f),
       superpose = TRUE, auto.key = list(columns = 2))
}
}
