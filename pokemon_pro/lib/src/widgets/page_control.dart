import 'package:flutter/material.dart';
import '../constants/pokocolors.dart';

class PageControl extends StatelessWidget {
  final int pagesCount;
  final int activePage;
  final void Function(int) onUpdatePage;

  const PageControl(
      {required this.pagesCount,
      required this.activePage,
      required this.onUpdatePage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
            pagesCount,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: InkWell(
                    onTap: () {
                      onUpdatePage(index);
                    },
                    child: Container(
                      width: 12,
                      decoration: BoxDecoration(
                        color: activePage == index
                            ? PokoColors.abbey
                            : PokoColors.wildSand,
                        border: Border.all(width: 1, color: PokoColors.abbey),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )));
  }
}
