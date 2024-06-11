import 'package:eye_diseases/Widgets/custom_item.dart';
import 'package:eye_diseases/Widgets/disease_item.dart';
import 'package:eye_diseases/Widgets/header_footer_item.dart';
import 'package:eye_diseases/models/diseases_model.dart';
import 'package:flutter/material.dart';

class DiabeticRetinopathyView extends StatelessWidget {
  const DiabeticRetinopathyView({super.key, required this.values});

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
            child: DiseaseItem(dmodel: values),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Prevalence rate',
                subTitle:
                    'Affecting one in three people with diabetes, translating to 144 million individuals globally. With the burgeoning prevalence of diabetes, this number is expected to climb to 246 million by 2040, highlighting the urgent need for preventative measures and effective treatments.'),
          ),
          const SliverToBoxAdapter(
            child: Image(
              image: AssetImage('assets/images/eyes-open_576x513.jpg'),fit: BoxFit.fill,
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(mainTitle: 'Symptoms', subTitle: '''
- Eye floaters
- Blurriness
- Black spots in the area of vision
- Loss of central vision
- Blindness.'''),
          ),
          const SliverToBoxAdapter(
            child: Image(
              image: AssetImage(
                  'assets/images/diabetic-retinopathy_fundus_576x513.jpeg'),fit: BoxFit.fill,
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Treatment',
                subTitle: '''Treatment depends on the severity of the condition:
- Early detection and management of diabetes are crucial to prevent diabetic retinopathy.
- Laser treatment, Injections into the eye.
- Surgery may be needed.'''),
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