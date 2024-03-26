import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/constants/pokofonts.dart';
import 'package:pokemon_pro/src/models/pokemon_detail.dart';

enum TagOption { full, short }

class DashboardTag extends StatelessWidget {
  final PokeType type;
  final TagOption option;
  bool get isFull => option == TagOption.full;

  const DashboardTag({required this.type, required this.option, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          padding: isFull
              ? const EdgeInsets.fromLTRB(4, 2, 8, 2)
              : const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isFull ? 11.5 : 10.0),
            color: type.tagColor,
          ),
          child: isFull
              ? Row(
                  children: [
                    type.tagImage,
                    SizedBox(width: 4),
                    Text(
                      type.type,
                      style: TextStyle(
                        fontFamily: PokoFonts.jakartaSans,
                        fontSize: 15,
                        color: type.tagFont,
                      ),
                    ),
                  ],
                )
              : type.tagImage),
    );
  }
}
