import 'package:flutter/material.dart';

import '../../domain/app_db.dart';
import 'cart_provider.dart';

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
                  // Smaller text
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //search bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xfff2f3f2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 26, color: Color(0xff181B19)),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        cursorHeight: 20,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Search Store",
                          hintStyle: TextStyle(
                            color: Color(0xff181B19),
                            fontSize: 18,
                            fontFamily: "Gilory_SemiBold",
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color(0xff181B19),
                          fontSize: 18,
                          fontFamily: "Gilory_SemiBold",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //horizontal Banner listview
              SizedBox(
                height: 100,
                width: 1000,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: HomeScreen.bannerImg.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            HomeScreen.bannerImg[index]["imgpath"],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              //horizontal listview for fruits
              SizedBox(
                height: 800,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: HomeScreen.itemcategories.length,
                  itemBuilder: (context, categoryindex) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Title
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Text(
                            HomeScreen
                                .itemcategories[categoryindex]["category"],
                            // Category Name
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200, // Set fixed height for the product list
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // Fix nested scrolling issue
                            itemCount: HomeScreen
                                .itemcategories[categoryindex]["products"]
                                .length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
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
                                                  .itemcategories[categoryindex]["products"][index]["imgpath"],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Product Name
                                    Text(
                                      HomeScreen
                                          .itemcategories[categoryindex]["products"][index]["name"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // Quantity
                                    Text(
                                      HomeScreen
                                          .itemcategories[categoryindex]["products"][index]["quantity"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    // Price & Add Button
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            HomeScreen
                                                .itemcategories[categoryindex]["products"][index]["price"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                          height:40,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 1,
                                              ),
                                              backgroundColor: Color(
                                                0xff53B175,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            onPressed: () {
                                              // Add the product to the cart
                                              CartProvider.addToCart(
                                                HomeScreen
                                                    .itemcategories[categoryindex]["products"][index],
                                              );
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "${HomeScreen.itemcategories[categoryindex]["products"][index]["name"]} added to cart!",
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
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  "More Items comming soon...",
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
