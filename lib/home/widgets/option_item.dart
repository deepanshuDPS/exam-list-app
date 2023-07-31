import 'package:flutter/material.dart';
import 'package:exam_list/options/extras/voucher_sheet.dart';
import 'package:exam_list/options/screens/get_in_touch_screen.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/image_handling.dart';
import 'package:exam_list/utils/preferences_data.dart';

class OptionItem extends StatelessWidget {
  final String optionText;
  final String image;
  final String? routeName;
  final String? arg;
  final int? tabPosition;
  final String? sheet;
  final bool? onClick;

  const OptionItem(
      {Key? key,
      required this.optionText,
      required this.image,
      this.routeName,
      this.tabPosition,
      this.sheet,
      this.arg,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick == true
          ? () async => {
                if (sheet != null)
                  {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const VoucherSheet();
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                    )
                  }
                else if (routeName != null && arg != null)
                  Navigator.of(context).pushNamed(routeName!, arguments: arg)
                else if (routeName != null &&
                    routeName?.contains('feedback') == true)
                  {
                    Navigator.of(context).pushNamed(routeName!,
                        arguments: (await PreferencesData.getUserData())?.id)
                  }
                else if (routeName != null)
                  Navigator.of(context).pushNamed(routeName!)
                else if (tabPosition != null)
                  {
                    Navigator.of(context).pushNamed(GetInTouchScreen.routeName,
                        arguments: tabPosition)
                  }
              }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageIcon(image, 32),
            const SizedBox(
              height: 8,
            ),
            Text(
              optionText,
              textAlign: TextAlign.center,
              style: AppStyles.blackSemiBoldText().copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
