import 'package:flutter/material.dart';
import 'package:projetflutter/screens/menu.dart';
import 'package:projetflutter/screens/subscribe.dart';
import 'package:projetflutter/screens/products.dart';
import 'package:projetflutter/screens/exitscreen.dart';
import 'package:projetflutter/screens/documents.dart';
import 'package:projetflutter/screens/details.dart';
import 'package:projetflutter/screens/sync.dart';
import 'package:projetflutter/screens/settings.dart';
import 'package:projetflutter/screens/profile.dart'; // Créez ce fichier si nécessaire
import 'package:projetflutter/presentation/screens/categorieslist.screen.dart';
import 'package:projetflutter/widgets/myappbar.dart';
import 'package:projetflutter/widgets/mydrawer.dart';
import 'package:projetflutter/widgets/mybottomnavbar.dart';
import 'package:projetflutter/models/product.class.dart';

Map<String, WidgetBuilder> appRoutes() {
  return {
    '/': (context) => const Scaffold(
          appBar: MyAppBar(),
          body: Menu(),
          drawer: MyDrawer(),
          bottomNavigationBar: MyBottomNavigation(),
        ),
    '/Profile': (context) => const ProfileScreen(), // Nouvelle route
    '/Subscribe': (context) => const Subscribe(),
    '/Products': (context) => const Products(),
    '/Exit': (context) => const ExitScreen(),
    '/Documents': (context) => const Documents(),
    '/details': (context) {
      final product = ModalRoute.of(context)!.settings.arguments as Product;
      return Details(myListElement: product);
    },
    '/Categories': (context) => const CategoriesListScreen(),
    '/Sync': (context) => const SyncScreen(),
    '/Settings': (context) => const SettingsScreen(),
  };
}
