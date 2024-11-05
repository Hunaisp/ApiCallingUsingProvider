import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/CategoryProvider.dart';
import '../Provider/product_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch categories when the screen is initialized
    Future.microtask(() =>
        Provider.of<ProductProvider>(context, listen: false).fetchProducts());
    Future.microtask(() =>
        Provider.of<CategoryProvider>(context, listen: false).fetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(
        children: [
          SizedBox(height: 100,child:  categoryProvider.isLoading
              ? Center(child: SizedBox())
              : categoryProvider.errorMessage != null
              ? Center(child: Text(categoryProvider.errorMessage!))
              : ListView.builder(scrollDirection: Axis.horizontal,
            itemCount: categoryProvider.categories.length,
            itemBuilder: (context, index) {
              final category = categoryProvider.categories[index];
              return CircleAvatar(child: Center(child: Text(category.catName==null?'':category.catName.toString()),),);
            },
          ),),
          Expanded(
            child: productProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : productProvider.errorMessage != null
                ? Center(child: Text(productProvider.errorMessage!))
                : ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final products = productProvider.products[index];
                return ListTile(
                  leading: products.partImage!=null
                      ? Image.network( products.partImage.toString(), width: 50, height: 50)
                      : Placeholder(),
                  title: Text(products.partsName==null?"":products.partsName),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
