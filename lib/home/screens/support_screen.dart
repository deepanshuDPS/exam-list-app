import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  static const routeName = "/support-screen";

  const SupportScreen({Key? key}) : super(key: key);

  void _mailTo(String email) async {
    final mailtoLink = Mailto(
      to: [email],
    );
    final parsedUrl = Uri.parse(mailtoLink.toString());
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    if (await canLaunchUrl(parsedUrl)) {
      await launchUrl(parsedUrl);
    } else {
      // TODO: Need Toast Message
      printDebug('Could not launch $parsedUrl');
    }
  }

  void _phoneTo(String phone) async {
    final parsedUrl = Uri.parse(phone);
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    if (await canLaunchUrl(parsedUrl)) {
      await launchUrl(parsedUrl);
    } else {
      // TODO: Need Toast Message
      printDebug('Could not launch $parsedUrl');
    }
  }

  Widget textWithIconLeft(String text, IconData icon) {
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

  Widget textWithIconRight(
      String text, IconData icon, String? mailTo, String? phoneTo) {
    var row = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          Icon(
            icon,
            size: 24,
            color: appBlue,
          ),
        ],
      ),
    );

    if (mailTo != null) {
      return InkWell(
        onTap: () => _mailTo(mailTo),
        child: row,
      );
    } else if (phoneTo != null) {
      return InkWell(
        onTap: () => _phoneTo('tel://$phoneTo'),
        child: row,
      );
    } else {
      return row;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppBarColored: true,
      child: BaseImageContainer(
        opacity: 0.6,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.white.withAlpha(200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/img_rect_phw.png',
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  height: 180,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Contact Us',
                  textAlign: TextAlign.start,
                  style: AppStyles.robotoOrangeText(),
                ),
                textWithIconLeft('11:00 AM - 6:00 PM', Icons.access_time),
                RichText(
                    text: TextSpan(
                        text: "Holidays:  ",
                        style: AppStyles.robotoBold()
                            .copyWith(fontSize: 14, color: Colors.red),
                        children: const [
                      TextSpan(
                        text: "Sunday and National Holidays",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      )
                    ])),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  height: 1,
                  color: appDividerColorDark,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Corporate Office',
                  style: AppStyles.robotoOrangeText(),
                ),
                textWithIconLeft(
                    'A-214, 2nd Floor, Pocket-A, Okhla Phase-1, New Delhi - 110020',
                    Icons.my_location),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Registered Office',
                  style: AppStyles.robotoOrangeText(),
                ),
                textWithIconLeft(
                    'B-49, Top Floor, Near HDFC Bank, Kalkaji New Delhi-110019',
                    Icons.my_location),
                const Divider(
                  height: 1,
                  color: appDividerColorDark,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Call Us',
                  style: AppStyles.robotoOrangeText(),
                ),
                textWithIconRight(
                    'Customer Care', Icons.call, null, '18002124193'),
                textWithIconRight(
                    'Holiday Reservation', Icons.call, null, '18002124193'),
                const Divider(
                  height: 1,
                  color: appDividerColorDark,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Mail Us',
                  style: AppStyles.robotoOrangeText(),
                ),
                textWithIconRight('Customer Care', Icons.email_rounded,
                    'customercare@thepacificholidayworld.com', null),
                textWithIconRight('Holiday Reservation', Icons.email_rounded,
                    'reservations@thepacificholidayworld.com', null),
                textWithIconRight('Voucher Reservation', Icons.email_rounded,
                    'voucher@thepacificholidayworld.com', null),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
      titleText: "Support",
    );
  }
}
