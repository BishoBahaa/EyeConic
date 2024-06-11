import 'package:eye_diseases/views/registration_as.dart';
import 'package:flutter/material.dart';

class HeaderFooterItem extends StatelessWidget {
  const HeaderFooterItem({
    this.mainTitle,
    this.subTitle,
    super.key,
  });
  final String? mainTitle;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(minWidth: double.infinity, minHeight: 420),
      color: const Color(0xFF242A46),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$mainTitle',
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.blueGrey[100],
                  fontWeight: FontWeight.w500),
            ),
            const Divider(
              height: 32,
              thickness: 2,
            ),
            Text(
              "$subTitle",
              style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const RegisterAs();
                    }));
                  },
                  icon: const Icon(Icons.turn_right_sharp),
                  label: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 24, letterSpacing: 2),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                    elevation: 0,
                    side: const BorderSide(
                      width: 1.0,
                      color: Color.fromARGB(255, 236, 239, 241),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
