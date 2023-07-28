import 'package:exam_list/user/screens/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/home/widgets/card_bg.dart';
import 'package:exam_list/home/widgets/home_top_view.dart';
import 'package:exam_list/home/widgets/option_item.dart';
import 'package:exam_list/options/screens/downloads_screen.dart';
import 'package:exam_list/providers/download_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/responseModels/home/home_response.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:exam_list/search/search_screen.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/image_handling.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
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
      Provider.of<UserProvider>(context, listen: false).checkUser();
      Provider.of<DownloadProvider>(context, listen: false).initFilesAgain();
      _fetchHome();
    }
    super.didChangeDependencies();
  }

  void _onSearchClick() {
    Navigator.of(context).pushNamed(SearchScreen.routeName);
  }

  Widget _onErrorRetry(String message) {
    return CardBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              ElevatedButton(
                  onPressed: () {
                    _fetchHome();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14), // <-- Radius
                    ),
                    primary: Theme.of(context).colorScheme.secondary,
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
        paddingTop: 0);
  }

  Widget _innerColumn(List<Widget> mChildren) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: mChildren,
    );
  }

  // Get in Touch
  Widget _getInTouch(String? title) {
    return CardBackground(
      child: _innerColumn([
        _homeListTitles(title ?? 'Get in Touch'),
        const SizedBox(
          height: 24,
        ),
        _gridOptions(Constants.getInTouchList)
      ]),
      paddingTop: 16,
    );
  }

  Widget _downloads() {
    return Consumer<DownloadProvider>(
        child: Container(),
        builder: (ctx, download, ch) {
          if (download.listOfFiles.isEmpty) return ch!;
          String downloadText =
              'Downloads (${download.listOfFiles.length})';
          return InkWell(
              onTap: () {
                  Navigator.of(context).pushNamed(DownloadsScreen.routeName);
              },
              child: CardBackground(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.download_for_offline_rounded,
                        size: 30,),
                        const SizedBox(width: 8,),
                        Expanded(
                          child: Text(
                            downloadText,
                            style: AppStyles.robotoBold().copyWith(
                              fontSize: 16
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  paddingTop: 0));
        });
  }

  Widget _socialLinks(Data linksData) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 16, bottom: 90),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: linksData.list?.map((e) {
              return InkWell(
                onTap: () => toLink(e.link),
                child: imageNetworkIcon(
                    '${linksData.path ?? ""}${e.imageUrl}', 36),
              );
            }).toList() ??
            [],
      ),
    );
  }

  // Services
  Widget _services(String? title) {
    return CardBackground(
        child: _innerColumn([
          _homeListTitles(title ?? 'Services'),
          const SizedBox(
            height: 24,
          ),
          _gridOptions(Constants.servicesList)
        ]),
        paddingTop: 16);
  }

  // What we offer
  Widget _whatWeOffer(Data data) {
    return CardBackground(
      child: _innerColumn([
        _homeListTitles(data.title ?? "What we Offer"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Wrap(
            children: data.list?.map((e) {
                  return _whatWeOfferBatch(
                      e.name ?? "",
                      "${data.path ?? ""}${e.imageUrl}",
                      data.list?.indexOf(e) ?? 0);
                }).toList() ??
                [],
          ),
        )
      ]),
      paddingTop: 0,
      symmetric: 16,
    );
  }

  /* Widget _associateItem(String imageUrl, int index) {
    return UnconstrainedBox(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: Image.network(
            imageUrl,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
*/

  /* // What we offer
  Widget _associatesCard(List associates) {
    return CardBackground(
      child: _innerColumn([
        _homeListTitles('Travel Associates'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: associates.map((e) {
              return _associateItem(
                   e.imageUrl ?? '', associates.indexOf(e));
            }).toList(),
          ),
        )
      ]),
      paddingTop: 0,
      symmetric: 16,
    );
  }
*/
  Widget _associates(BuildContext context, Data associateData) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      // color: Theme.of(context).colorScheme.secondary.withAlpha(100),
      width: double.infinity,
      child: _innerColumn([
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // if you need this
            ),
            color: Colors.white70,
            elevation: 0,
            child: Container(
                padding: const EdgeInsets.all(6),
                width: double.infinity,
                child: Center(
                  child: _homeListTitles(associateData.title ?? "--"),
                )),
          ),
        ),
        _carouselSlider(associateData)
      ]),
    );
  }

  // My Memberships
  Widget _myMemberships(String? title) {
    return Column(
      children: [
        Consumer<UserProvider>(
            child: Container(),
            builder: (ctx, user, ch) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CardBackground(
                        child: Opacity(
                            opacity: user.isLogin ? 1.0 : 0.1,
                            child: _innerColumn([
                              _homeListTitles(title ?? 'My Memberships'),
                              const SizedBox(
                                height: 24,
                              ),
                              _gridOptions(
                                  Constants.membershipList, user.isLogin)
                            ])),
                        paddingTop: 16),
                    if (!user.isLogin)
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/ic_unlock.svg',
                            width: 40,
                            height: 40,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Login to Unlock Memberships',
                            style: AppStyles.robotoBlackText().copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(UserLoginScreen.routeName);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(18.0)),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          208, 208, 208, 1),
                                      width: 1)),
                              child: UnconstrainedBox(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/ic_user_pic.svg",
                                      width: 18,
                                      height: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Member Login",
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }),
        _downloads(),
      ],
    );
  }

  Widget _onErrorPage(String message) {
    return _innerColumn([
      const SizedBox(
        height: 100,
      ),
      _services(null),
      _myMemberships(null),
      _getInTouch(null),
      const SizedBox(
        height: 8,
      ),
      _onErrorRetry(message)
    ]);
  }

  List<Widget> _widgetsOnResponse(List<Data> homeData) {
    return homeData.map((item) {
      if (item.sequence == 0) {
        return HomeTopView(
          onSearchClick: () => _onSearchClick(),
          bannerData: item,
        );
      } else if (item.sequence == 1) {
        return _services(item.title);
      } else if (item.sequence == 2) {
        return _myMemberships(item.title);
      } else if ([3, 5, 7, 8].contains(item.sequence)) {
        return _associates(context, item);
      } else if (item.sequence == 4) {
        return _whatWeOffer(item);
      } else if (item.sequence == 6) {
        return _getInTouch(item.title);
      } else {
        return _socialLinks(item);
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BaseImageContainer(
        child: SingleChildScrollView(
            child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<HomeProvider>(
                  child: const ContainerLoading(),
                  builder: (ctx, home, ch) {
                    if (home.homeRequest.isLoading) return ch!;
                    if (home.homeData.isNotEmpty == true) {
                      return _innerColumn(_widgetsOnResponse(home.homeData));
                    } else {
                      return _onErrorPage(home.homeRequest.message);
                    }
                  }),
            ],
          ),
        )),
        opacity: 0.65,
      ),
    );
  }

  Widget _homeListTitles(String titleText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: Text(titleText,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'RobotoSlab',
              fontSize: 16,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget _gridOptions(List<Map<String, dynamic>> data, [bool isClick = true]) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        shrinkWrap: true,
        // You won't see infinite size error
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisExtent: 88),
        itemBuilder: (BuildContext context, int index) {
          return OptionItem(
            optionText: data[index]['text']!,
            image: data[index]['image']!,
            routeName: data[index]['route'],
            tabPosition: data[index]['tab_position'],
            sheet: data[index]['sheet'],
            arg: data[index]['arg'],
            onClick: isClick,
          );
        });
  }

  Widget _whatWeOfferBatch(String offersText, String imageUrl, int index) {
    return UnconstrainedBox(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(
                color: const Color.fromRGBO(208, 208, 208, 1), width: 1)),
        child: Row(
          children: [
            imageNetworkIcon(imageUrl, 16),
            const SizedBox(
              width: 10,
            ),
            Text(
              offersText,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Widget _carouselSlider(Data imagesData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CarouselSlider(
        items: imagesData.list?.map((image) {
          return SizedBox(
            width: 225,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // if you need this
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: cachedImageWithWidth(
                  "${imagesData.path ?? ""}${image.imageUrl}",
                  BoxFit.fill,
                  225,
                ),
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.6,
            enlargeCenterPage: true,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            height: 225 * 180 / 292),
      ),
    );
  }

  void _fetchHome() {
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);
    provider.fetchHomePage().then((value) {
      if (value.isError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(makeSnackBar(value.data['message']));
      }
    });
  }
}
