import 'package:flutter/material.dart';
import 'package:lo_rent/app_provider.dart';
import 'package:lo_rent/widgets/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class RootView extends StatelessWidget {
  const RootView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: MainDrawerWidget(),
      //   elevation: 0,
      // ),
      body: Provider.of<ProviderData>(context).currentPage,
      bottomNavigationBar: CustomBottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        itemColor: Theme.of(context).accentColor,
        currentIndex: Provider.of<ProviderData>(context).currentIndex,
        onChange: (index) {
          Provider.of<ProviderData>(context, listen: false)
              .changePageInRoot(index);
        },
        children: [
          CustomBottomNavigationItem(
            icon: Icons.home_outlined,
            label: "Home",
          ),
          CustomBottomNavigationItem(
            icon: Icons.assignment_outlined,
            label: "Bookings",
          ),
          CustomBottomNavigationItem(
            icon: Icons.home_repair_service_outlined,
            label: "Services",
          ),
          CustomBottomNavigationItem(
            icon: Icons.chat_outlined,
            label: "Chats",
          ),
        ],
      ),
    );
  }
}
