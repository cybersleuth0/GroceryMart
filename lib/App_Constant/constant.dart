import 'package:flutter/material.dart';
import '../ui_pages/BottomNavigation/Explore.dart';
import '../ui_pages/BottomNavigation/HomePage.dart';
import '../ui_pages/BottomNavigation/allitems.dart';
import '../ui_pages/basehomepage.dart';

class AppRoutes {
  // This route for the Get Started screen
  static const String ROUTE_GETSTARTED = "/getstarted";

  // This route for the Base Home Page screen
  static const String ROUTE_BASEHOMEPAGE = "/basehomepage";

  //below this are navigation pages
  // This route for the Home page navigation screen
  static const String ROUTE_HOME = "/homepageNavigation";

  // This route for the Explore page navigation screen
  static const String ROUTE_EXPLORE = "/explorePageNavigation";

  // This route for the All Items page navigation screen
  static const String ROUTE_ALLITEMS = "/allItems";

  // Method to return a map of route names to widget builders
  static Map<String, WidgetBuilder> getRoute() => {
    ROUTE_BASEHOMEPAGE: (context) => Basehomepage(),
    // navigation pages route
    ROUTE_HOME: (context) => HomePageNavigation(),
    ROUTE_EXPLORE: (context) => ExplorePageNavigation(),
    ROUTE_ALLITEMS: (context) => AllItems(),
  };
}

class AppConstant {
  // Constant class to store the name of the key for shared preference
  //for login value
  static const String isLogedIN = "is_login";
}
