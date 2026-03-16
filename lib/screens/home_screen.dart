import 'package:flutter/material.dart';
import '../models/food_model.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'food_details_screen.dart';
import '../themes/app_colors.dart';

const List<String> categories = [
  "Pizza",
  "Burger",
  "Biryani",
  "Dessert",
  "Drinks"
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Gourmet",
          style: TextStyle(
            fontFamily: "GourmetFont",
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(
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

              // SEARCH BAR
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
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

              // CATEGORIES
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
                        color: AppColors.tertiary,
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

              isLoading
                  ? skeletonList()
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final food = foodItems[index];

                  return foodItem(context, food);
                },
              ),
            ],
          ),
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(

            children: [

              /// UPDATED FOOD IMAGE WITH HERO

              Hero(
                tag: food.name,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColors.tertiary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.fastfood,
                    size: 35,
                    color: AppColors.primary, // Added color for a better look
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// FOOD INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      food.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [

                        const Icon(
                          Icons.star,
                          color: AppColors.primary,
                          size: 16,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          food.rating.toString(),
                          style: const TextStyle(fontSize: 13),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          "•  ${food.deliveryTime} min",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      food.description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "₹${food.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              /// ADD BUTTON
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: AppColors.primary,
                  size: 28,
                ),
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .addToCart(food);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${food.name} added to cart"),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget skeletonCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [

          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  height: 14,
                  width: 120,
                  color: Colors.grey.shade300,
                ),

                const SizedBox(height: 8),

                Container(
                  height: 12,
                  width: 80,
                  color: Colors.grey.shade300,
                ),

                const SizedBox(height: 8),

                Container(
                  height: 12,
                  width: 150,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget skeletonList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return skeletonCard();
      },
    );
  }
}