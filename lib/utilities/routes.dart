import 'package:flutter/widgets.dart';
import 'package:lo_rent/modules/bookings/bookings_screen.dart';
import 'package:lo_rent/modules/chats/chats_screen.dart';
import 'package:lo_rent/modules/google_map/google_map_screen.dart';
import 'package:lo_rent/modules/home/home_screen.dart';
import 'package:lo_rent/modules/loading/loading_screen.dart';
import 'package:lo_rent/modules/login/login_screen.dart';
import 'package:lo_rent/modules/owner_specific/house_listings/add_house_listing.dart';
import 'package:lo_rent/modules/profile/add_company_screen.dart';
import 'package:lo_rent/modules/profile/profile_screen.dart';
import 'package:lo_rent/modules/profile/service_provider_profile_screen.dart';
import 'package:lo_rent/modules/root/root_view.dart';
import 'package:lo_rent/modules/services_listing/services_listing_screen.dart';

class RouteNames {
  static const String LOADING = '/';
  static const String LOGIN = '/login';
  static const String PROFILE = '/profile';
  static const String SERVICE_PROFILE = '/service_profile';
  static const String ADD_COMPANY = '/add_company';
  static const String ROOT = '/root';
  static const String HOME = '/home';
  static const String BOOKINGS = '/bookings';
  static const String SERVICES_LISTING = '/services_listing';
  static const String CHATS = '/chats';
  static const String ADD_HOUSE_LISTING = '/add_house_listing';
  static const String GOOGLE_MAP_SCREEN = '/google_map_screen';

  static const String INITIAL = RouteNames.LOADING;
}

Map<String, Widget> routes = {
  RouteNames.LOADING: LoadingScreen(),
  RouteNames.LOGIN: LoginScreen(),
  RouteNames.PROFILE: ProfileScreen(),
  RouteNames.SERVICE_PROFILE: ServiceProviderProfileScreen(),
  RouteNames.ADD_COMPANY: AddCompanyScreen(),
  RouteNames.ROOT: RootView(),
  RouteNames.HOME: HomeScreen(),
  RouteNames.BOOKINGS: BookingsScreen(),
  RouteNames.SERVICES_LISTING: ServicesListingScreen(),
  RouteNames.CHATS: ChatsScreen(),
  RouteNames.ADD_HOUSE_LISTING: AddHouseListingScreen(),
  RouteNames.GOOGLE_MAP_SCREEN: GoogleMapScreen(),
};

class SlideRoute extends PageRouteBuilder {
  SlideRoute({String routeName})
      : super(
          settings: RouteSettings(name: routeName), // set name here
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              routes[routeName],
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: Duration(milliseconds: 1000),
        );
}

class FadeInRoute extends PageRouteBuilder {
  FadeInRoute({String routeName})
      : super(
          settings: RouteSettings(name: routeName), // set name here
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              routes[routeName],
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: Duration(milliseconds: 1000),
        );
}

// static const String INITIAL = RouteNames.LOADING;
// static Route<dynamic> getRoutes(RouteSettings settings) {
//   switch (settings.name) {
//     case RouteNames.LOADING:
//       return CupertinoPageRoute(
//           builder: (_) => LoadingScreen(), settings: settings);
//     case RouteNames.LOGIN:
//       return CupertinoPageRoute(
//           builder: (_) => LoginScreen(), settings: settings);
//     default:
//       return null;
//   }
// }
