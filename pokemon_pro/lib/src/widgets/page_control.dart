import 'package:flutter/material.dart';

class PageControl extends StatelessWidget {
  final int pagesCount;
  final int activePage;
  final void Function(int) onUpdatePage;

  const PageControl({
    required this.pagesCount,
    required this.activePage,
    required this.onUpdatePage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        pagesCount,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: InkWell(
            onTap: () {
              onUpdatePage(index);
            },
            child: _dot(context, index),
          ),
        ),
      ),
    );
  }

  Widget _dot(BuildContext context, int index) {
    ColorScheme styles = Theme.of(context).colorScheme;
    return Container(
      width: 12,
      decoration: BoxDecoration(
        color: activePage == index
            ? styles.secondaryContainer
            : styles.tertiaryContainer,
        border: Border.all(
          width: 1,
          color: styles.secondaryContainer,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
