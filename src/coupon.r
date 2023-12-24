coupon_cost_plot <- ggplot(total_history_df, aes(x = Coupun, y = Total.Cost, fill = 
Coupun)) +
 geom_bar(stat = "identity") +
 labs(title = "Coupun vs Total Cost",
 x = "Coupun",
 y = "Total Cost") +
 theme_minimal() +
 theme(legend.position = "top") +
 scale_fill_brewer(palette = "Set1")
# Create a pie chart for Coupons
coupon_pie_chart <- total_history_df %>%
 group_by(Coupun) %>%
 summarize(count = n()) %>%
 ggplot(aes(x = "", y = count, fill = Coupun)) +
 geom_bar(stat = "identity", width = 1) +
 coord_polar("y", start = 0) +
 labs(title = "Distribution of Coupons",
 fill = "Coupun") +
 theme_void() +
 scale_fill_brewer(palette = "Set2")
# Calculate the correlation matrix between numeric variables
numeric_vars <- total_history_df %>%
17
 select_if(is.numeric)
correlation_matrix <- cor(numeric_vars)
# Create a correlation plot
correlation_plot <- corrplot(correlation_matrix, method = "color", outline = 
FALSE, addgrid.col = NA)
# Display the plots
print(coupon_cost_plot)
print(coupon_pie_chart)
print(correlation_plot)
