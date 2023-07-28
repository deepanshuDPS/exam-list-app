import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:exam_list/responseModels/home/home_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/image_handling.dart';

class CustomCornerClipPath extends CustomClipper<Path> {
  final double cornerR;
  final extra = 3.0;

  const CustomCornerClipPath({this.cornerR = 30.0});

  @override
  Path getClip(Size size) => Path()
    ..lineTo(size.width + extra, 0)
    ..lineTo(
      size.width + extra,
      size.height,
    )
    ..arcToPoint(
      Offset(
        size.width - cornerR,
        size.height - cornerR,
      ),
      radius: Radius.circular(cornerR),
      clockwise: false,
    )
    ..lineTo(cornerR - extra, size.height - cornerR - extra)
    ..arcToPoint(
      Offset(
        -extra,
        size.height,
      ),
      radius: Radius.circular(cornerR),
      clockwise: false,
    );

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HomeTopView extends StatefulWidget {
  final Function onSearchClick;
  final Data bannerData;

  const HomeTopView(
      {Key? key, required this.onSearchClick, required this.bannerData})
      : super(key: key);

  @override
  State<HomeTopView> createState() => _HomeTopViewState();
}

class _HomeTopViewState extends State<HomeTopView> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const CustomCornerClipPath(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
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
              onIndexChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              autoplay: true,
              layout: SwiperLayout.DEFAULT,
              itemCount: widget.bannerData.list?.length ?? 0,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: cachedImageProvider(
                          '${widget.bannerData.path ?? ""}${widget.bannerData.list?[index].imageUrl}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            // search box
            Positioned(
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.black54,
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
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 32, bottom: 46),
                child: RichText(
                    text: TextSpan(
                        text: "Explore Your\nTravel\n",
                        style: AppStyles.robotoWhiteText().copyWith(
                            fontSize: 26, fontWeight: FontWeight.w700),
                        children: [
                      TextSpan(
                        text:
                            "Discover your next great adventure, become an explorer to get started!",
                        style: AppStyles.robotoWhiteText().copyWith(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      )
                    ])),
              ),
              bottom: 0,
              left: 0,
              right: 0,
            ),
            Positioned(
              child: InkWell(
                onTap: () => widget.onSearchClick(),
                child: const Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.search_sharp,
                      size: 26,
                    ),
                  ),
                ),
              ),
              top: 8 + MediaQuery.of(context).padding.top,
              right: 16,
            ),
          ],
        ),
      ),
    );
  }
}

/*
 TextField(
                      decoration: InputDecoration(
                        hintText: "Search by Name or City",
                        border: InputBorder.none,
                      ),
* */
