Y_i <- faithful$waiting
X_i <- faithful$eruptions
N  <- seq(32,272, by=10)


# initialize df for plotting
D <- seq(1,11)
error_plot <- data.frame(n = integer(), pse = numeric(), d = character())

# compute CV for dimension-D model on N datapoints
plot(X_i[1:max(N)],Y_i[1:max(N)],xlab = "Eruption Time",ylab = "Waiting",main = "Geyser Data Estimator Evolution")
legend("bottomright", title = "Dimension",col =c("blue","red","orange","green") ,lty = 1, legend= c("1","3","6","11"))
for (d in D) {
  d_plot <- data.frame(n = N, pse = rep(0, length(N)), d = paste0("d", d))
  for (n in N) {
    m_hat <- lm(Y_i[1:n] ~ poly(X_i[1:n], d))
    pse = sum((residuals(m_hat) / (1 - hatvalues(m_hat)))^2) / n
    d_plot[d_plot$n == n, "pse"] <- pse
    
  }
  error_plot <- rbind(error_plot, d_plot)
  col <- c("blue","blue",'red','red','orange','orange','orange','green','green','green','green','green')
  m_hat_predict <- approxfun(X_i[1:n],m_hat$fitted.values)
  if(d == 1 || d== 3 || d ==6 || d == 11) {
    lines(seq( min(X_i),max(X_i),length.out=1000) , m_hat_predict( seq( min(X_i),max(X_i),length.out=1000)),col = col[d] )
  }
}

# plot
ggplot(data = error_plot[error_plot$d %in% c("d1","d3","d4","d5","d8","d11"),], aes(x = n, y = pse, group = d)) + 
  geom_line(aes(colour = d)) +
  coord_cartesian(ylim = c(25, 50)) +
  labs(title = "Geyser PSE by n (Polynomial)", x = "n", y = "PSE", color = "Dimension")

# Now compute estimator for small number of data points

N  <- seq(20,40, by=20)
D <- seq(1,11)
error_plot <- data.frame(n = integer(), pse = numeric(), d = character())

# compute CV for dimension-D model on N datapoints
plot(X_i[1:max(N)],Y_i[1:max(N)],xlab = "Eruption Time",ylab = "Waiting",main = "Geyser Data Estimator Evolution")
legend("bottomright", title = "Dimension", col =c("blue","red","orange","green") ,lty = 1, legend= c("1","3","6","11"))
for (d in D) {
  d_plot <- data.frame(n = N, pse = rep(0, length(N)), d = paste0("d", d))
  for (n in N) {
    m_hat <- lm(Y_i[1:n] ~ poly(X_i[1:n], d))
    pse = sum((residuals(m_hat) / (1 - hatvalues(m_hat)))^2) / n
    d_plot[d_plot$n == n, "pse"] <- pse
    
  }
  error_plot <- rbind(error_plot, d_plot)
  col <- c("blue","blue",'red','red','orange','orange','orange','green','green','green','green','green')
  m_hat_predict <- approxfun(X_i[1:n],m_hat$fitted.values)
  if(d == 1 || d== 3 || d ==6 || d == 11) {
    lines(seq( min(X_i),max(X_i),length.out=1000) , m_hat_predict( seq( min(X_i),max(X_i),length.out=1000)),col = col[d] )
  }
}