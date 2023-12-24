library(ggplot2)
# Data which has been taken after using Excel tools
product_data <- data.frame(
 Product = c("Cereals",
 "Cold drink andBeverages", "Diary", "Fruits and Vegetables", "Hair and 
Skin", "Household", "Hygiene products", "Others", "Poultry", "Snacks and 
chocolates", "Spices and condiments"),
 Quantity = c(32, 60, 44, 114,39, 56, 60, 20, 6, 67, 26)
)
# Create a bar graph
ggplot(product_data, aes(x = reorder(Product, Quantity), y = Quantity)) +
 geom_bar(stat = "identity", fill = "blue") +
 labs(title = "sales by category", x = "category", y = "no.of products sold") +
 theme(axis.text.x = element_text(angle =45, hjust = 1))
