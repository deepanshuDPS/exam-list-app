import 'package:exam_list/controllers/aspirant_user_controller.dart';
import 'package:exam_list/controllers/home_tab_controller.dart';
import 'package:exam_list/exams/screens/exam_listing_screen.dart';
import 'package:exam_list/user/screens/user_profile_options_screen.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen'; // Manages the tab index

  final AspirantUserController _userController = Get.find();

  void _refreshUser() {
    _userController.getAspirantUser();
  }

  final HomeTabController homeTabController = Get.find();

  HomeScreen({Key? key}) : super(key: key) {
    checkAndRequestPermission();
    setUpFirebaseMessaging();
    _refreshUser();
    // _userProvider().setCurrentVersion();
    // _userProvider().getAspirantUser();
  }

  @override
  Widget build(BuildContext context) {
    homeTabController.setTabs([
      ExamListingScreen(),
      // const ExamListingScreen(),
      // const ResourcesScreen(),
      UserProfileOptionsScreen(onRefresh: _refreshUser),
    ]);

    return Container(
      color: Colors.white,
      child: Obx(() {
        if (_userController.aspirantRequestData.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (_userController.aspirantRequestData.value.isError) {
          return ContainerError(
              jsonData: _userController.aspirantRequestData.value.data,
              onTryAgain: () => _userController.getAspirantUser());
        }

        // Provider.of<ExamProvider>(context, listen: false).updatedAspirantData =
        //     user.aspirantDetails!;

        return Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: _buildBottomNavigationBar(),
          body: TabBarView(
            controller: homeTabController.controller,
            physics: const NeverScrollableScrollPhysics(),
            children: homeTabController.tabScreens,
          ),
        );
      }),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: homeTabController.selectedIndex.value,
            onTap: homeTabController.onItemSelected,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: _buildNavItemIcon(
                    Icons.home, homeTabController.selectedIndex.value == 0),
                label: '',
              ),
              // BottomNavigationBarItem(
              //   icon: _buildNavItemIcon(Icons.location_on, _selectedIndex == 1),
              //   label: '',
              // ),
              // BottomNavigationBarItem(
              //   icon: _buildNavItemIcon(Icons.menu_book, _selectedIndex == 2),
              //   label: '',
              // ),
              BottomNavigationBarItem(
                icon: _buildNavItemIcon(
                    Icons.person, homeTabController.selectedIndex.value == 1),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemIcon(IconData iconData, bool isSelected) {
    return Container(
      padding:
          isSelected ? const EdgeInsets.all(7.0) : const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isSelected ? Get.theme.colorScheme.secondary : Colors.transparent,
      ),
      child: Icon(
        iconData,
        color: isSelected ? Colors.white : Colors.grey,
        size: isSelected ? 26.0 : 24.0,
      ),
    );
  }
}
