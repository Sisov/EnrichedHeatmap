\name{getSignalsFromList}
\alias{getSignalsFromList}
\title{
Get signals from a list
}
\description{
Get signals from a list
}
\usage{
getSignalsFromList(lt, fun = function(x) mean(x, na.rm = TRUE))
}
\arguments{

  \item{lt}{a list of normalized matrices which are returned by \code{\link{normalizeToMatrix}}. Matrices in the list should be generated with same settings (e.g. they should use same target regions, same extension to targets and same number of windows).}
  \item{fun}{a user-defined function to summarize signals. If we assume elements in \code{lt} correspond to different samples,  the user-defined function calculates e.g. mean signal for each window.}

}
\details{
Let's assume you have a list of histone modification signals for different samples and you want
to visualize the mean pattern across samples. You can first normalize histone mark signals for each sample and then
calculate means values across all samples. In following example code, \code{hm_gr_list} is a list of \code{GRanges} objects
which contain positions of histone modifications, \code{tss} is a \code{GRanges} object containing positions of gene TSS.

  \preformatted{
    mat_list = NULL
    for(i in seq_along(hm_gr_list)) \{
        mat_list[[i]] = normalizeToMatrix(hm_gr_list[[i]], tss, value_column = "density")
    \}  }

Applying \code{getSignalsFromList()} to \code{mat_list}, it gives a new normalized matrix which contains mean signals and can
be directly used in \code{EnrichedHeatmap()}.

  \preformatted{
    mat = getSignalsFromList(mat_list)
    EnrichedHeatmap(mat)  }

Next let's consider a second scenario: we want to see the correlation between histone modification and gene expression.
In this case, \code{fun} can have a second argument so that users can correspond histone signals to the expression of the
associated gene. In following code, \code{expr} is a matrix of expression, columns in \code{expr} correspond to elements in \code{hm_gr_list},
rows in \code{expr} are same as \code{tss}.

  \preformatted{
    mat = getSignalsFromList(mat_list, 
        fun = function(x, i) cor(x, expr[i, ], method = "spearman"))  }

Then \code{mat} here can be used to visualize how gene expression is correlated to histone modification around TSS.

  \preformatted{
    EnrichedHeatmap(mat)  }
}
\value{
A \code{\link{normalizeToMatrix}} object which can be directly used for \code{\link{EnrichedHeatmap}}.
}
\author{
Zuguang Gu <z.gu@dkfz.de>
}
\examples{
NULL
}
