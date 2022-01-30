import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coodesh_store/api/firebase/firebase_api.dart';
import 'package:coodesh_store/bloc/product/product_bloc.dart';
import 'package:coodesh_store/models/interfaces/cloud_image_api_interface.dart';
import 'package:coodesh_store/models/interfaces/database_api_interface.dart';
import 'package:coodesh_store/models/interfaces/product_repository_interface.dart';
import 'package:coodesh_store/api/cloudinary_api.dart';
import 'package:coodesh_store/repositories/products_repository.dart';
import 'package:coodesh_store/ui/routes/app_router.dart';
import 'package:get_it/get_it.dart';

void main() async {
  //Inicializa o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final dependencies = GetIt.instance;

  //Responsável por registrar as dependências no app. Assim, qualquer classe
  //que implemente a interface IProductRepository pode ser utilizada, diminuindo
  //o acoplamento do código.
  registerDependencies(dependencies);

  //Faz a barra de status do Android ficarem transparentes e os ícones com tema escuro.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    BlocProvider(
      create: (context) {
        return ProductBloc(
          productsRepository: dependencies<IProductRepository>(),
        )..add(ProductsLoadingEvent());
      },
      child: MyApp(),
    ),
  );
}

void registerDependencies(GetIt dependency) {
  // Registra lazy singletons para injeção de dependências.
  dependency.registerLazySingleton<IProductRepository>(
    () => ProductsRepository(),
  );

  dependency.registerLazySingleton<IDatabaseApi>(
    () => FirebaseApi(),
  );

  dependency.registerLazySingleton<ICloudImageApi>(
    () => CloudinaryApi(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _appRouter.onGenerateRoute,
      navigatorKey: navigatorKey,
    );
  }
}
