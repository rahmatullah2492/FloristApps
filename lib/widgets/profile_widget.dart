import 'package:flutter/material.dart';
import '../views/pages.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback?
      onTap; // Properti onTap untuk menangani aksi ketika widget ditekan
  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Menggunakan GestureDetector untuk menangani aksi ketika widget ditekan
      onTap:
          onTap, // Menggunakan properti onTap untuk menangani aksi ketika widget ditekan
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: BgTumbuhan.blackColor.withOpacity(.5),
                  size: 24,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: BgTumbuhan.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: BgTumbuhan.blackColor.withOpacity(.4),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
