import 'package:flutter/material.dart';
import '../models/product.class.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => ProductsState();
}

class ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    final myList = <Product>[
      Product(1, 'NOKIA-C1', 99, '99 %',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4ONgEgqUfVda5qKLzf8RiBMA3r1EtPuQueg&s'),
      Product(2, 'BENCO-Y30', 85, '87 %',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYEJF9ykkfTbblROkLVKmrjQC2k4lbA2yqFQ&s'),
      Product(3, 'ITEL-P38', 89, '89 %',
          'https://tunisiatech.tn/8033-large_default/smartphone-itel-p38.jpg'),
      Product(4, 'SPARKGO22', 75, '80 %',
          'https://www.mega.tn/assets/uploads/img/pr_telephonie_mobile/1543051941_211.jpg'),
      Product(5, 'POP2F', 70, '65 %',
          'https://www.technopro-online.com/41138-large_default/smartphone-tecno-pop-2f-noir-tecno-pop2f-black.jpg'),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text('Products'),
            expandedHeight: 20,
            collapsedHeight: 80,
          ),
          const SliverAppBar(
            backgroundColor: Colors.deepOrangeAccent,
            title: Text('Products List'),
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = myList[index];
                return Card(
                  margin: const EdgeInsets.all(15),
                  child: Container(
                    color: Colors.blue[100 * (index % 9 + 1)],
                    height: 80,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/details', arguments: product);
                      },
                      leading: Hero(
                        tag: product.usn,
                        transitionOnUserGestures: true,
                        child: Image.network(product.image, fit: BoxFit.cover),
                      ),
                      title: Text(product.designation,
                          style: const TextStyle(fontSize: 20)),
                      subtitle: Text(product.pourcentage),
                    ),
                  ),
                );
              },
              childCount: myList.length,
            ),
          ),
        ],
      ),
      // Ajout du FloatingActionButton pour ajouter un produit
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigation vers l'écran d'ajout de produit
          Navigator.pushNamed(context, '/AddArticle');
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
