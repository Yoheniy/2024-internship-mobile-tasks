import 'dart:io';

import 'product.dart';


class ProductManager {
  List<Product> products = [];

  void addProduct(){
    print('Please Enter Product name: ');
    String? name=stdin.readLineSync();
    print('Enter Product description: ');
    String? description=stdin.readLineSync();
    print('Enter Product price: ');
    double price=double.parse(stdin.readLineSync() ?? '0');

    Product prod=Product(name,description,price);

    products.add(prod);

    print('Product added successfully.');
    print('                             ');



  }

  void viewAllProducts(){
    if(products.length==0){
      print('There is NO product Available');
      print('                             ');
    }
    else{
      for (var product in products){
        print(product.name);
        print(product.description);
        print(product.price);
        print('                             ');
      }

    }
  }

    void viewOneProduct(){
      if(products.length==0){
      print('There is NO product Available');
      print('                             ');
    }
    else{
      print('Enter the number of product you want to view ');

      var number=1;
      for (var product in products){
        print('$number . ${product.name}');

        number++;

      }


      int? indx=int.parse(stdin.readLineSync()??'0');
      print(products[indx-1].name);
      print(products[indx-1].description);
      print(products[indx-1].price);
      print('                             ');
    }

    
    }

    void editProduct(){
      print('Enter the number of the product you want to edit: ');

      var number=1;
      for (var product in products){
        print('$number . ${product.name}');
        number++;

      }

    int? indx=int.parse(stdin.readLineSync()??'0');

    print('Current Product name is:${products[indx-1].name}');
    print('Current Product description is:${products[indx-1].description}');
    print('Current Product price is:${products[indx-1].price}');

    print('Please Enter the new Product name');
    String? new_name = stdin.readLineSync();
    products[indx-1].name=new_name;

    print('Please Enter the new description');
    String? new_description = stdin.readLineSync();
    products[indx-1].description=new_description;


    print('Please Enter the new price');
    String? new_price = stdin.readLineSync();
    products[indx-1].name=new_price;
    print('the edit is successfully completed');
    print('                                   ');

      
    }


    void deleteProduct(){
      print('Enter the number of product you want to be delete: ');

      
      var number=1;
      for (var product in products){
        print('$number . ${product.name}');
        number++;

      }

      int? indx=int.parse(stdin.readLineSync()??'0');
      products.removeAt(indx-1);

      print('the deletion is completed');
      print('                         ');


    }
    
  }




