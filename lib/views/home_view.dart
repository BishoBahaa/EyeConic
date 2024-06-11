// import 'package:dio/dio.dart';
import 'package:eye_diseases/Widgets/disease_item_list.dart';
import 'package:eye_diseases/Widgets/header_footer_item.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        // actions: [
        //   Icon(
        //     Icons.view_day_outlined,
        //     color: Colors.blueGrey[200],
        //   ),
        //   const SizedBox(
        //     width: 12,
        //   )
        // ],
        backgroundColor: const Color(0xFF242A46),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF242A46),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 46),
          child: ListView(
            children: [
              ListTile(
                title: const Center(
                  child: Text(
                    'HOME',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const Divider(color: Colors.grey),
              ListTile(
                title: const Center(
                  child: Text(
                    'DISEASES',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const Divider(color: Colors.grey),
              ListTile(
                title: const Center(
                  child: Text(
                    'ABOUT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const Divider(color: Colors.grey),
              ListTile(
                title: const Center(
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const Divider(color: Colors.grey),
              ListTile(
                title: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: HeaderFooterItem(
              mainTitle: '''Hi, Welcome to
              Eye Conic 👁️''',
              subTitle: 'Your vision is our passion',
            ),
          ),
          DiseaseItemList(),
          const SliverToBoxAdapter(
            child: HeaderFooterItem(
              mainTitle: 'Eye Disease',
              subTitle:
                  'Vision,the cornerstone of our interaction with the world, stands vulnerable to a multitude of insidious threats. Globally, an estimated 2.2 billion people experience near or distant vision impairment, with countless others at risk of developing debilitating eye diseases.Among these, three key players cast a particularly long shadow: cataract, glaucoma, and diabetic retinopathy.',
            ),
          ),
        ],
      ),
    );
  }
}
