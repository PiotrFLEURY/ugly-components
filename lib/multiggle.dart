import 'package:flutter/material.dart';

typedef OnPositionChanged = Function(int);

class Multiggle extends StatefulWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color indicatorColor;
  final int count;
  final OnPositionChanged? onPositionChanged;

  const Multiggle({
    Key? key,
    this.backgroundColor = Colors.grey,
    this.borderColor = Colors.black,
    this.indicatorColor = Colors.black,
    required this.count,
    this.onPositionChanged,
  }) : super(key: key);

  @override
  State<Multiggle> createState() => _MultiggleState();
}

class _MultiggleState extends State<Multiggle> {
  int _position = 0;

  List<Widget> _buildDots() {
    return List.generate(
      widget.count,
      (index) => const _Dot(
        size: 10,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _position = (++_position) % widget.count;
          widget.onPositionChanged?.call(_position);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: widget.borderColor,
            width: 4,
          ),
        ),
        child: SizedBox(
          height: 32.0,
          width: (widget.count + 1) * 32.0,
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildDots(),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: (_position + 1) * 32.0 - 10,
                top: 6,
                child: _Dot(
                  size: 20,
                  color: widget.indicatorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double size;
  final Color color;

  const _Dot({
    Key? key,
    this.size = 10,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
