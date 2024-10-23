import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<ProductProvider>(context, listen: false).fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.shopping_cart), onPressed: () {
        Navigator.of(context).pushReplacementNamed('/cart');
      },),
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
          title: const Text("Products",style: TextStyle(fontWeight: FontWeight.bold),)),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return ListTile(
                leading: product.image!=""?
                Image.network(product.image):
                const Icon(Icons.image_not_supported_outlined),
                title: Text(product.name,style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Quantity : ${product.quantity}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (product.quantity > 1) {
                                  product.quantity--;
                                  Provider.of<ProductProvider>(context, listen: false).notifyListeners();
                                }
                              },
                            ),
                            Text('${product.quantity}', style: TextStyle(fontSize: 20)),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                product.quantity++;
                                Provider.of<ProductProvider>(context, listen: false).notifyListeners();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text("Price : \u{20B9}${(double.parse(product.price)*product.quantity)}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add,
                  color: Colors.black,),
                  onPressed: ()async{
                    try {
                      String message = await cartProvider.addToCart(product.id, product.quantity);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
