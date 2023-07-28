import 'package:flutter/material.dart';
import 'package:exam_list/resorts/screens/resorts_listing_screen.dart';
import 'package:exam_list/responseModels/search/all_places_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/image_handling.dart';

class DestListItem extends StatelessWidget {
  final Data data;

  const DestListItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemHeight = ((MediaQuery.of(context).size.width - 32) * 5) / 9;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(itemHeight * 0.15),
      ),
      child: InkWell(
        onTap: () => {
          Navigator.of(context)
              .pushNamed(ResortsListingScreen.routeName, arguments: data)
        },
        child: ClipRRect(
          child: SizedBox(
            width: double.infinity,
            height: itemHeight,
            child: Stack(
              children: [
                cachedImageWithDimens(
                  data.image,
                  double.infinity,
                  itemHeight,
                  BoxFit.cover
                ),
                Positioned(
                  child: Container(
                      width: double.infinity,
                      height: itemHeight,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black54,
                          Colors.black26,
                          Colors.transparent,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 56),
                          child: Text(
                            (data.name ?? "--"),
                            style: AppStyles.robotoWhiteText().copyWith(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    left: 24,
                    bottom: 12),
                const Positioned(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  bottom: 28,
                  right: 28,
                )
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(itemHeight * 0.15),
        ),
      ),
    );
  }
}
