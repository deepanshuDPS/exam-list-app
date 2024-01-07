import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget cachedImageWithWidth(String url, BoxFit fitType, double width) {
  return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Image.asset(
            'assets/images/img_placeholder.png',
            fit: fitType,
          ),
      fit: fitType,
      width: width);
}

Widget cachedImageWithSize(String url, BoxFit fitType, double size) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => Image.asset(
      'assets/images/img_placeholder.png',
      fit: fitType,
    ),
    fit: fitType,
    width: size,
    height: size,
  );
}

Widget cachedImage(String url, BoxFit fitType) {
  return CachedNetworkImage(
      imageUrl: url, placeholder: (context, url) => Container(), fit: fitType);
}

Widget cachedImageWithDimens(
    String url, double width, double height, BoxFit fitType,
    {String placeholder = 'assets/images/img_placeholder.png'}) {
  return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (context, url) => Image.asset(
            placeholder,
            fit: fitType,
          ),
      fit: fitType);
}

ImageProvider cachedImageProvider(String url) {
  return CachedNetworkImageProvider(url);
}

Widget imageIcon(String image, double size) {
  if (image.isNotEmpty && image.contains(".svg")) {
    return SvgPicture.asset(
      image,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      image,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}

Widget imageNetworkIcon(String imageUrl,double size, {BoxFit? fit}) {
  if (imageUrl.isNotEmpty && imageUrl.contains(".svg")) {
    return SvgPicture.network(
      imageUrl,
      width: size,
      height: size,
      fit: fit?? BoxFit.cover,
    );
  } else {
    return Image.network(
      imageUrl,
      width: size,
      height: size,
      fit: fit?? BoxFit.cover,
    );
  }
}
