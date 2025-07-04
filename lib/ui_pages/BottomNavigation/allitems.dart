import 'package:flutter/material.dart';

import '../../domain/app_db.dart';
import 'cart_provider.dart';

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
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(
              context,
            ); // This will navigate back to the previous screen
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
              SizedBox(height: 20),
              SizedBox(
                height: 1300, // Set fixed height for the product list
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: HomeScreen
                      .itemcategories[selectedIndex]["products"]
                      .length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
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
                          SizedBox(height: 10),
                          // Product Name
                          Text(
                            HomeScreen
                                .itemcategories[selectedIndex]["products"][index]["name"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Quantity
                          Text(
                            HomeScreen
                                .itemcategories[selectedIndex]["products"][index]["quantity"],
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          // Price & Add Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  HomeScreen
                                      .itemcategories[selectedIndex]["products"][index]["price"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 1,
                                    ),
                                    backgroundColor: Color(0xff53B175),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Add the product to the cart
                                    CartProvider.addToCart(
                                      HomeScreen
                                          .itemcategories[selectedIndex]["products"][index],
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${HomeScreen.itemcategories[selectedIndex]["products"][index]["name"]} added to cart!",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
