import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  const CustomItem({
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
      color: const Color(0xFF333856),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
       bottom: 5, // Space between underline and text
     ),
     decoration: const BoxDecoration(
         border: Border(bottom: BorderSide(
         color: Colors.blueGrey, 
         width: 1.5, // Underline thickness
        ))
      ),
              child: Text(
                '$mainTitle',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.blueGrey[100],
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              "$subTitle",
              style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
            ),
           
          ],
        ),
      ),
    );
  }
}
