import 'package:flutter/material.dart';
import 'package:exam_list/styles/app_styles.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  final String desc =
      'The Pacific Holiday World(A Unit Of 4r Seasons Holidays Pvt. Ltd.) is a renowned & fastest growing Vacations Ownership company that offers you vacations in scores of diverse hotels and resorts at various destinations.'
      'The Pacific Holiday World (A Unit Of 4r Seasons Holidays Pvt. Ltd.) was founded with a dream of making holidays an active part of the Indian consumer’s lifestyle. We are the fastest growing Vacations Ownership company with a difference.Our guests have enjoyed priceless holidays at exceptional destinations all over the world. we have found our existence in this ambitious concept that endeavours to help you discover your life and happiness. Floated by professionals with more than 25 years of industry experience in management and hospitality, ordability is another criterion that makes us special for travellers. Vacations can be expensive but when you go through The Pacific Holiday World ownership, you will be pleasantly surprised by the exclusivity and the comparatively low costs & Best prices.'
      'We at The Pacific Holiday World bring together a fusion of warm Indian hospitality and the highest standards of service. Our Service philosophy stands on three key pillars: our People, with passionate and outstanding service, Experiences, that are unique and enriching, and lastly, our Destinations, rich and diverse, each with so much to offer. These are tied into our service philosophy of PEPS (People, Experiences, Places- Spark Joy) and this is exactly what we endeavor to do, spark joy at every interaction, with every action.'
      'The Pacific Holiday World is spread across the globe with 147 associates and 1,000+ ties up properties. The Pacific Holiday World has its prime functional head office in New Delhi.';
  final String miss = '\n' 'Mission' '\n';
  final String fort =
      'The Pacific Holiday World is an amalgamation of hard-work and determination that aims to deliver extraordinary service to the one’s who get connected with us. Our costumers desires are of prime importance to us. Thus, we will leave no stones unturned to achieve our goal.';

  final String vis = '\n' 'Vision' '\n';
  final String visdes =
      'The Pacific Holiday World envisions in delivering excellent services to the customers vis-a-vis 100% client satisfaction. The Pacific Holiday World also renders a diverse-range of holiday membership for their respective clients. We present you 3500+ destinations and look forward to install 500 more exotic resorts in the future.';

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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About Us\n",
                  style: AppStyles.robotoBlackText()
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  desc,
                  style: AppStyles.description(),
                ),
                Text(miss,
                    style: AppStyles.robotoBlackText()
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(
                  fort,
                  style: AppStyles.description(),
                ),
                Text(vis,
                    style: AppStyles.robotoBlackText()
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(
                  visdes,
                  style: AppStyles.description(),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
