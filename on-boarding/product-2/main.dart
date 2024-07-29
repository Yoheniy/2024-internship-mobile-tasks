
import 'dart:io';

import 'Product.dart';
import 'ProductManager.dart';

void main(){

   
  ProductManager customer_manager =ProductManager();
  print('                                                                           ');
  print('                                                                           ');
  print('                                                                           ');
  print('                                                                           ');
  print('                                                                           ');
  print('                                                                           ');
  

 

  int choice=0;
  while (choice!=6){
  print("======================E-CCOMMERCE PROJECT=================================");
  print('                                                                           ');
  print('                                                                           ');

  print("                 Menu");
  print('                                                                           ');
  print('                                                                           ');
  print("1. Add a new Product");
  print("2. View All Product");
  print("3. View a Single Product");
  print("4. Edit a Product");
  print("5. Delete a Product");
  print("6. Exit");


  choice=int.parse(stdin.readLineSync()??'0');

  switch (choice){
    case 1:
      customer_manager.addProduct();
      break;
    case 2:
      customer_manager.viewAllProducts();
      break;
    case 3:
      customer_manager.viewOneProduct();
      break;
    case 4:
      customer_manager.editProduct();
      break;
    case 5:
      customer_manager.deleteProduct();
      break;
    case 6:
      choice=6;
      print('Thank You!');
      exit(0);
    default:
      print('Invalid option.Please try again. ');

      
      

  }

  }



}