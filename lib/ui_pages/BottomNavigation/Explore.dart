import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/app_db.dart';

class ExplorePageNavigation extends StatelessWidget {
  final List<Map<String, dynamic>> _colorsAndbordercolor = [
    {"backcolor": Color(0x33f8a44c), "bordercolor": Color(0xfff8a44c)},
    {"backcolor": Color(0x33f7a593), "bordercolor": Color(0xfff7a593)},
    {"backcolor": Color(0x33d3b0e0), "bordercolor": Color(0xffd3b0e0)},
    {"backcolor": Color(0x33fde598), "bordercolor": Color(0xfffde598)},
    {"backcolor": Color(0x3353b175), "bordercolor": Color(0xff53b175)},
  ];

  ExplorePageNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    //print("Screen Width: $screenWidth");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "Find Products",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Gilory_SemiBold",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              //search bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xfff2f3f2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.search, size: 26, color: Color(0xff181B19)),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        cursorHeight: 20,
                        keyboardType: TextInputType.text,
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
              GridView.builder(
                shrinkWrap: true,
                itemCount: HomeScreen.itemcategories.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth < 600 ? 2 : (screenWidth < 900 ? 3 : 5),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),

                itemBuilder: (context, index) {
                  int sameindexforcolor = Random().nextInt(
                    _colorsAndbordercolor.length,
                  );
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/allItems",
                        arguments: {"selectedIndex": index},
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _colorsAndbordercolor[sameindexforcolor]["backcolor"],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _colorsAndbordercolor[sameindexforcolor]["bordercolor"],
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: screenWidth * (screenWidth < 600 ? 0.25 : (screenWidth < 900 ? 0.16 : 0.10)),
                              height: screenWidth * (screenWidth < 600 ? 0.25 : (screenWidth < 900 ? 0.16 : 0.10)),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    HomeScreen
                                        .itemcategories[index]["categoryImg"],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenWidth < 600 ? 10 : 0),
                          Text(
                            "Fresh ${HomeScreen.itemcategories[index]["category"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Gilory_SemiBold",
                              fontSize: screenWidth < 600 ? 16 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenWidth < 600 ? 3 : 0),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
