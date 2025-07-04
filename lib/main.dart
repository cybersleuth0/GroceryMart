import 'package:flutter/material.dart';
import 'package:grocerymart/App_Constant/constant.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.ROUTE_BASEHOMEPAGE,
      routes: AppRoutes.getRoute(),
    ),
  );
}

// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => RegisterBloc(
//             userRepo: Userrepository(dbConnector: DBHelper.getInstance()),
//           ),
//         ),
//         BlocProvider(
//           create: (context) => LoginBloc(
//             userRepo: Userrepository(dbConnector: DBHelper.getInstance()),
//           ),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: AppRoutes.ROUTE_BASEHOMEPAGE,
//         routes: AppRoutes.getRoute(),
//       ),
//     ),
//   );
// }
