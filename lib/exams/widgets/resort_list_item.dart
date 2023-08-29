import 'package:flutter/material.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/exams/screens/exam_screen.dart';
import 'package:exam_list/responseModels/resorts/get_resorts_response.dart';
import 'package:exam_list/responseModels/search/search_places_response.dart'
    as search;
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/image_handling.dart';

class ResortListItem extends StatelessWidget {
  final Data? data;
  final search.Data? sData;
  final String dId;

  const ResortListItem({Key? key, this.data, this.sData, required this.dId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemHeight = ((MediaQuery.of(context).size.width - 32)) * 5 / 9;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(itemHeight * 0.15),
      ),
      child: InkWell(
        onTap: () {
          var endPoint = ApiEndPoints.getResort
              .replaceAll('{dId}', dId)
              .replaceAll("{rId}", data?.id ?? sData?.id ?? "0");
          Navigator.of(context)
              .pushNamed(ExamScreen.routeName, arguments: endPoint);
        },
        child: ClipRRect(
          child: SizedBox(
            width: double.infinity,
            height: itemHeight,
            child: Stack(
              children: [
                cachedImageWithDimens(data?.image ?? sData?.mainImage ?? "",
                    double.infinity, itemHeight, BoxFit.cover),
                Positioned(
                  child: Container(
                      width: double.infinity,
                      height: itemHeight,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black87,
                          Colors.black45,
                          Colors.black26,
                          Colors.black12,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent
                        ],
                      ))),
                  bottom: 0,
                  left: 0,
                  right: 0,
                ),
                Positioned(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            data?.name ?? sData?.name ?? "--",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.robotoWhiteText().copyWith(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          flex: 5,
                        ),
                        const Flexible(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                    left: 16,
                    right: 16,
                    bottom: 20),
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(itemHeight * 0.15),
        ),
      ),
    );
  }
}
