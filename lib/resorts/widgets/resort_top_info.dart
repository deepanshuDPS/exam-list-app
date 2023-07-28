import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:exam_list/responseModels/resorts/resort_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/image_handling.dart';

class ResortTopInfo extends StatelessWidget {
  final Data resortData;

  const ResortTopInfo({Key? key, required this.resortData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textWidth = (MediaQuery.of(context).size.width) * .65;
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/img_placeholder.png',
              fit: BoxFit.cover,
            ),
          ),
          Swiper(
            onIndexChanged: (index) {},
            autoplay: true,
            layout: SwiperLayout.DEFAULT,
            itemCount: resortData.images.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: cachedImageProvider(
                        'https://thepacificholidayworld.com/uploads/resorts/${resortData.images[index]}'),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
          Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black87,
                  Colors.black54,
                  Colors.black38,
                  Colors.transparent
                ],
              ))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black45,
                    Colors.black54,
                    Colors.black87,
                  ],
                ))),
          ),
          Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: SizedBox(
                width: textWidth,
                child: Text(resortData.name,
                    style: AppStyles.robotoWhiteText()
                        .copyWith(fontSize: 26, fontWeight: FontWeight.bold)),
              )),
        ],
      ),
    );
  }
}
