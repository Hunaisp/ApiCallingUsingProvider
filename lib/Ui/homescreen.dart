import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/category_provider.dart';


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
        Provider.of<CategoryProvider>(context, listen: false).fetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: categoryProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : categoryProvider.errorMessage != null
          ? Center(child: Text(categoryProvider.errorMessage!))
          : ListView.builder(
        itemCount: categoryProvider.categories.length,
        itemBuilder: (context, index) {
          final category = categoryProvider.categories[index];
          return ListTile(
            leading: category.partImage!=null
                ? Image.network( category.partImage.toString(), width: 50, height: 50)
                : Icon(Icons.category),
            title: Text(category.partsName==null?"":category.partsName),
          );
        },
      ),
    );
  }
}
