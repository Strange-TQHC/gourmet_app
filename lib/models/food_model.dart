class Food {
  final String name;
  final String description;
  final double price;
  final String category;

  Food({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });
}

List<Food> foodItems = [
  Food(
    name: "Pizza",
    description: "Cheesy Italian pizza",
    price: 249,
    category: "Fast Food",
  ),
  Food(
    name: "Burger",
    description: "Juicy chicken burger",
    price: 149,
    category: "Fast Food",
  ),
  Food(
    name: "Biryani",
    description: "Hyderabadi special biryani",
    price: 199,
    category: "Main Course",
  ),
];