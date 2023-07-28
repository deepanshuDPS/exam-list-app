import 'package:flutter/material.dart';
import 'package:exam_list/options/widgets/testimonial_list_item.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        child: const ContainerLoading(),
        builder: (ctx, home, ch) {
          if (home.testimonialsRequest.isLoading) {
            return ch!;
          } else if (home.testimonialsRequest.isError) {
            return ContainerError(
              jsonData: home.testimonialsRequest.data,
              onTryAgain: () => {_onTryAgain(context)},
            );
          }
          return ListView.builder(
              itemCount: home.getTestimonials.length,
              itemBuilder: (BuildContext ctx, int index) {
                return TestimonialListItem(
                  data: home.getTestimonials[index],
                  index: index,
                );
              });
        });
  }

  void _onTryAgain(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).fetchTestimonials();
  }
}
