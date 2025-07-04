import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/cart_bloc.dart';
import '../../Bloc/cart_event.dart';
import '../../domain/app_db.dart';

class AllItems extends StatelessWidget {
  const AllItems({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int selectedIndex = args["selectedIndex"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "${HomeScreen.itemcategories[selectedIndex]["category"]}",
          style: TextStyle(
            fontFamily: "Gilory_SemiBold",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 40),
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                itemCount:
                    HomeScreen.itemcategories[selectedIndex]["products"].length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  HomeScreen
                                      .itemcategories[selectedIndex]["products"][index]["imgpath"],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Product Name
                        Text(
                          HomeScreen
                              .itemcategories[selectedIndex]["products"][index]["name"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Quantity
                        Text(
                          HomeScreen
                              .itemcategories[selectedIndex]["products"][index]["quantity"],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Price & Add Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                HomeScreen
                                    .itemcategories[selectedIndex]["products"][index]["price"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1,
                                  ),
                                  backgroundColor: Color(0xff53B175),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  // Add the product to the cart
                                  context.read<CartBloc>().add(
                                    AddToCartEvent(
                                      HomeScreen
                                          .itemcategories[selectedIndex]["products"][index],
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              "${HomeScreen.itemcategories[selectedIndex]["products"][index]["name"]} added to cart!",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Color(0xff53B175),
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
