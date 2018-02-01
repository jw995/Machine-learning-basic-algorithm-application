function weight = gaussiandist(xi, xj, sigma)

weight = exp(-sum(((xi - xj) .^ 2) / (2*sigma^2)));