import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:exam_list/home/widgets/card_bg.dart';
import 'package:exam_list/responseModels/login/offers_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/preferences_data.dart';

class OffersListing extends StatelessWidget {
  final Data? offerData;
  final Function availableClick;

  const OffersListing(
      {Key? key, required this.offerData, required this.availableClick})
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
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isBooked = (offerData?.status ?? "").toString().contains("Booked");
    var isAvailable =
        (offerData?.status ?? "").toString().contains("Available");
    var isExpired = (offerData?.status ?? "").toString().contains("Expired");

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
                        (parse(offerData?.offer ?? "").body?.text ?? "").trim(),
                        style: AppStyles.robotoBold().copyWith(
                            fontSize: 18,
                            color:
                                Theme.of(context).colorScheme.secondaryVariant),
                      ),
                    ),
                    const Divider(
                      color: appDividerColorDark,
                    ),
                    _detailRow("Validity : ",
                        "${offerData?.vFrom ?? ""} to ${offerData?.vTo ?? ""}"),
                    const SizedBox(
                      height: 8.0,
                    ),
                    isBooked
                        ? _detailRow("Details :  ", offerData?.detail ?? "")
                        : Container(),
                    const SizedBox(
                      height: 8.0,
                    ),
                    isBooked
                        ? _detailRow("Book Date : ", offerData?.bookDate ?? "")
                        : Container(),
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
                            primary: isAvailable
                                ? Colors.green
                                : isExpired
                                    ? Colors.red
                                    : Colors.blue,
                          ),
                          onPressed: isAvailable
                              ? () async {
                                  availableClick(
                                      (await PreferencesData.getUserData())
                                          ?.mobile);
                                }
                              : isExpired
                                  ? null
                                  : () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              offerData?.status ?? 'N/A',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Colors.white),
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
