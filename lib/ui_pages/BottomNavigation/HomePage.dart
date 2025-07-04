import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/cart_bloc.dart';
import '../../Bloc/cart_event.dart';
import '../../domain/app_db.dart';

class HomePageNavigation extends StatelessWidget {
  const HomePageNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apple, color: Colors.red, size: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Color(0xff4C4F4D),
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Dhaka, Banassre",
                    style: TextStyle(color: Color(0xff4C4F4D), fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xfff2f3f2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 26, color: Color(0xff181B19)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      cursorHeight: 20,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "Search Store",
                        hintStyle: TextStyle(
                          color: Color(0xff181B19),
                          fontSize: 18,
                          fontFamily: "Gilory_SemiBold",
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Color(0xff181B19),
                        fontSize: 18,
                        fontFamily: "Gilory_SemiBold",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Banner List
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HomeScreen.bannerImg.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(HomeScreen
                            .bannerImg[index]["imgpath"]),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            //Categories with Products
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: HomeScreen.itemcategories.length,
              itemBuilder: (context, categoryIndex) {
                final category = HomeScreen.itemcategories[categoryIndex];
                final products = category["products"];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Title
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(
                        category["category"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Product List (Horizontal)
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image
                                Center(
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(product["imgpath"]),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 5),

                                // Product Name
                                Text(
                                  product["name"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // Quantity
                                Text(
                                  product["quantity"],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),

                                const Spacer(),

                                // Price + Add Button
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product["price"],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: MaterialButton(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12),
                                        ),
                                        color: const Color(0xff53B175),
                                        onPressed: () {
                                          //Call Bloc
                                          context.read<CartBloc>().add(
                                            AddToCartEvent(product),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                              const Duration(seconds: 2),
                                              backgroundColor:
                                              const Color(0xff53B175),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              content: Row(
                                                children: [
                                                  const Icon(Icons.check_circle,
                                                      color: Colors.white),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      "${product["name"]} added to cart!",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Icon(Icons.add,
                                            color: Colors.white, size: 28),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            // Footer
            const Align(
              alignment: Alignment.center,
              child: Text(
                "More Items coming soon...",
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}










