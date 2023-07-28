import 'package:flutter/material.dart';
import 'package:exam_list/styles/app_styles.dart';

class BenefitsPage extends StatelessWidget {
  const BenefitsPage({Key? key}) : super(key: key);

  // Widget _tableHeadBox(BuildContext context, String title) {
  //   return Expanded(
  //     flex: 1,
  //     child: Container(
  //       //margin: const EdgeInsets.all(30.0),
  //       padding: const EdgeInsets.symmetric(vertical: 10),
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).colorScheme.secondaryVariant,
  //         border: Border.all(
  //           width: 1, //                   <--- border width here
  //         ),
  //       ), //       <--- BoxDecoration here
  //       child: Column(
  //         children: [
  //           Text(
  //             title,
  //             style: TextStyle(
  //                 backgroundColor:
  //                     Theme.of(context).colorScheme.secondaryVariant,
  //                 fontSize: 12.0,
  //                 color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _tableDataBox(BuildContext context, String dataText) {
  //   return Expanded(
  //     flex: 1,
  //     child: Container(
  //       // margin: const EdgeInsets.all(10.0),
  //       padding: const EdgeInsets.symmetric(vertical: 20),
  //       decoration: BoxDecoration(
  //         border: Border.all(
  //           width: 1, //                   <--- border width here
  //         ),
  //       ), //       <--- BoxDecoration here
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(left: 4),
  //             child: Text(
  //               dataText,
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(fontSize: 10.0, color: Colors.black),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white.withAlpha(200)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Membership Benefits Of Pacific Holiday',
              style: AppStyles.robotoBlackText()
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Holidays Membership are the finest way to connect with family ,friends and loved ones and The Pacific Holiday World Membership is excellent for that. It is your dedication to collaboration and discovery. You may enjoy future vacations at today's costs with this membership. Pay once and get access to a diverse selection of resorts, locations, and personalised experiences for the next 30 years. A Pacific Holiday Membership is a promise to your loved ones of pleasure and happiness.",
              style: AppStyles.description(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Worldwide Access 100+ Resorts',
              style: AppStyles.robotoBlackText()
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "As a Pacific Holiday World membership, you get access to over 1000 wonderful resorts around India and the world. From the majestic Corbett woods and the serene backwaters of Kerala to Singapore's electric buzz and the amazing elegance of Finland, we provide warm hospitality, outstanding services, and holiday experiences. Assume you have extremely limited access to over 1000 resorts.",
              style: AppStyles.description(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Exclusive Experiences Only with Pacific Holiday World',
              style: AppStyles.robotoBlackText()
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Have you ever attempted Yoga in the morning on a gentle mountain top? Or has the sun been setting steadily and you've been watching a live ghazal concert? Can you image sitting in the middle of the ocean with an elephant? Or, even better, visit the actual Santa Claus in Finland's hamlet with your family? Your Pacific Holiday World membership gives you access to special experiences in over 1000 resorts throughout the world. Consider this your ticket to a magnificent world of experiences."
              "\n\n"
              "Our resorts are all family-friendly, and our members make up a large, happy travel family. Visit our website's The Pacific Holiday World review area to get a taste of the excitement your family is anticipating. Have you completed your packing?",
              style: AppStyles.description(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Luxury Spacious Rooms',
              style: AppStyles.robotoBlackText()
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Can a Holiday season in which everyone in your family gets their own room appear too good to be true? It seldom happens at Pacific Holiday World. With your Pacific Holiday World membership, you may enjoy your trips in spacious rooms with most of the amenities you choose. Furthermore, you might select a couple of them autographs keep experiences.',
              style: AppStyles.description(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Membership Price List",
                textAlign: TextAlign.start,
                style: AppStyles.robotoBlackText()
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Image.network(
                'https://thepacificholidayworld.com/assets/images/pricing.jpg'),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Payment',
              style: AppStyles.robotoBlackText()
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Mode of payment Draft, Cheque or Credit Card in Favor of 4R Seasons Holidays Pvt. Ltd.',
              style: AppStyles.description(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'NOTE',
              style: AppStyles.robotoBlackText()
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'In addition to the prices mentioned above, the member would have to pay an Annual Subscription Fee every year (irrespective of the usage). The Annual Subscription Fee T2 Apartment Rs. 23450/- and T1 Apartment Rs. 14300/-.\n*Terms and Conditions apply.',
              style: AppStyles.description(),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
