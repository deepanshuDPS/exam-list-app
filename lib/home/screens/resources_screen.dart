
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';

class ResourcesScreen extends StatefulWidget {
  static const routeName = "/resources-screen";

  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  BaseState<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends BaseState<ResourcesScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _searchTextController = TextEditingController();
  String currentText = '';

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _searchTextController.addListener(() {
        setState(() {
          currentText = _searchTextController.value.text;
        });
      });
    }
    super.didChangeDependencies();
  }

  int selectedIndex = 2; // Index of the initially selected item

  Widget _examCategory(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: selectedIndex == index ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selectedIndex == index ? Colors.red : Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          Constants.resourcesCategories[index] ?? "All",
          style: TextStyle(
            color: selectedIndex == index ? Colors.white : Colors.grey,
            fontSize: 14,
            fontWeight:
                selectedIndex == index ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UnconstrainedBox(
            constrainedAxis: Axis.horizontal,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 25),
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  left: 16,
                  right: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resources',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: const BoxDecoration(
                        color: Colors.white, // You can change this color
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchTextController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: currentText.isNotEmpty
                                    ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchTextController.clear();
                                  },
                                )
                                    : null,
                                hintText: 'Search...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Constants.resourcesCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Update the selected index when an item is tapped
                    selectedIndex = index;
                  },
                  child: _examCategory(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
