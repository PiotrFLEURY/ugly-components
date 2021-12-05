import 'package:flutter/material.dart';

class ExclusiveRadio extends StatefulWidget {
  final int index;
  final String text;

  late Function onSelected, onNotSelected;

  ExclusiveRadio({
    Key? key,
    required this.index,
    required this.text,
  }) : super(key: key);

  @override
  State<ExclusiveRadio> createState() => _ExclusiveRadioState();
}

class _ExclusiveRadioState extends State<ExclusiveRadio> {
  bool _isSelected = false;

  @override
  void initState() {
    widget.onSelected = () {
      setState(() {
        _isSelected = true;
      });
    };
    widget.onNotSelected = () {
      setState(() {
        _isSelected = false;
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isSelected ? Colors.black : Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: _isSelected
              ? Container()
              : Icon(
                  Icons.close_outlined,
                  size: 12,
                ),
        ),
        const SizedBox(width: 8.0),
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _isSelected ? Colors.black : Colors.grey[400]!,
            decoration: _isSelected ? null : TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }
}

enum ExclusiveRadioGroupAlignment {
  horizontal,
  vertical,
}

class ExclusiveRadioGroup extends StatelessWidget {
  final List<ExclusiveRadio> children;
  final ExclusiveRadioGroupAlignment alignment;

  const ExclusiveRadioGroup({
    Key? key,
    required this.children,
    required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _children = children
        .map((child) => GestureDetector(
              child: child,
              onTap: () => onSelected(child.index),
            ))
        .toList();
    return alignment == ExclusiveRadioGroupAlignment.horizontal
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _children,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _children,
          );
  }

  onSelected(int index) {
    children[index].onSelected();
    children.where((element) => element.index != index).forEach(
          (element) => element.onNotSelected(),
        );
  }
}
