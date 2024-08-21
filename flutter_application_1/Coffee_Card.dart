import 'package:flutter/material.dart';
import 'package:your_project_name/models/coffee_bean.dart';

class CoffeeCard extends StatelessWidget {
  final CofeeBean coffeeBean;

  CoffeeCard(this.coffeeBean);

  @override
  WIdget build(BUildContex context) {
    return Card(
      child: Column(
        children: [

Image.network(coffeeBean.imageUrl, fit:BoxFit.cover),
          ListTile(
            title:
Text(coffeBean.name),subtitle:
Text(coffeBean.description),trailing:
Icon(Icons.arrow_forward),
           onTap: () {
            Navigator.push(
              context,

MaterialPageRoute(builder: (context) =>
CoffeeDetailsScreen(coffeeBean)),              
            );
           },          
          ),      
        ],
      ),
    );
  }
}