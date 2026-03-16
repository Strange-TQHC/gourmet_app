class Food {
  final String name;
  final String description;
  final double price;
  final String category;
  final double rating;
  final int deliveryTime;

  Food({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.deliveryTime,
  });
}

List<Food> foodItems = [
  Food(
    name: "Pizza",
    description: "Cheesy Italian pizza",
    price: 249,
    category: "Fast Food",
    rating: 4.5,
    deliveryTime: 20,
  ),
  Food(
    name: "Burger",
    description: "Juicy chicken burger",
    price: 149,
    category: "Fast Food",
    rating: 4.3,
    deliveryTime: 25,
  ),
  Food(
    name: "Biryani",
    description: "Hyderabadi special biryani",
    price: 199,
    category: "Main Course",
    rating: 4.4,
    deliveryTime: 18,
  ),
];