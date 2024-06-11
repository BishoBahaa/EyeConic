import 'package:eye_diseases/Widgets/custom_item.dart';
import 'package:eye_diseases/Widgets/disease_item.dart';
import 'package:eye_diseases/Widgets/header_footer_item.dart';
import 'package:eye_diseases/models/diseases_model.dart';
import 'package:flutter/material.dart';

class RetinaView extends StatelessWidget {
  const RetinaView({super.key, required this.values});

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
                  "The exact prevalence is unknown, it's considered less common than AMD or diabetic retinopathy.",
            ),
          ),
          const SliverToBoxAdapter(
            child: Image(
              image: AssetImage('assets/images/retina-eye.jpg',),fit: BoxFit.fill,
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Symptoms', subTitle: '''- Blurred vision
- Central vision loss
- Difficulty seeing in low light
- Floaters (seeing shapes floating in your vision)
- Flashes of light
- Sudden vision loss (especially concerning)'''),
          ),
          const SliverToBoxAdapter(
            child: Image(
              image: AssetImage('assets/images/retina.jpg'),fit: BoxFit.fill,
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Treatment',
                subTitle:
                    '''- Anti-VEGF injections (medication)
- Nutritional supplements (for AMD)
- Laser surgery
- Vitrectomy (surgery to remove blood/scar tissue from the eye)
- Photocoagulation (laser treatment to seal retinal tears)
- Scleral buckling surgery (strengthens the eye wall for retinal detachment)
'''),
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