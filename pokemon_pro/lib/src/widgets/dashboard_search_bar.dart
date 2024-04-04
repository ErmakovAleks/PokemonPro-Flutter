import 'package:flutter/material.dart';

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
      color: Theme.of(context).colorScheme.primaryContainer,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                labelText: 'Name of Pokemon...',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: const Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(20.0))),
                filled: true,
                fillColor: Colors.white,
                hintStyle: Theme.of(context).primaryTextTheme.labelSmall,
              ),
              style: Theme.of(context).primaryTextTheme.labelMedium,
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
              child: Text(
                'Cancel',
                style: Theme.of(context).primaryTextTheme.labelSmall,
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
