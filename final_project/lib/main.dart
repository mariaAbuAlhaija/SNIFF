import 'package:final_project/globals.dart';
import 'package:final_project/models/address.dart';
import 'package:final_project/models/brand.dart';
import 'package:final_project/models/order.dart';
import 'package:final_project/models/product.dart';
import 'package:final_project/providers/address_provider.dart';
import 'package:final_project/providers/product_provider.dart';
import 'package:final_project/providers/review_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:final_project/screens/address.dart';
import 'package:final_project/screens/brands.dart';
import 'package:final_project/screens/cart.dart';
import 'package:final_project/screens/display_brand.dart';
import 'package:final_project/screens/display_product.dart';
import 'package:final_project/screens/gender_products.dart';
import 'package:final_project/screens/navigation.dart';
import 'package:final_project/screens/new_address.dart';
import 'package:final_project/screens/order_details.dart';
import 'package:final_project/screens/orders.dart';
import 'package:final_project/screens/place_order.dart';
import 'package:final_project/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (BuildContext context, Widget? child) {
          return MultiProvider(
            providers: [
              ListenableProvider<AddressProvider>(
                create: (context) => AddressProvider(),
              ),
              ListenableProvider<ProductsProvider>(
                create: (context) => Globals().productProvider,
              ),
              ListenableProvider<UserProvider>(
                create: (context) => Globals().userProvider,
              ),
              ListenableProvider<ReviewProvider>(
                create: (context) => ReviewProvider(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo', debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                primarySwatch: Colors.orange,
              ),
              // home: MyFirstStatefulWidget(),

              builder: EasyLoading.init(),
              initialRoute: "/",
              onGenerateRoute: (settings) {
                var routes = {
                  "/": (context) => Preload(),
                  "/start": (context) => StartScreen(),
                  "/home": (context) => Navigation(),
                  "/cart": (context) => Cart(),
                  "/brands": (context) => Brands(),
                  "/address": (context) =>
                      AddressScreen(settings.arguments as bool),
                  "/new_address": (context) =>
                      NewAddress(settings.arguments as bool),
                  "/order": (context) =>
                      PlaceOrder(settings.arguments as Address),
                  "/orderDetails": (context) =>
                      OrderDetails(settings.arguments as Order),
                  "/orders": (context) => OrdersView(),
                  "/brand": (context) =>
                      DisplayBrand(settings.arguments as Brand),
                  "/gender_products": (context) =>
                      GenderProducts(settings.arguments as genderArgs),
                  "/product": (context) =>
                      DisplayProduct(settings.arguments as Product),
                };
                WidgetBuilder builder = routes[settings.name]!;
                return MaterialPageRoute(builder: (ctx) => builder(ctx));
              },
            ),
          );
        });
  }
}

class Preload extends StatefulWidget {
  const Preload({super.key});

  @override
  State<Preload> createState() => PpreloadState();
}

class PpreloadState extends State<Preload> {
  @override
  void initState() {
    super.initState();
    authorization();
  }

  Future<void> authorization() async {
    var storge = FlutterSecureStorage();
    var authorized = await storge.containsKey(key: "token");
    authorized
        ? Navigator.pushReplacementNamed(context, "/home")
        : Navigator.pushReplacementNamed(context, "/start");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
