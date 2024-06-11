import 'package:eye_diseases/Widgets/custom_item.dart';
import 'package:eye_diseases/Widgets/disease_item.dart';
import 'package:eye_diseases/Widgets/header_footer_item.dart';
import 'package:eye_diseases/models/diseases_model.dart';
import 'package:flutter/material.dart';

class GlaucomaView extends StatelessWidget {
  const GlaucomaView({super.key, required this.values});

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
            child: DiseaseItem(
              dmodel: values,
              onTap: () {},
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Prevalence rate',
                subTitle:
                    "Afflicts an estimated 77 million people globally, with one in ten over the age of 80 developing the condition. As populations age, glaucoma's burden is projected to surge to 112 million by 2040."),
          ),
          const SliverToBoxAdapter(
            child: Image(
              image: AssetImage('assets/images/Glaucome_576x513.jpeg'),fit: BoxFit.fill,
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Symptoms', subTitle: '''- Loss of peripheral or side vision
- Seeing halos around lights and glare in bright light
- Redness in the eye
- Eye pain
- Eye that looks hazy (particularly in infants)
- Narrow or tunnel vision
- Vision Loss.'''),
          ),
          const SliverToBoxAdapter(
            child: Image(
              image: AssetImage('assets/images/Glaucome_funds_576x513.jpg'),fit: BoxFit.fill,
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomItem(
                mainTitle: 'Treatment',
                subTitle:
                    '''- There is no cure for glaucoma,
- but it can be controlled with eye drops,
- laser treatment,
- surgery,
- Early diagnosis and treatment are crucial to prevent vision loss.'''),
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