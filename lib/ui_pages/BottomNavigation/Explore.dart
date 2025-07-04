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
                  childAspectRatio: 0.8,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20, //use for space between columns
                  mainAxisSpacing: 20, //use for space between Rows
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
                        color:
                            _colorsAndbordercolor[sameindexforcolor]["backcolor"],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              _colorsAndbordercolor[sameindexforcolor]["bordercolor"],
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              width: 120,
                              height: 120,
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
                          SizedBox(height: 30),
                          Text(
                            "Fresh ${HomeScreen.itemcategories[index]["category"]}",
                            style: TextStyle(
                              fontFamily: "Gilory_SemiBold",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
}
