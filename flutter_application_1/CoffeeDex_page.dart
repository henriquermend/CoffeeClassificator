import 'package:flutter/material.dart';
import 'package:CoffeeClassifier/models/coffe_bean.dart';
import 'package:CoffeeClassifier/widgets/coffe_card.dart';

class COffeePokedexPage extends StatelessWidget{
  final List<CoffeeBean> coffeeBeans =
[
  CoffeeBean(
    id : "1",
    name : "Arabica",
    description : "Mild and aromatic flavor",
    imageURl : "https://example.com/image/arabica.jpg"
  ),
  CoffeeBean(
    id : "2",
    name : "Robusta",
    description : "Strong and full-bodied",
    imageURl : "https://example.com/image/robust.jpg"
  ),
  CoffeeBean(
    id : "3",
    name : "Bourbon",
    description : "Complex flavor and smooth body",
    imageURl : "https://example.com/image/robust.jpg"
  ),
  CoffeeBean(
    id : "4",
    name : "Catuaí",
    description : "Sweet taste and balanced acidity",
    imageURl : "https://example.com/image/robust.jpg"
  ),
  CoffeeBean(
    id : "5",
    name : "Mundo Novo",
    description : "High yield and rich flavor profile",
    imageURl : "https://example.com/image/robust.jpg"
  ),
];
  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: TExt('Coffee Pokedex'),
    ),
   body: ListView.builder(
    itemCount: coffeeBeans.length,
    itemBuilder: (context,index) {
      return
CoffeeCard(coffeeBeans[index]);      
 },
   ), 
  );
 }     
}
