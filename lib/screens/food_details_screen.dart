import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_model.dart';
import '../providers/cart_provider.dart';

class FoodDetailsScreen extends StatelessWidget {

  final Food food;

  const FoodDetailsScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(food.name),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: food.name,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.fastfood,
                  size: 100,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              food.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              food.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Price: ₹${food.price}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                onPressed: () {

                  Provider.of<CartProvider>(context, listen: false)
                      .addToCart(food);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${food.name} added to cart")),
                  );
                },

                child: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}