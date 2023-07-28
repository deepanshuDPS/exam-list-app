import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/search_provider.dart';
import 'package:exam_list/search/all_places_screen.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:provider/provider.dart';

enum SearchTypes { domestic, international, exchange }

class SearchScreen extends StatefulWidget {
  static const routeName = "/search-screen";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchControl = TextEditingController();
  final List tabBarTitles = ['Domestic ', 'International', 'Exchange'];
  CancelableOperation? _myCancelableFuture;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _isInit = true;
      Provider.of<SearchProvider>(context, listen: false).getAllPlaces();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: BaseImageContainer(
              child: Column(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8 + MediaQuery.of(context).padding.top,
                              left: 16,
                              right: 16),
                          child: Column(
                            children: <Widget>[
                              Card(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                  elevation: 2,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: () => willPopScope(
                                                  isBackButton: true),
                                              child:
                                                  const Icon(Icons.arrow_back)),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: TextField(
                                            onChanged: (query) =>
                                                _searchKeyword(query),
                                            style: AppStyles.robotoBlackText()
                                                .copyWith(fontSize: 16),
                                            textInputAction:
                                                TextInputAction.search,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 2),
                                              isDense: true,
                                              hintText:
                                                  "Search Hotel by Name or City",
                                              hintStyle:
                                                  AppStyles.robotoBlackText()
                                                      .copyWith(
                                                fontSize: 16,
                                                color: Colors.blueGrey[300],
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            maxLines: 1,
                                            controller: _searchControl,
                                          ))
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        TabBar(
                          labelColor: Theme.of(context).colorScheme.secondary,
                          unselectedLabelColor: Colors.black,
                          // const Color.fromRGBO(255, 107, 0, 1),
                          isScrollable: true,
                          indicator: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              color: Colors.black),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          tabs: List.generate(tabBarTitles.length, (index) {
                            return Tab(
                              height: 36,
                              child: Text(
                                tabBarTitles[index],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      AllPlacesScreen(
                        type: SearchTypes.domestic,
                        searchTryAgain: () =>
                            {_searchKeyword(_searchControl.text.trim())},
                      ),
                      AllPlacesScreen(
                        type: SearchTypes.international,
                        searchTryAgain: () =>
                            {_searchKeyword(_searchControl.text.trim())},
                      ),
                      AllPlacesScreen(
                        type: SearchTypes.exchange,
                        searchTryAgain: () =>
                            {_searchKeyword(_searchControl.text.trim())},
                      )
                    ]),
                  )
                ],
              ),
              opacity: 0.35,
            ),
          )),
    );
  }

  void _searchKeyword(String query) {
    var provider = Provider.of<SearchProvider>(context, listen: false);
    if (_myCancelableFuture?.isCompleted == false) {
      _myCancelableFuture?.cancel();
      _myCancelableFuture = null;
    }
    if (provider.isAnyRequestToProceed(query)) {
      _myCancelableFuture =
          CancelableOperation.fromFuture(provider.searchPlaces(query));
    }
  }

  Future<bool> willPopScope({bool isBackButton = false}) async {
    Provider.of<SearchProvider>(context, listen: false).clearSearchResults();
    if (isBackButton) {
      Navigator.of(context).pop();
    }
    return true;
  }
}
