import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: Center(
        child: Text(
          'Favorite Page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}