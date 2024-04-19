import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/screens/categories_screen.dart';
import 'package:hakibah/screens/home_screen.dart';
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
          icon: const Icon(Icons.video_collection_rounded),
          title: "Home",
          activeColorPrimary: whiteColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.search),
          title: "Search",
          activeColorPrimary: whiteColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: "Profile",
          activeColorPrimary: whiteColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: "File",
          activeColorPrimary: whiteColor,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    List<Widget> screens() {
      return [
        const HomeScreen(),
        const CategoryScreen(),
        const HomeScreen(),
        const HomeScreen(),
      ];
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 63),
      child: PersistentTabView(
        context,
        hideNavigationBarWhenKeyboardShows: true,
        // bottomScreenMargin: 50,
        resizeToAvoidBottomInset: false,
        screens: screens(),
        confineInSafeArea: true,
        navBarHeight: 63,
        backgroundColor: const Color(0xff292526),
        items: navBarItems(),
        controller: controller,
        popAllScreensOnTapAnyTabs: true,
        navBarStyle: NavBarStyle.style2,
        onItemSelected: ((index) async {}),
      ),
    );
  }
}
