import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class MemberProfileScreen extends StatefulWidget {
  static const routeName = "/member-profile-screen";

  const MemberProfileScreen({Key? key}) : super(key: key);

  @override
  BaseState<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends BaseState<MemberProfileScreen> {
  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _fetchDetails();
    }
    super.didChangeDependencies();
  }

  Widget _textWithIconLeft(String title, IconData icon, String? text) {
    if (text != null && text != '') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Icon(
              icon,
              size: 20,
              color: appBlue,
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isYellow: true,
      titleText: 'Profile',
      child: BaseImageContainer(
        opacity: 0.6,
        child: Consumer<UserProvider>(
            child: const ContainerLoading(),
            builder: (ctx, user, child) {
              if (user.memberRequestData.isLoading) {
                return child!;
              } else if (user.memberRequestData.isError) {
                return ContainerError(
                    jsonData: user.memberRequestData.data,
                    onTryAgain: () => {_fetchDetails()});
              }
              var details = user.memberDetails;
              return SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white.withAlpha(225)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _headingText('Member Profile'),
                        _textWithIconLeft('Name', Icons.person, details?.name),
                        _textWithIconLeft('Email', Icons.email, details?.email),
                        _textWithIconLeft(
                            'Mobile No.', Icons.phone_android, details?.mobile),
                        _textWithIconLeft('Alternative Mobile Number',
                            Icons.phone_android_sharp, details?.altMobile),
                        _textWithIconLeft(
                            'DOB', Icons.calendar_today_rounded, details?.dob),
                        _textWithIconLeft('Last Holiday Used',
                            Icons.holiday_village, details?.lastHoliday),
                        _textWithIconLeft('Membership Card No.',
                            Icons.credit_card_sharp, details?.msNum),
                        _textWithIconLeft('Membership Category', Icons.margin,
                            details?.msCategory),
                        _textWithIconLeft('Membership Joining Date',
                            Icons.perm_contact_calendar, details?.joinDate),
                        _headingText('Spouse Details'),
                        _textWithIconLeft(
                            'Name', Icons.person_outlined, details?.spouse),
                        _textWithIconLeft('Marriage Anniversary',
                            Icons.date_range, details?.marriageAnniversary),
                        if (details?.fChildName?.isNotEmpty == true &&
                            details?.sChildName?.isNotEmpty == true)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _headingText('Dependent Children'),
                              _textWithIconLeft('First children name',
                                  Icons.child_care, details?.fChildName),
                              const SizedBox(
                                height: 8,
                              ),
                              _textWithIconLeft('First Children Age',
                                  Icons.date_range_sharp, details?.fChildAge),
                              const SizedBox(
                                height: 8,
                              ),
                              _textWithIconLeft('Second children name',
                                  Icons.child_care, details?.sChildName),
                              _textWithIconLeft('Second Children Age',
                                  Icons.date_range_sharp, details?.sChildAge),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        _headingText('Address'),
                        _textWithIconLeft(
                            'Address', Icons.my_location, details?.address),
                        _headingText('Payment Details'),
                        _textWithIconLeft('Membership Amount', Icons.credit_card,
                            details?.msAmount),
                        _textWithIconLeft('Advance Amount',
                            Icons.attach_money_rounded, details?.msAdvance),
                        _textWithIconLeft(
                            'Advance Amount', Icons.schedule, details?.msDue),
                        _textWithIconLeft('AMC Amount',
                            Icons.attach_money_rounded, details?.msAmc),
                      ],
                    )),
              );
            }),
      ),
    );
  }

  Widget _headingText(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          style: AppStyles.robotoOrangeText(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            height: 1,
            color: appDividerColorDark,
          ),
        )
      ],
    );
  }

  void _fetchDetails() {
    Provider.of<UserProvider>(context, listen: false).getMemberDetails();
  }
}
