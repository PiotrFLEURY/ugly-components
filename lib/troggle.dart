import 'package:flutter/material.dart';

class Troggle extends StatefulWidget {
  final double height;
  final double width;
  final int quarterTurns;

  const Troggle({
    Key? key,
    this.width = 48.0,
    this.height = 48.0,
    this.quarterTurns = 0,
  }) : super(key: key);

  @override
  State<Troggle> createState() => _TroggleState();
}

class _TroggleState extends State<Troggle> {
  int _position = 0;

  get _bubbleHeight => widget.height * 0.3;

  Offset _offsetPosition(Size size) {
    switch (_position) {
      case 0:
        return Offset(
          size.width / 2 - _bubbleHeight,
          size.height / 2.5 - _bubbleHeight,
        );
      case 1:
        return Offset(
          size.width / 2,
          size.height / 2.5 - _bubbleHeight,
        );

      default:
        return Offset(
          size.width / 2 - _bubbleHeight / 2,
          size.height / 2.5,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.quarterTurns,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _position = _position == 2 ? 0 : _position + 1;
          });
        },
        child: ClipPath(
          clipper: _TriangleClipper(),
          child: CustomPaint(
            painter: _Triangle(),
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: Stack(
                children: [
                  SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: _position == 0
                            ? Colors.red
                            : _position == 1
                                ? Colors.green
                                : Colors.blue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    left: _offsetPosition(Size(widget.width, widget.height)).dx,
                    top: _offsetPosition(Size(widget.width, widget.height)).dy,
                    child: _Bubble(
                      bubbleHeight: _bubbleHeight,
                      widget: widget,
                      position: _position,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final double bubbleHeight;
  final Troggle widget;
  final int position;

  const _Bubble({
    Key? key,
    required this.bubbleHeight,
    required this.widget,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bubbleHeight,
      width: bubbleHeight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(bubbleHeight),
          border: Border.all(
            color: Colors.grey[400]!,
            width: bubbleHeight / 20,
          ),
        ),
        child: RotatedBox(
          quarterTurns: -1 * widget.quarterTurns,
          child: Icon(
            position == 0
                ? Icons.close
                : position == 1
                    ? Icons.check
                    : Icons.help_outline_outlined,
            size: bubbleHeight * 0.6,
            color: position == 0
                ? Colors.red
                : position == 1
                    ? Colors.green
                    : Colors.blue,
          ),
        ),
      ),
    );
  }
}

Path _getPath(Size size) => Path()
  ..moveTo(size.width * .3, 0)
  ..lineTo(size.width * .7, 0)
  ..quadraticBezierTo(
    size.width * .9,
    size.height * .1,
    size.width * .9,
    size.height * .3,
  )
  ..lineTo(
    size.width * .7,
    size.height * .7,
  )
  ..quadraticBezierTo(
    size.width / 2,
    size.height * .9,
    size.width * .3,
    size.height * .7,
  )
  ..lineTo(
    size.width * .1,
    size.height * .3,
  )
  ..quadraticBezierTo(
    size.width * .1,
    size.height * .1,
    size.width * .3,
    0,
  )
  ..close();

class _Triangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      _getPath(size),
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    return _getPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
