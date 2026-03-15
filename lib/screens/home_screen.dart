import 'package:flutter/material.dart';
import '../models/food_model.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'food_details_screen.dart';

const List<String> categories = [
  "Pizza",
  "Burger",
  "Biryani",
  "Dessert",
  "Drinks"
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gourmet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hey there!!",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              "What would you like to eat?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search food...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {

                  final category = categories[index];

                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      category,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),

            sectionTitle("Popular Foods"),
            Expanded(
              child: ListView.builder(
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final food = foodItems[index];

                  return foodItem(context, food);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget foodItem(BuildContext context, Food food) {
    return InkWell(

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailsScreen(food: food),
          ),
        );

      },

        child: Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.fastfood, size: 30),
            title: Text(food.name),
            subtitle: Text(food.description),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "₹${food.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                IconButton(
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  onPressed: () {

                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(food);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${food.name} added to cart")),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}