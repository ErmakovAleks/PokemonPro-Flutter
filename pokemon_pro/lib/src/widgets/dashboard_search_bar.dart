import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/constants/pokocolors.dart';
import 'package:pokemon_pro/src/constants/pokofonts.dart';

class DashboardSearchBar extends StatefulWidget {
  final void Function(String) onUpdateSearch;

  const DashboardSearchBar({required this.onUpdateSearch, super.key});

  @override
  State<DashboardSearchBar> createState() => _DashboardSearchBarState();
}

class _DashboardSearchBarState extends State<DashboardSearchBar> {
  bool _isCancelVisible = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _isCancelVisible = _controller.text.isNotEmpty;
        widget.onUpdateSearch(_controller.text);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PokoColors.wildSand,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                labelText: 'Name of Pokemon...',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PokoColors.wildSand),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: PokoColors.gold),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                filled: true,
                fillColor: Colors.white,
                hintStyle: TextStyle(
                    fontFamily: PokoFonts.jakartaSans,
                    fontSize: 15,
                    color: PokoColors.heather),
              ),
              style: const TextStyle(
                fontFamily: PokoFonts.jakartaSans,
                fontSize: 18,
              ),
            ),
          ),
          Visibility(
            maintainSize: false,
            maintainAnimation: true,
            maintainState: true,
            visible: _isCancelVisible,
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerRight),
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: PokoColors.heather,
                    fontFamily: PokoFonts.jakartaSans,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              onPressed: () {
                _controller.text = '';
              },
            ),
          ),
        ],
      ),
    );
  }
}
