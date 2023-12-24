# Load necessary libraries
library(ggplot2)
library(dplyr)

# Create a data frame from the given data
data <- data.frame(
  Transaction_Id = c("6DEB5C-2143FA", "7X654W-Z12YU3", "N69M54-KPL7OJ", "7CDH8E-2GF6F5", "5Y6T4R-Q2EW78", "5DS3FA-H6GR8S", "O76J2L-KVCB8P"),
  Customer_Id = c(3256, 3251, 3245, 3215, 3218, 3227, 3206),
  Month = c("Feb", "Feb", "Feb", "Feb", "Feb", "Feb", "Feb"),
  Coupon = c("200 cashback", "None", "15%", "100 cashback", "None", "10%", "10%"),
  Membership = c("Yes", "No", "Yes", "Yes", "No", "Yes", "No"),
  Total_Cost = c(963, 1345, 992.8, 1764, 325, 391.5, 973.8),
  Payment_Method = c("UPI", "Cash", "Credit Card", "Debit Card", "UPI", "Cash", "UPI")
)

# Descriptive analysis
summary(data$Total_Cost)
table(data$Membership)
table(data$Payment_Method)

# Coupon analysis
coupon_summary <- data %>%
  group_by(Coupon) %>%
  summarize(Total_Revenue = sum(Total_Cost))
print(coupon_summary)

# Payment Method analysis
payment_method_summary <- data %>%
  group_by(Payment_Method) %>%
  summarize(Count = n())
print(payment_method_summary)

# Monthly analysis
monthly_summary <- data %>%
  group_by(Month) %>%
  summarize(Total_Cost = sum(Total_Cost))
print(monthly_summary)

# Create bar plot for monthly analysis
ggplot(monthly_summary, aes(x = Month, y = Total_Cost, fill = Month)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Cost of Transactions by Month", x = "Month", y = "Total Cost")

# Membership vs. Coupon analysis
membership_coupon_summary <- data %>%
  group_by(Membership, Coupon) %>%
  summarize(Avg_Total_Cost = mean(Total_Cost))
print(membership_coupon_summary)

# Create a bar plot for membership vs. coupon analysis
ggplot(membership_coupon_summary, aes(x = Membership, y = Avg_Total_Cost, fill = Coupon)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Average Total Cost by Membership and Coupon", x = "Membership", y = "Average Total Cost")

# Correlation analysis (Scatter plot)
ggplot(data, aes(x = Total_Cost, y = as.numeric(Membership))) +
  geom_point() +
  labs(title = "Correlation between Total Cost and Membership", x = "Total Cost", y = "Membership")

# Payment Method vs. Membership analysis
payment_membership_summary <- data %>%
  group_by(Payment_Method, Membership) %>%
  summarize(Count = n())
print(payment_membership_summary)

# Create a stacked bar plot for payment method vs. membership analysis
ggplot(payment_membership_summary, aes(x = Payment_Method, y = Count, fill = Membership)) +
  geom_bar(stat = "identity") +
  labs(title = "Payment Method vs. Membership", x = "Payment Method", y = "Count") +
  scale_fill_discrete(name = "Membership")

# Cashback analysis
cashback_summary <- data %>%
  filter(grepl("cashback", Coupon, ignore.case = TRUE)) %>%
  group_by(Coupon) %>%
  summarize(Total_Cost = sum(Total_Cost))
print(cashback_summary)

# Create a pie chart for cashback analysis
ggplot(cashback_summary, aes(x = "", y = Total_Cost, fill = Coupon)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Total Cost by Cashback Coupon", fill = "Coupon") +
  theme_void()
