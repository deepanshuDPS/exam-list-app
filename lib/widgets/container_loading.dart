import 'package:flutter/material.dart';

class ContainerLoading extends StatelessWidget {
  const ContainerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/gif_loading.gif',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
