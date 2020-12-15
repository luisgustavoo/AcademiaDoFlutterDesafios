import 'package:flutter/material.dart';
import 'package:flutter_mao_na_massa/fornecedor_model.dart';
import 'package:flutter_mao_na_massa/home_page.dart';
import 'package:flutter_mao_na_massa/shop_cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white.withAlpha(500)),
      home: HomePage(),
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case '/order':
            final fornecedor = settings.arguments as Fornecedor;
            page = ShopCart(fornecedor: fornecedor);
            break;
        }

        return MaterialPageRoute(settings: settings, builder: (_) => page);
      },
    );
  }
}
