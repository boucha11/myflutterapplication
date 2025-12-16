import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetflutter/presentation/controllers/article.controller.dart';
import 'package:projetflutter/presentation/screens/addarticle.screen.dart';

class ArticlesListScreen extends StatefulWidget {
  const ArticlesListScreen({super.key});

  @override
  State<ArticlesListScreen> createState() => _ArticlesListScreenState();
}

class _ArticlesListScreenState extends State<ArticlesListScreen> {
  final ArticleController controller = Get.find<ArticleController>();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredArticles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllArticles();
    });
    _searchController.addListener(_filterArticles);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchController.removeListener(_filterArticles);
    super.dispose();
  }

  void _filterArticles() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredArticles = controller.articlesList.toList();
      } else {
        _filteredArticles = controller.articlesList
            .where((article) =>
                article.designation.toLowerCase().contains(query) ||
                (article.reference?.toLowerCase().contains(query) ?? false) ||
                (article.marque?.toLowerCase().contains(query) ?? false))
            .toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterArticles();
  }

  void _navigateToAddArticle() {
    Get.to(() => const AddArticleScreen());
  }

  void _refreshArticles() {
    controller.fetchAllArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshArticles,
            tooltip: 'Actualiser',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddArticle,
            tooltip: 'Ajouter un produit',
          ),
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un produit...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) => _filterArticles(),
            ),
          ),
          // Liste des articles
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Chargement des produits...'),
                    ],
                  ),
                );
              }

              final articlesToShow = _searchController.text.isEmpty
                  ? controller.articlesList
                  : _filteredArticles;

              if (articlesToShow.isEmpty && _searchController.text.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_off,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aucun produit trouvé pour "${_searchController.text}"',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _clearSearch,
                        child: const Text('Effacer la recherche'),
                      ),
                    ],
                  ),
                );
              }

              if (articlesToShow.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Aucun produit disponible',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _navigateToAddArticle,
                        icon: const Icon(Icons.add),
                        label: const Text('Ajouter le premier produit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchAllArticles();
                },
                child: ListView.builder(
                  itemCount: articlesToShow.length,
                  itemBuilder: (context, index) {
                    final article = articlesToShow[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: article.imageart != null &&
                                  article.imageart!.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    article.imageart!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.shopping_bag,
                                        color: Colors.grey[500],
                                        size: 30,
                                      );
                                    },
                                  ),
                                )
                              : Icon(
                                  Icons.shopping_bag,
                                  color: Colors.grey[500],
                                  size: 30,
                                ),
                        ),
                        title: Text(
                          article.designation,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              '${article.prix} €',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Stock: ${article.qtestock} unités',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            if (article.marque != null &&
                                article.marque!.isNotEmpty)
                              Text(
                                'Marque: ${article.marque}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (article.reference != null &&
                                article.reference!.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  article.reference!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onTap: () {
                          // Action quand on clique sur un article
                          Get.snackbar(
                            article.designation,
                            '${article.prix} € • Stock: ${article.qtestock}',
                            backgroundColor: Colors.blue,
                            colorText: Colors.white,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddArticle,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
