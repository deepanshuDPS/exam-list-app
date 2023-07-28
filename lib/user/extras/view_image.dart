import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/image_handling.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:provider/provider.dart';

class ViewImageSheet extends StatelessWidget {
  final String imageUrl;

  const ViewImageSheet({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        // padding: const EdgeInsets.all(20),
        child: cachedImage(imageUrl, BoxFit.fitWidth));
  }
}
