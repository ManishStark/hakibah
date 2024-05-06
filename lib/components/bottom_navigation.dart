import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/screens/categories_screen.dart';
import 'package:hakibah/screens/home_screen.dart';
import 'package:hakibah/screens/profile_screen.dart';
import 'package:hakibah/screens/search_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class PresistantNavbar extends ConsumerStatefulWidget {
  const PresistantNavbar({super.key});

  @override
  ConsumerState<PresistantNavbar> createState() => _PresistantNavbarState();
}

class _PresistantNavbarState extends ConsumerState<PresistantNavbar> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = PersistentTabController(initialIndex: 0);

    List<PersistentBottomNavBarItem> navBarItems() {
      return [
        PersistentBottomNavBarItem(
          contentPadding: 0,
          iconSize: 24,
          icon: SvgPicture.asset("assets/icons/home.svg"),
          title: "Home",
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset("assets/icons/category.svg"),
          title: "Category",
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          title: "Search",
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset("assets/icons/profile.svg"),
          title: "Profile",
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    List<Widget> screens() {
      return [
        const HomeScreen(),
        const CategoryScreen(),
        const SearchScreen(),
        const ProfileScreen(),
      ];
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 63),
      child: PersistentTabView(
        context,
        hideNavigationBarWhenKeyboardShows: true,
        resizeToAvoidBottomInset: true,
        screens: screens(),
        navBarHeight: 63,
        decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(20),
            adjustScreenBottomPaddingOnCurve: true),
        items: navBarItems(),
        controller: controller,
        stateManagement: true,
        popAllScreensOnTapOfSelectedTab: true,
        popAllScreensOnTapAnyTabs: false,
        screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            duration: Duration(milliseconds: 500),
            curve: Easing.standardAccelerate),
        navBarStyle: NavBarStyle.style1,
        onItemSelected: ((index) async {}),
      ),
    );
  }
}
