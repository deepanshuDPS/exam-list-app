import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/user/screens/your_profile_options_screen.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  BaseState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      Provider.of<UserProvider>(context, listen: false).getAspirantUser();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _getPage(_selectedIndex),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: _buildNavItemIcon(Icons.home, _selectedIndex == 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItemIcon(Icons.location_on, _selectedIndex == 1),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItemIcon(Icons.menu_book, _selectedIndex == 2),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItemIcon(Icons.person, _selectedIndex == 3),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItemIcon(IconData iconData, bool isSelected) {
    return Container(
      padding: isSelected ? const EdgeInsets.all(7.0) : const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Theme.of(context).colorScheme.secondary: Colors.transparent,
      ),
      child: Icon(
        iconData,
        color: isSelected ? Colors.white : Colors.grey,
        size: isSelected ? 26.0 : 24.0,
      ),
    );
  }

  Widget _getPage(int index) {
    // Return your different content pages based on the selected index
    // Example: Return a Text widget for demonstration purposes
    return YourProfileOptionsScreen();
  }
}
