import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:exam_list/responseModels/login/member_fee_payments.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';

class FeeListing extends StatelessWidget {
  final Data? feeData;
  final bool isMember;
  final Function downloadReceipt;

  const FeeListing(
      {Key? key,
      required this.feeData,
      required this.isMember,
      required this.downloadReceipt})
      : super(key: key);

  Widget _textWithIconLeft(String title, IconData icon, String? text) {
    if (text != null && text != '') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Icon(
              icon,
              size: 18,
              color: appBlue,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w200),
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

  Widget _headingText(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: AppStyles.robotoOrangeText(),
                ),
              ),
              if (feeData?.invoiceUrl != null)
                ElevatedButton(
                    onPressed: () async {
                      if (feeData?.isDownloaded == true) {
                        await OpenFilex.open(feeData?.filePath);
                      } else {
                        downloadReceipt(feeData?.invoiceUrl);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14), // <-- Radius
                      ),
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      (feeData?.isDownloaded == true)
                          ? 'View Receipt'
                          : 'Download',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Divider(
            height: 1,
            color: appDividerColorDark,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //(isMember?'Member Payment Details':'AMC Payment Details')+
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white.withAlpha(225)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headingText(context, feeData?.receiptNum ?? "N/A"),
            _textWithIconLeft(
                'Receipt No.', Icons.receipt_long, feeData?.receiptNum),
            _textWithIconLeft(
                'Receipt Date', Icons.date_range_sharp, feeData?.genDate),
            _textWithIconLeft(
                'Mode', Icons.account_balance_wallet_sharp, feeData?.mode),
            _textWithIconLeft('Bank', Icons.account_balance, feeData?.bank),
            _textWithIconLeft('Cheque/Credit/Debit Card', Icons.credit_card,
                feeData?.cardNum),
            _textWithIconLeft(
                'Payment type', Icons.payments, feeData?.paymentType),
            _textWithIconLeft(
                'Amount', Icons.attach_money_outlined, feeData?.amount),
          ],
        ));
  }
}
