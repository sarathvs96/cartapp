import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CartProvider>(context, listen: false).fetchCartItems());
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      floatingActionButton: Text(
        'Total Amount: ₹${cartProvider.totalCartPrice.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            // Navigator.of(context).pushReplacementNamed('/cart');
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
        title: const Text('Cart',style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer<CartProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.cartItems.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: productProvider.cartItems.length,
            itemBuilder: (context, index) {
              final product = productProvider.cartItems[index];
              return ListTile(
                leading: product.image!=""?
                Image.network(product.image):
                const Icon(Icons.image_not_supported_outlined),
                title: Text(product.productName,style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quantity : ${product.quantity}"),
                    Text("Price : \u{20B9}${product.price}"),
                  ],
                )
              );
            },
          );
        },
      ),
    );
  }
}
