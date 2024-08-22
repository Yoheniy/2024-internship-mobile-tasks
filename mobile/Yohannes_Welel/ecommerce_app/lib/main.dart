import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'features/product/domain/entities/product_entity.dart';
import 'features/product/presentation/Auth/pages/signin_page.dart';
import 'features/product/presentation/Auth/pages/signup_page.dart';
import 'features/product/presentation/blocs/product/product_bloc.dart';
import 'features/product/presentation/blocs/user/bloc/user_bloc.dart';
import 'features/product/presentation/pages/details_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/product/presentation/pages/product_add_page.dart';
import 'features/product/presentation/pages/product_search_page.dart';
import 'features/product/presentation/pages/update_page.dart';
import 'injection_container.dart' as lc;
import 'injection_container.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await lc.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserBloc>(),
        ),
    BlocProvider(
      create: (context) => sl<ProductBloc>(),
    ),
      ],
      child: MaterialApp(
        // initialRoute: '/home_page',
        initialRoute: '/splash_screen',
        onGenerateRoute: (settings) {
          if (settings.name == '/splash_screen') {
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          }
          else if (settings.name == '/signin_page') {
            return MaterialPageRoute(builder: (_) => const Loginpage());
          }
          else if (settings.name == '/signup_page') {
            return MaterialPageRoute(builder: (_) =>  const Signuppage());
          }
          else if (settings.name == '/home_page') {
            return MaterialPageRoute(builder: (_) => const Home());
          } else if (settings.name == '/product_add_page') {
            return MaterialPageRoute(builder: (_) => const AddProudctPage());
          } else if (settings.name == '/product_search_page') {
            return MaterialPageRoute(builder: (_) => const ProductSearchPage());
          } else if (settings.name == '/details_page') {
            return MaterialPageRoute(
                builder: (_) =>
                    DetailsPage(selectedProduct: settings.arguments as ProductEntity));
          } else if (settings.name == '/update_page') {
            return MaterialPageRoute(
                builder: (_) =>
                    UpdatePage(selectedProduct: settings.arguments as ProductEntity));
          }
          return null;
        },
        title: 'Flutter App',
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
