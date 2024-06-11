import 'package:eye_diseases/Widgets/custom_item.dart';
import 'package:eye_diseases/Widgets/disease_item.dart';
import 'package:eye_diseases/Widgets/header_footer_item.dart';
import 'package:eye_diseases/models/diseases_model.dart';
import 'package:flutter/material.dart';

class CataractView extends StatelessWidget {
  const CataractView({super.key, required this.values});

  final DiseasesModel values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eye Conic',
          style: TextStyle( 
              background: Paint()
                ..color = const Color.fromARGB(255, 236, 239, 241),
              color: const Color(0xFF242A46),
              fontWeight: FontWeight.w500,
              letterSpacing: 5),
        ),
        backgroundColor: values.color,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color.fromARGB(255, 236, 239, 241),
        ),
        actions: const [
          Icon(
            Icons.view_day_outlined,
            color: Color.fromARGB(255, 236, 239, 241),
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: DiseaseItem(dmodel: values,onTap: () {
              
            },),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
              mainTitle: 'Prevalence rate',
              subTitle:
                  'Affecting over 50 million individuals worldwide. Its prevalence skyrockets with age, impacting one in three people by the age of 65 and nearly half by age 80. This rising tide, coupled with increasing life expectancy, paints a sobering picture of future visual challenges.',
            ),
          ),
          const SliverToBoxAdapter(
            child: Image(
              image: AssetImage('assets/images/cataracts_576x515.jpg'),fit: BoxFit.fill,
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Symptoms', subTitle: '''- Clouded or blurred vision
- Trouble seeing at night
- Sensitivity to light and glare
- Seeing halos around lights
- Frequent changes in eyeglass or contact lens prescription
- Fading or yellowing of colors.'''),
          ),
          const SliverToBoxAdapter(
            child: Image(
              image: AssetImage('assets/images/cataract funds.jpg'),fit: BoxFit.fill,
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Treatment',
                subTitle:
                    '''- Surgery is the only effective treatment for cataracts.
- The cloudy lens is removed and replaced with an artificial lens.
- his is a safe and highly successful procedure'''),
          ),
          const SliverToBoxAdapter(
            child: HeaderFooterItem(
              mainTitle: 'Eye Disease',
              subTitle:
                  'Vision,the cornerstone of our interaction with the world, stands vulnerable to a multitude of insidious threats. Globally, an estimated 2.2 billion people experience near or distant vision impairment, with countless others at risk of developing debilitating eye diseases.Among these, three key players cast a particularly long shadow: cataract, glaucoma, and diabetic retinopathy.',
            ),
          )
        ],
      ),
    );
  }
}

        // body:DiseaseItem(dmodel: values),);