import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerymart/App_Constant/constant.dart';

import 'Bloc/cart_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.ROUTE_BASEHOMEPAGE,
        routes: AppRoutes.getRoute(),
      ),
    ),
  );
}
