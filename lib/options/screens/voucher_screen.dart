import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/download_provider.dart';
import 'package:exam_list/responseModels/home/check_voucher_response.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:provider/provider.dart';

class VoucherScreen extends StatefulWidget {
  static const routeName = "/voucher-screen";

  const VoucherScreen({Key? key}) : super(key: key);

  @override
  BaseState<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends BaseState<VoucherScreen> {
  late Data data;
  late String? _downloadedPath;

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      data = (ModalRoute.of(context)?.settings.arguments as Data);
      if (data.path != null) {
        _downloadedPath = Provider.of<DownloadProvider>(context, listen: false)
            .checkFile(data.path!);
      }
    }
    super.didChangeDependencies();
  }

  Widget _boldText(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold));
  }

  Widget _normalText(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500));
  }

  Widget _voucherText(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic));
  }

  Widget _buildStack(context) => Stack(children: <Widget>[
        AspectRatio(
          aspectRatio: 3,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: ClipRRect(
              child: Image.asset(
                'assets/images/movie_voucher.jpg',
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(36),
            ),
            // height: MediaQuery.of(context).size.height/4,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 1 / 3,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 56),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _voucherText('Name : ${data.name}'),
                _voucherText('Email : ${data.email}'),
                _voucherText('Phone : ${data.phone}'),
                _voucherText('Voucher No : ${data.vNum}'),
              ],
            ),
          ),
        )
      ]);

  Widget _buildStackMovie(context) => Stack(children: <Widget>[
        AspectRatio(
          aspectRatio: 3,
          child: ClipRRect(
            child: Image.asset('assets/images/holiday_voucher.jpg'),
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 1 / 3,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 56),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _voucherText('Name : ${data.name}'),
                _voucherText('Email : ${data.email}'),
                _voucherText('Phone : ${data.phone}'),
                _voucherText('Voucher No : ${data.vNum}'),
              ],
            ),
          ),
        )
      ]);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isYellow: true,
        titleText: 'Voucher Details',
        child: BaseImageContainer(
          opacity: 0.7,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withAlpha(150)),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    _boldText(' Voucher Issued Branch :\n ${data.branch}'),
                    _boldText(' Voucher Issued Date : ${data.issueDate}'),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildStack(context),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildStackMovie(context),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonFormSubmit(
                        text: _downloadedPath != null
                            ? 'View Voucher'
                            : 'Download Voucher',
                        onClick: () async {
                          if (_downloadedPath != null) {
                            await OpenFilex.open(_downloadedPath);
                          } else {
                            showProgressDialog(context);
                            Provider.of<DownloadProvider>(context,
                                    listen: false)
                                .downloadFile(data.path ?? 'N/A',type: 'vch')
                                .then((value) async {
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: value != null
                                      ? 'Download Success'
                                      : 'Download Failed!!!');
                              if (value != null) {
                                setState(() {
                                  _downloadedPath = value;
                                });
                                await OpenFilex.open(value);
                              }
                            });
                          }
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0, right: 0, top: 20),
//                         height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _boldText('Membership Category : ${data.category}'),
                            _normalText(
                              'Promo code maximum limit Rs. 400 valid only movie tickets',
                            ),
                            _boldText(
                              '\nHOLIDAY GIFT VOUCHER\n1. Holiday Destination :',
                            ),
                            _normalText(
                              '${data.destination}',
                            ),
                            _boldText(
                              '\n2. One Year Validity \n3. Terms & Conditions :',
                            ),
                            _normalText(
                              ' - Locations and properties are timely amended.\n'
                              ' - Booking is purely subject to availability as per the off-peak season.\n'
                              ' - The accommodation is in respect of a studio unit, which accommodates 2 adults and two kids below 6 years (samebed) occupancy cannot be exceeded. Food and travel expenses to be borne by the recipient. It will expire in one yearfrom the date of issuance.\n'
                              ' - The voucher allows you to experience with The Pacific Holiday World. This offer is for off peak accommodation which isdefined by each resort.\n'
                              ' - Reservation for 2 Nights can be done on 15 working days prior notification. Reservation against movie voucher can bedone on 7 working days prior notification. The movie tickets will be available only for Monday to Thursday, not availablefor Friday to Sunday and gazetted holidays.\n'
                              ' - Utility charges are applicable for accommodation of 2 nights (off -peak).\n'
                              ' - All accommodations are subject to availability. This Voucher is to be produced to confirm the accommodation andguests are expected to produce the confirmation voucher and a photo identification issued by Govt. / State whilechecking into the resorts. The Management reserves the right to offer alternative accommodation from the onestipulated on the confirmation letter.\n'
                              ' - This voucher is not transferable, cannot be exchanged for cash and if not availed within the stipulated period will lapse\n',
                            ),
                            _boldText(
                              '\nCorporate Office :',
                            ),
                            _normalText(
                              'A-214, 2nd Floor, Pocket-A, Okhla Phase-1, New Delhi - 110020',
                            ),
                            _boldText(
                              '\nEmail :',
                            ),
                            _normalText(
                              'voucher@thepacificholidayworld.com\n\n',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

