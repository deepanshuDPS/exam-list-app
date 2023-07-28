import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/resorts_provider.dart';
import 'package:exam_list/resorts/widgets/resort_top_info.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class ResortScreen extends StatefulWidget {
  static const routeName = "/resort-screen";

  const ResortScreen({Key? key}) : super(key: key);

  @override
  BaseState<ResortScreen> createState() => _ResortScreenState();
}

class _ResortScreenState extends BaseState<ResortScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;
  final double _height = 320;
  double _statusHeight = 20;
  String _endPoint = "";

  @override
  void initState() {
    super.initState();
  }

  Widget _textWithIconLeft(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: appBlue,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _whatWeOfferBatch(String text, String assetString) {
    return UnconstrainedBox(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 32,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(18.0)),
            border: Border.all(color: Colors.black, width: 1)),
        child: Row(
          children: [
            SvgPicture.asset(
              assetString,
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _endPoint = ModalRoute.of(context)?.settings.arguments as String;
      _statusHeight = MediaQuery.of(context).padding.top;
      _fetchData();
      _scrollController.addListener(() {
        var onlyAppBarHeight = kToolbarHeight + _statusHeight;
        if (!_scrollController.position.outOfRange &&
            _scrollController.offset > _height - onlyAppBarHeight) {
          if (!_isCollapsed) _isCollapsed = true;
        } else if (_isCollapsed) {
          _isCollapsed = false;
        }
        setState(() {});
      });
    }
    super.didChangeDependencies();
  }

  void _fetchData() {
    Provider.of<ResortsProvider>(context, listen: false).getResort(_endPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ResortsProvider>(
            child: const ContainerLoading(),
            builder: (ctx, resort, ch) {
              if (resort.resortRequestData.isLoading) return ch!;
              if (resort.resortRequestData.isError) {
                return ContainerError(
                    jsonData: resort.resortRequestData.data,
                    onTryAgain: () => _fetchData());
              }

              var resortData = resort.resort;
              if (resortData != null) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      title: _isCollapsed
                          ? Text(
                              resortData.name,
                              style: const TextStyle(color: Colors.black),
                            )
                          : null,
                      expandedHeight: _height,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: _isCollapsed ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      backgroundColor: Colors.white,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: ResortTopInfo(
                          resortData: resortData,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              textAlign: TextAlign.start,
                              style: AppStyles.robotoOrangeText(),
                            ),
                            _textWithIconLeft(resortData.address ?? "--",
                                Icons.location_on_rounded),
                            Text(
                              'Amenities:',
                              textAlign: TextAlign.start,
                              style: AppStyles.robotoOrangeText(),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                _whatWeOfferBatch("AC", "assets/svg/ic_ac.svg"),
                                _whatWeOfferBatch(
                                    "Laundry", "assets/svg/ic_laundry.svg"),
                                _whatWeOfferBatch("Restaurant",
                                    "assets/svg/ic_restaurant.svg"),
                                _whatWeOfferBatch(
                                    "Wifi", "assets/svg/ic_wifi.svg"),
                                _whatWeOfferBatch("Swimming Pool",
                                    "assets/svg/ic_swimming.svg"),
                                _whatWeOfferBatch(
                                    "Parking", "assets/svg/ic_parking.svg"),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Text(
                              'Description',
                              textAlign: TextAlign.start,
                              style: AppStyles.robotoOrangeText(),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(resortData.descr ?? "--"),
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return ContainerError(jsonData: const {
                  'message': 'Something went wrong!! Please, try again',
                  'code': -1
                }, onTryAgain: () => _fetchData());
              }
            }));
  }
}
