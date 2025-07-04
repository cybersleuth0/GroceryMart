import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialState()) {
    //Add to cart event
    on<AddToCartEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final prefs = await SharedPreferences.getInstance();
        // Step 1: Get the current cart from SharedPreferences
        List<String> storedItems = prefs.getStringList("product") ?? [];

        //Step 2: Decode to List<Map<String, dynamic>>
        List<Map<String, dynamic>> cartItems = [];

        for (String item in storedItems) {
          Map<String, dynamic> decodedItem = Map<String, dynamic>.from(
            json.decode(item),
          );
          cartItems.add(decodedItem);
        }

        bool doesItemExist = false;
        for (var item in cartItems) {
          if (item["name"] == event.product["name"]) {
            item["quantity"] += 1;
            doesItemExist = true;
            break;
          }
        }
        // Step 4: If new product, add to cart
        if (!doesItemExist) {
          final newItem = Map<String, dynamic>.from(event.product);
          newItem["quantity"] = 1;
          cartItems.add(newItem);
        }
        // Step 5: Save back to SharedPreferences
        List<String> encodedList = [];

        for (var item in cartItems) {
          String encodedItem = json.encode(item); // Convert map to string
          encodedList.add(encodedItem);
        }
        await prefs.setStringList("product", encodedList);

        emit(SuccessState(cartItems));
      } catch (e) {
        emit(FailureState("Failed to add item to cart: $e"));
      }
    });

    //Load cart event
    on<LoadCartEvent>((event, emit) async {
      emit(LoadingState());

      final prefs = await SharedPreferences.getInstance();
      final storedItems = prefs.getStringList("product") ?? [];
      List<Map<String, dynamic>> cartItems = [];

      for (String item in storedItems) {
        cartItems.add(Map<String, dynamic>.from(json.decode(item)));
      }

      // Calculate total
      double total = 0;
      for (var item in cartItems) {
        final price =
            double.tryParse(item["price"].replaceAll("Rs", "").trim()) ?? 0;
        total += price * (item["quantity"] ?? 1);
      }

      emit(
        CartLoadedState(
          cartItems: cartItems,
          totalPrice: "${total.toStringAsFixed(2)} Rs",
        ),
      );
    });
  }
}
