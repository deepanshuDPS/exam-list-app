import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:exam_list/member/widgets/trips_listing.dart';
import 'package:exam_list/providers/download_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class TripsScreen extends StatefulWidget {
  final bool isCompleted;

  const TripsScreen({Key? key, required this.isCompleted}) : super(key: key);

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        child: const ContainerLoading(),
        builder: (ctx, user, ch) {
          var requestData = widget.isCompleted
              ? user.myCompTripsRequestData
              : user.myUpTripsRequestData;
          if (requestData.isLoading) {
            return ch!;
          } else if (requestData.isError) {
            return ContainerError(
              jsonData: requestData.data,
              onTryAgain: () => {_fetchAgain()},
            );
          }
          var dProvider = Provider.of<DownloadProvider>(context, listen: false);
          var itemList =
              widget.isCompleted ? user.comTripsList : user.upTripsList;
          for (var item in itemList) {
            if (item.cvUrl != null) {
              item.setFilePath(dProvider.checkFile(item.cvUrl!));
            }
          }
          return ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return TripsListing(
                  tripData: itemList[index],
                  downloadFile: (url) {
                    showProgressDialog(context);
                    dProvider.downloadFile(url,type: 'vch').then((value) async {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                          msg: value != null
                              ? 'Download Success'
                              : 'Download Failed!!!');
                      if (value != null) {
                        setState(() {
                          itemList[index]
                              .setFilePath(dProvider.checkFile(value));
                        });
                        await OpenFilex.open(value);
                      }
                    });
                  },
                );
              });
        });
  }

  void _fetchAgain() {
    Provider.of<UserProvider>(context, listen: false)
        .getTrips(widget.isCompleted ? 1 : 0);
  }
}
