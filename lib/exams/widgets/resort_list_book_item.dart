import 'package:flutter/material.dart';
import 'package:exam_list/responseModels/resorts/get_resorts_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/image_handling.dart';

class ResortListBookItem extends StatelessWidget {
  final Data? data;
  final Function booking;

  const ResortListBookItem({Key? key, required this.data, required this.booking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemHeight = ((MediaQuery.of(context).size.width - 32)) * 5 / 9;
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(itemHeight * 0.075),
      ),
      child: Column(
        children: [
          ClipRRect(
            child: SizedBox(
              width: double.infinity,
              height: itemHeight,
              child: cachedImageWithWidth(
                  data?.image ?? "", BoxFit.cover, double.infinity),
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    data?.name ?? "--",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.robotoWhiteText().copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(width: 4,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                        primary: Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      booking(data?.name??'');
                    },
                    child: UnconstrainedBox(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Book Now',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.touch_app_rounded,
                              size: 16,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
