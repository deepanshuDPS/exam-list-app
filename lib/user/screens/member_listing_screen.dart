import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/user/extras/otp_sheet.dart';
import 'package:exam_list/user/widgets/docs_listing.dart';
import 'package:exam_list/user/widgets/holidays_listing.dart';
import 'package:exam_list/user/widgets/fee_listing.dart';
import 'package:exam_list/user/widgets/offers_listing.dart';
import 'package:exam_list/providers/download_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/resorts/screens/resorts_listing_screen.dart';
import 'package:exam_list/responseModels/login/member_fee_payments.dart';
import 'package:exam_list/responseModels/login/documents_response.dart'
    as docs_response;
import 'package:exam_list/utils/colors.dart';

import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class MemberListingScreen extends StatefulWidget {
  static const routeName = "/member-offers-screen";

  const MemberListingScreen({Key? key}) : super(key: key);

  @override
  BaseState<MemberListingScreen> createState() => _MemberListingScreenState();
}

class _MemberListingScreenState extends BaseState<MemberListingScreen> {
  String _heading = "--";

  // 0->offers 1 -> holidays, 2->  documents, 3-> Member fees
  int _pageType = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _pageType =
          int.parse(ModalRoute.of(context)?.settings.arguments as String);
      switch (_pageType) {
        case 0:
          _heading = 'My Offers';
          break;
        case 1:
          _heading = 'My Holidays';
          break;
        case 2:
          _heading = 'My Documents';
          break;
        case 3:
          _heading = 'Membership Fee';
          break;
        default:
          _heading = 'AMC Fee';
      }
      _fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleText: _heading,
      isYellow: true,
      child: BaseImageContainer(
        opacity: 0.4,
        child: Consumer<UserProvider>(
            child: const ContainerLoading(),
            builder: (ctx, user, child) {
              if (user.memberRequestData.isLoading) {
                return child!;
              } else if (user.memberRequestData.isError) {
                return ContainerError(
                    jsonData: user.memberRequestData.data,
                    onTryAgain: () => {_fetchData()});
              }
              var itemList = _pageType == 0
                  ? user.offersList
                  : _pageType == 1
                      ? user.holidaysList
                      : _pageType == 2
                          ? user.docsList
                          : user.feeList;

              List<Data>? receiptsList;
              var dProvider =
                  Provider.of<DownloadProvider>(context, listen: false);
              if (_pageType > 1) {
                receiptsList = user.feeList;
                for (var item in receiptsList) {
                  if (item.invoiceUrl != null) {
                    item.setFilePath(dProvider.checkFile(item.invoiceUrl!));
                  }
                }
              }

              List<docs_response.Data>? docsList;
              if (_pageType == 2) {
                docsList = user.docsList;
                for (var item in docsList) {
                  if (item.docUrl != null) {
                    item.setFilePath(dProvider.checkFile(item.docUrl!));
                  }
                }
              }
              return Container();
              // return ListView.builder(
              //     padding: const EdgeInsets.only(top: 16),
              //     itemCount: itemList.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return _pageType == 0
              //           ? OffersListing(
              //               offerData: user.offersList[index],
              //               availableClick: (mobile) {
              //                 showModalBottomSheet(
              //                   context: context,
              //                   isScrollControlled: true,
              //                   builder: (BuildContext context) {
              //                     return OTPSheet(bodyData: {
              //                       'offer_detail':
              //                           user.offersList[index].offer,
              //                       'contact': mobile
              //                     }, isOffer: true);
              //                   },
              //                   shape: const RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.vertical(
              //                       top: Radius.circular(10),
              //                     ),
              //                   ),
              //                   clipBehavior: Clip.antiAliasWithSaveLayer,
              //                 );
              //               })
              //           : _pageType == 1
              //               ? HolidaysListing(
              //                   holidayData: user.holidaysList[index],
              //                   availableClick: () {
              //                     popUp(context);
              //                   })
              //               : _pageType == 2
              //                   ? DocsListing(
              //                       docData: user.docsList[index],
              //                       downloadDoc: (url) {
              //                         showProgressDialog(context,
              //                             loadingText: 'Downloading...');
              //                         dProvider
              //                             .downloadFile(url)
              //                             .then((value) async {
              //                           Navigator.of(context).pop();
              //                           Fluttertoast.showToast(
              //                               msg: value != null
              //                                   ? 'Download Success'
              //                                   : 'Download Failed!!!');
              //                           if (value != null) {
              //                             setState(() {
              //                               docsList![index].setFilePath(
              //                                   dProvider.checkFile(value));
              //                             });
              //                             await OpenFilex.open(value);
              //                           }
              //                         });
              //                       })
              //                   : FeeListing(
              //                       feeData: receiptsList![index],
              //                       isMember: _pageType == 3,
              //                       downloadReceipt: (url) {
              //                         showProgressDialog(context,
              //                             loadingText: 'Downloading...');
              //                         dProvider
              //                             .downloadFile(url,type: 'rec')
              //                             .then((value) async {
              //                           Navigator.of(context).pop();
              //                           Fluttertoast.showToast(
              //                               msg: value != null
              //                                   ? 'Download Success'
              //                                   : 'Download Failed!!!');
              //                           if (value != null) {
              //                             setState(() {
              //                               receiptsList![index].setFilePath(
              //                                   dProvider.checkFile(value));
              //                             });
              //                             await OpenFilex.open(value);
              //                           }
              //                         });
              //                       },
              //                     );
              //     });
            }),
      ),
    );
  }

  void _fetchData() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_pageType == 0) {
      userProvider.getOffers();
    } else if (_pageType == 1) {
      userProvider.getHolidays();
    } else if (_pageType == 2) {
      userProvider.getDocs();
    } else if (_pageType == 3) {
      userProvider.getMemberFees();
    } else {
      userProvider.getMemberFees(isAMC: true);
    }
  }

  void popUp(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    showProgressDialog(context,loadingText: 'Fetching locations...');
    userProvider.getAllPlaces().then((value) {
      Navigator.of(context).pop();
      if(value){
        List<String> itemPackage = [
          "Select Package",
          "1 Night 2 Days",
          "2 Night 3 Days",
          "3 Night 4 Days",
          "4 Night 5 Days",
          "5 Night 6 Days",
          "6 Night 7 Days",
        ];
        List<String> itemsMonth = [
          "Select Month",
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December"
        ];
        List<String> placesList = ['Select Location'];
        placesList
            .addAll(userProvider.allPlacesList.map((e) => e.name ?? '').toList());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // of dialog
              int _currentPlaceIndex = 0;
              int _currentMonthIndex = 0;
              int _currentPackagePosition = 0;
              bool _isNotSelected = false;
              return StatefulBuilder(
                builder: (ctx, setState) {
                  return AlertDialog(
                    content: UnconstrainedBox(
                      constrainedAxis: Axis.horizontal,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              value: placesList[_currentPlaceIndex],
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: appDarkBlue,
                              ),
                              isExpanded: true,
                              iconSize: 18,
                              elevation: 10,
                              style: const TextStyle(
                                  color: appDarkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              underline: Container(
                                height: 1,
                                color: appDarkBlue,
                              ),
                              onChanged: (String? data) {
                                setState(() {
                                  _currentPlaceIndex =
                                      placesList.indexOf(data ?? '');
                                });
                              },
                              items: placesList.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            DropdownButton<String>(
                              value: itemsMonth[_currentMonthIndex],
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: appDarkBlue,
                              ),
                              isExpanded: true,
                              iconSize: 18,
                              elevation: 10,
                              style: const TextStyle(
                                  color: appDarkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              underline: Container(
                                height: 1,
                                color: appDarkBlue,
                              ),
                              onChanged: (String? data) {
                                setState(() {
                                  _currentMonthIndex =
                                      itemsMonth.indexOf(data ?? '');
                                });
                              },
                              items: itemsMonth.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            DropdownButton<String>(
                              value: itemPackage[_currentPackagePosition],
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: appDarkBlue,
                              ),
                              isExpanded: true,
                              iconSize: 18,
                              elevation: 10,
                              style: const TextStyle(
                                  color: appDarkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              underline: Container(
                                height: 1,
                                color: appDarkBlue,
                              ),
                              onChanged: (String? data) {
                                setState(() {
                                  _currentPackagePosition =
                                      itemPackage.indexOf(data ?? '');
                                });
                              },
                              items: itemPackage.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Please Select all Values',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _isNotSelected
                                      ? Colors.red
                                      : Theme.of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: clickToAction(context, 'Find Tours',
                                      () async {
                                    var validate = _currentMonthIndex != 0 &&
                                        _currentPackagePosition != 0 &&
                                        _currentPlaceIndex != 0;
                                    if (validate) {
                                      Navigator.of(context).pushNamed(
                                          ResortsListingScreen.routeName,
                                          arguments: {
                                            'place_id': userProvider.allPlacesList
                                                .where((element) =>
                                            element.name ==
                                                placesList[_currentPlaceIndex])
                                                .toList()
                                                .first
                                                .id,
                                            'city': placesList[_currentPlaceIndex],
                                            'month': itemsMonth[_currentMonthIndex],
                                            'package': itemPackage[
                                            _currentPackagePosition],
                                            'contact': (await PreferencesData
                                                .getUserData())
                                                ?.mobile
                                          });
                                    } else {
                                      setState(() {
                                        _isNotSelected = true;
                                      });
                                    }
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            });
      }else {
        Fluttertoast.showToast(msg: 'No Data Found');
      }
    });


  }
}
