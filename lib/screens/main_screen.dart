import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'dart:ui';
import '../themes/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: screens[currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.white.withOpacity(0.1),
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                selectedIconTheme: const IconThemeData(
                  size: 30,
                  color: AppColors.primary,
                ),
                unselectedIconTheme: const IconThemeData(
                  size: 24,
                  color: Colors.black54,
                ),
                showSelectedLabels: false,
                showUnselectedLabels: false,

                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),

                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [

                        const Icon(Icons.shopping_cart),

                        Positioned(
                          right: 0,
                          child: Consumer<CartProvider>(
                            builder: (context, cart, child) {

                              if (cart.items.isEmpty) {
                                return const SizedBox();
                              }

                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  cart.items.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    label: "Cart",
                  ),

                  const BottomNavigationBarItem(
                    icon: Icon(Icons.receipt),
                    label: "Orders",
                  ),

                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}