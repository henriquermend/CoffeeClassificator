import 'packag:flutter/material.dart';

class CoffeeState with ChangeNOtifier
{
   // Define your stte variables and methods here
    list <CoffeeBean> _coffeeBeans = [];
    list <CoffeeBean> get coffeBEans => _coffeeBeans;
    
    void addCoffeeBEan(CoffeeBean bean)
{ 
    _coffeBeans.add(bean);
    notify Listeners();
 } 
}     
