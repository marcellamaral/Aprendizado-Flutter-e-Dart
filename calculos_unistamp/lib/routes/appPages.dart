import 'package:calculos_unistamp/routes/routes.dart';
import 'package:calculos_unistamp/screens/aber.dart';
import 'package:calculos_unistamp/screens/comp.dart';
import 'package:calculos_unistamp/screens/esp.dart';
import 'package:calculos_unistamp/screens/home.dart';
import 'package:calculos_unistamp/screens/splashScreen.dart';
import 'package:calculos_unistamp/screens/ton.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const Home(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
      //binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.tonelagemPage,
      page: () => Tonelagem(),
    ),
    GetPage(
      name: Routes.espessuraPage,
      page: () => Espessura(),
    ),
    GetPage(
      name: Routes.comprimentoPage,
      page: () => Comprimento(),
    ),
    GetPage(
      name: Routes.aberturaPage,
      page: () => Abertura(),
    ),
  ];
}
