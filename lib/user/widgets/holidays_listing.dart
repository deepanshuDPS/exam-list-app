import 'package:flutter/material.dart';
import 'package:exam_list/home/widgets/card_bg.dart';
import 'package:exam_list/responseModels/login/holidays_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';

class HolidaysListing extends StatelessWidget {
  final Data? holidayData;
  final Function availableClick;

  const HolidaysListing(
      {Key? key, required this.holidayData, required this.availableClick})
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
    var isBooked = (holidayData?.status ?? "").toString().contains("Booked");
    var isAvailable =
        (holidayData?.status ?? "").toString().contains("Available");
    var isExpired = (holidayData?.status ?? "").toString().contains("Expired");

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
                    isBooked
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              (holidayData?.hotel ?? ""),
                              style: AppStyles.robotoBold().copyWith(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant),
                            ),
                          )
                        : Container(),
                    isBooked
                        ? const Divider(
                            color: appDividerColorDark,
                          )
                        : Container(),
                    _detailRow("Days : ",
                        "${holidayData?.night ?? ""} night ${holidayData?.day ?? ""} day "),
                    const SizedBox(
                      height: 8.0,
                    ),
                    _detailRow("Validity : ",
                        "${holidayData?.vFrom ?? ""} to ${holidayData?.vTo ?? ""}"),
                    const SizedBox(
                      height: 8.0,
                    ),
                    isBooked
                        ? _detailRow(
                            "Location :  ", holidayData?.location ?? "")
                        : Container(),
                    const SizedBox(
                      height: 8.0,
                    ),
                    isBooked
                        ? _detailRow(
                            "Book Date : ", holidayData?.bookDate ?? "")
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
                              ? ()=>availableClick()
                              : isExpired
                                  ? null
                                  : () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              holidayData?.status ?? 'N/A',
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
