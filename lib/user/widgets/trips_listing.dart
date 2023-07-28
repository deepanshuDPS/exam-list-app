import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:exam_list/home/widgets/card_bg.dart';
import 'package:exam_list/responseModels/login/my_trips_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/extras_utils.dart';

class TripsListing extends StatelessWidget {
  final Data? tripData;
  final Function downloadFile;

  const TripsListing(
      {Key? key, required this.tripData, required this.downloadFile})
      : super(key: key);

  Widget _detailRow(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDownloadUrlAv = tripData?.cvUrl != null;
    return CardBackground(
      paddingTop: 0,
      containerMargin: 8,
      child: Container(
        margin: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        (tripData?.details ?? ""),
                        style: AppStyles.robotoBold().copyWith(
                            fontSize: 18,
                            color:
                                Theme.of(context).colorScheme.secondaryVariant),
                      ),
                    ),
                    const Divider(
                      color: appDividerColorDark,
                    ),
                    _detailRow("Days : ", tripData?.duration ?? ""),
                    const SizedBox(
                      height: 8.0,
                    ),
                    _detailRow("Book Date :  ", tripData?.bookDate ?? ""),
                    const SizedBox(
                      height: 8.0,
                    ),
                    if (isDownloadUrlAv)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(16), // <-- Radius
                                ),
                                primary:
                                    Theme.of(context).colorScheme.secondary),
                            onPressed: () async {
                              if (tripData?.isDownloaded == true) {
                                await OpenFilex.open(tripData?.filePath);
                              } else {
                                downloadFile(tripData?.cvUrl!);
                              }
                            },
                            child: UnconstrainedBox(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${(tripData?.isDownloaded ?? false) ? 'View' : 'Download'} Voucher',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      (tripData?.isDownloaded ?? false)
                                          ? Icons.arrow_forward_ios_outlined
                                          : Icons.download_outlined,
                                      size: 20,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
