import 'package:flutter/material.dart';
import 'package:projetflutter/screens/menu.dart';
import 'package:projetflutter/screens/subscribe.dart';
import 'package:projetflutter/screens/products.dart';
import 'package:projetflutter/screens/exitscreen.dart';
import 'package:projetflutter/screens/documents.dart';
import 'package:projetflutter/screens/details.dart';
import 'package:projetflutter/screens/sync.dart';
import 'package:projetflutter/screens/settings.dart';
// Import relatif
import './presentation/screens/categorieslist.screen.dart';
import './presentation/screens/login.screen.dart';
import './presentation/screens/register.screen.dart';
import './presentation/screens/articleslist.screen.dart';
import './presentation/screens/cart.view.dart';
import 'package:projetflutter/widgets/myappbar.dart' as appbar;
import 'package:projetflutter/widgets/mydrawer.dart' as drawer;
import 'package:projetflutter/widgets/mybottomnavbar.dart' as bottom;
import 'package:projetflutter/models/product.class.dart';

Map<String, WidgetBuilder> appRoutes() {
  return {
    '/': (context) => Scaffold(
          appBar: const appbar.MyAppBar(),
          body: const Menu(),
          drawer: const drawer.MyDrawer(),
          bottomNavigationBar: const bottom.MyBottomNavigation(),
        ),
    '/Products': (context) => const Products(),
    '/Exit': (context) => const ExitScreen(),
    '/Documents': (context) => const Documents(),
    '/details': (context) {
      final product = ModalRoute.of(context)!.settings.arguments as Product;
      return Details(myListElement: product);
    },
    '/Subscribe': (context) => const Subscribe(),
    '/Categories': (context) => const CategoriesListScreen(), // Ici
    '/Sync': (context) => const SyncScreen(),
    '/Settings': (context) => const SettingsScreen(),
    '/Login': (context) => const LoginScreen(),
    '/Register': (context) => const RegisterScreen(),
    '/Shopping': (context) => const ArticlesListScreen(),
    '/cartView': (context) => const CartView(),
  };
}
