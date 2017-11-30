
library(ggplot2)

# sample data
set.seed(750)
X_i <- runif(1000, 0, 1)
e_i <- rnorm(1000, 0, 0.2)
Y_i <- sin(2*pi*X_i^3)^3 + e_i

# initialize df for plotting
N <- seq(10, 150, by = 10)
D <- seq(1:6)
error_plot <- data.frame(n = integer(), pse = numeric(), d = character())

# compute CV for dimension-D model on N datapoints
for (d in D) {
  d_plot <- data.frame(n = N, pse = rep(0, length(N)), d = paste0("d", d))
  for (n in N) {
    m_hat = lm(Y_i[1:n] ~ poly(X_i[1:n], d))
    pse = sum((residuals(m_hat) / (1 - hatvalues(m_hat)))^2) / n
    d_plot[d_plot$n == n, "pse"] <- pse
  }
  error_plot <- rbind(error_plot, d_plot)
}

# plot
ggplot(data = error_plot, aes(x = n, y = pse, group = d)) + 
  geom_line(aes(colour = d)) +
  coord_cartesian(ylim = c(0, 0.35)) +
  labs(title = "PSE by n", x = "n", y = "PSE", color = "Dimension")
