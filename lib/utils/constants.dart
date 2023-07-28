import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:exam_list/home/screens/support_screen.dart';
import 'package:exam_list/member/screens/member_account_screen.dart';
import 'package:exam_list/member/screens/member_feedback_screen.dart';
import 'package:exam_list/member/screens/member_listing_screen.dart';
import 'package:exam_list/member/screens/my_trips_screen.dart';
import 'package:exam_list/options/screens/payment_screen.dart';
import 'package:exam_list/search/search_screen.dart';

class Constants {
  static String baseURL = 'https://thepacificholidayworld.com/api/';

  //SvgPicture.asset(assetName)
  static List<Map<String, String>> membershipList = [
    {
      "text": "Member Account",
      "image": "assets/svg/ic_mem_account.svg",
      "route": MemberAccountScreen.routeName
    },
    {
      "text": "My Trips",
      "image": "assets/svg/ic_my_trips.svg",
      "route": MyTripsScreen.routeName
    },
    {
      "text": "Membership Fee",
      "image": "assets/svg/ic_mem_fee.svg",
      "route": MemberListingScreen.routeName,
      "arg": "3"
    },
    {"text": "AMC Fee", "image": "assets/svg/amc_fee.svg",
      "route": MemberListingScreen.routeName,
      "arg": "4"},
    {
      "text": "Holidays",
      "image": "assets/svg/ic_holidays.svg",
      "route": MemberListingScreen.routeName,
      "arg": "1"
    },
    {
      "text": "Offers",
      "image": "assets/svg/ic_offers.svg",
      "route": MemberListingScreen.routeName,
      "arg": "0"
    },
    {
      "text": "Documents",
      "image": "assets/svg/ic_documents.svg",
      "route": MemberListingScreen.routeName,
      "arg": "2"
    },
    {
      "text": "Feedback",
      "image": "assets/svg/ic_feedback.svg",
      "route": MemberFeedbackScreen.routeName,
    },
  ];

  // static List<Map<String, String>> optionsList = [
  //   {
  //     "text": "Member Login",
  //     "image": "assets/svg/ic_mem_account.svg",
  //     "route": MemberLoginScreen.routeName
  //   },
  //   {
  //     "text": "Vouchers",
  //     "image": "assets/svg/vouchers.svg",
  //     "sheet": "voucher"
  //   },
  //   {
  //     "text": "Payments",
  //     "image": "assets/svg/ic_payments.svg",
  //     "route": PaymentScreen.routeName
  //   },
  //   {
  //     "text": "Support",
  //     "image": "assets/svg/ic_support.svg",
  //     "route": SupportScreen.routeName
  //   },
  // ];

  static Map<int, List<Map<String, dynamic>>> homePageSequenceData = {
    1: servicesList,
    2: membershipList,
    6: getInTouchList
  };

  static List<Map<String, String>> servicesList = [
    {
      "text": "Vouchers",
      "image": "assets/svg/ic_vouchers.svg",
      "sheet": "voucher"
    },
    {
      "text": "Payments",
      "image": "assets/svg/ic_payments.svg",
      "route": PaymentScreen.routeName
    },
    {
      "text": "Locations",
      "image": "assets/svg/ic_locations.svg",
      "route": SearchScreen.routeName
    },
    {
      "text": "Support",
      "image": "assets/svg/ic_support.svg",
      "route": SupportScreen.routeName
    },
  ];

  static List<Map<String, dynamic>> getInTouchList = [
    {
      "text": "Overview",
      "image": "assets/svg/ic_overview.svg",
      "tab_position": 0
    },
    {
      "text": "Benefits",
      "image": "assets/svg/ic_benefits.svg",
      "tab_position": 1
    },
    {
      "text": "Offers",
      "image": "assets/svg/ic_offers_2.svg",
      "tab_position": 2
    },
    {
      "text": "Testimonials",
      "image": "assets/svg/ic_testimonials.svg",
      "tab_position": 3
    },
  ];

  static List<Map<String, dynamic>> socialNetworksList = [
    {"link": "Facebook", "image": LineAwesomeIcons.facebook},
    {"link": "Linkedin", "image": LineAwesomeIcons.linkedin},
    {"link": "Twitter", "image": LineAwesomeIcons.twitter},
    {"link": "Instgram", "image": LineAwesomeIcons.instagram},
    {"link": "Youtube", "image": LineAwesomeIcons.youtube}
  ];

  static String userData = 'USER_DATA';

  static List<String> termsConditionsTitles = [
    'Terms & Condition',
    'Acceptance Of Agreement',
    'Editing, Deleting And Modification',
    'Copyright',
    'Terms & conditions for contest participants'
  ];

  static List<String> termsConditions = [
    'Welcome to The Pacific Holiday World (A Unit Of 4r Seasons Holidays Pvt. Ltd) computing device (the "Site"). '
        'Please browse these Terms of Use rigorously before exploiting this website. '
        'By exploiting this website you conform to go with and be sure of these Terms of Use. '
        'If you do not conform to these terms, you want to not use this website. '
        'You conform to the terms and conditions made public during this Terms of Use Agreement with reference to our website. '
        'This Agreement constitutes the complete and solely agreement between us and you with reference to the positioning and supersedes all previous or contemporaneous agreements, representations, warranties and understandings with reference to the positioning, the content, product or services provided by or through the positioning, and also the subject material of this Agreement. '
        'The newest Agreement are going to be denote on the positioning, and you want to review this Agreement before exploitation the positioning.',
    "The Pacific Holiday World authorizes you to look at, print or transfer any content, graphic, kind or document from the positioning for your personal, non-commercial use and you want to not amendment or delete any such material or copyright notice showing on such material. "
        "you'll not modify the materials at this website in any means or repost, republish, reproduce, publicly show, perform, assign, sublicense, sell or prepare spin-off works of or otherwise use the materials for any purpose except as expressly permissible beneath this Agreement. "
        "Copyright within the materials at this website is closely-held by or used with permission and any unauthorized use of any materials at this website might violate copyright, trade mark and alternative proprietary (including however not restricted to intellectual property) legal rights of the corporate. "
        "As a user of this computing device you\'re granted a nonexclusive, untransferable, revocable, restricted license to access and use this computing device and Content in accordance with these Terms of Use. "
        "Supplier might terminate this license at any time for any reason.",
    "All material offered on this computing device is protected by copyright laws. Distribution of the fabric from the net website, for business functions is prohibited. "
        "'The house owners of the material possession, copyrights and logos or its affiliates or third party licensors'. "
        "Domestic and International copyright and Trademark laws shield the complete Contents of the positioning. "
        "You're expressly prohibited from modifying, copying, reproducing, publishing, uploading, posting, transmission or distributing any material on this website as well as text, graphics, code and/or package.",
    "Welcome to the terms and conditions ('Terms') for The Pacific Holiday World (A Unit Of 4r Seasons Holidays Pvt. Ltd). "
        "These Terms square measure between you and also the Pacific Holiday World and govern our individual rights and obligations. "
        "Please note your use of the link, and by collaborating during this contest, you settle for these terms, conditions, limitations, and needs.",
    "Welcome to the terms and conditions ('Terms') for The Pacific Holiday World (A Unit Of 4r Seasons Holidays Pvt. Ltd). "
        "These Terms square measure between you and also the Pacific Holiday World and govern our individual rights and obligations. "
        "Please note your use of the link, and by collaborating during this contest, you settle for these terms, conditions, limitations, and needs. "
        "These Terms and Conditions govern the conduct of the contests under it hashtag #BlinkToBeThere delivered to you by The Pacific Holiday World and launched the terms and conditions on which you'll participate during this Contest."
  ];

  static String phwAuth = 'd81e13010c093134faab0748ad92e7dee09c4afb';
}
