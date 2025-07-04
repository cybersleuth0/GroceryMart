class CartProvider {
  // Global list to store cart items
  static List<Map<String, dynamic>> cartItems = [];

  // Method to add a product to the cart
  static void addToCart(Map<String, dynamic> product) {
    bool exists = cartItems.any((item) => item["name"] == product["name"]);

    if (exists) {
      // Increase quantity if item already exists
      for (var item in cartItems) {
        if (item["name"] == product["name"]) {
          item["quantity"] =
              (item["quantity"] as int) + 1; // Explicit cast to int
        }
      }
    } else {
      // Add new item with quantity 1
      Map<String, dynamic> newProduct = Map.from(product); // Create a copy
      newProduct["quantity"] = 1; // Ensure quantity is an integer
      cartItems.add(newProduct);
    }
  }

  // Method to remove a product from the cart
  static void removeFromCart(String productName) {
    cartItems.removeWhere((item) => item["name"] == productName);
  }

  // Method to update the quantity of an item
  static void updateQuantity(String productName, int change) {
    for (var item in cartItems) {
      if (item["name"] == productName) {
        item["quantity"] += change;
        if (item["quantity"] <= 0) {
          cartItems.remove(item); // Remove item if quantity is 0
        }
        break;
      }
    }
  }

  // Method to calculate the total price of items in the cart
  static String getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      double itemPrice =
          double.parse(item["price"].replaceAll("Rs", "").trim());
      total += itemPrice * item["quantity"]; // Multiply by quantity
    }
    return "${total.toStringAsFixed(2)} Rs";
  }
}
