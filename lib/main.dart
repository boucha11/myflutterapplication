import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:projetflutter/approuter.dart';
import 'package:projetflutter/data/datasource/localdatasource/user_local_data_source.dart';
import 'package:projetflutter/data/datasource/services/article.service.dart';
import 'package:projetflutter/data/datasource/services/categorie.service.dart';
import 'package:projetflutter/data/repositories/article.repository.dart';
import 'package:projetflutter/data/repositories/categorie.repository.dart';
import 'package:projetflutter/data/repositories/user.repository.dart';
import 'package:projetflutter/domain/usecases/article.usecase.dart';
import 'package:projetflutter/domain/usecases/categorie.usecase.dart';
import 'package:projetflutter/domain/usecases/user.usecase.dart';
import 'package:projetflutter/presentation/controllers/article.controller.dart';
import 'package:projetflutter/presentation/controllers/user.controller.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser le panier persistant
  await PersistentShoppingCart().init();

  // Injection des dépendances pour les articles
  Get.put(ArticleService());
  Get.put(ArticleRepository(artserv: Get.find()));
  Get.put(ArticleUseCase(repository: Get.find()));
  // ArticleController requires ArticleService
  Get.put(ArticleController(articleService: Get.find<ArticleService>()));

  // Injection des dépendances pour les catégories
  Get.put(CategorieService());
  Get.put(CategorieRepository(catserv: Get.find()));
  Get.put(CategorieUseCase(repository: Get.find()));
  // CategorieController requires CategorieUseCase with parameter 'useCase'

  // Injection pour l'authentification
  Get.put(UserLocalDataSource());
  Get.put(UserRepository(localDataSource: Get.find()));
  Get.put(AuthenticateUserUseCase(repository: Get.find()));
  Get.put(AuthController(userUseCase: Get.find()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: appRoutes(),
    );
  }
}
