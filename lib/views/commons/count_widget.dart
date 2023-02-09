import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';

class CountWidget extends StatefulWidget {
  final int defaultV;
  final int? lowLimit, highLimit;
  final Color color;
  final bool displaySnack;

  const CountWidget(
      {Key? key,
      this.lowLimit,
      this.highLimit,
      this.displaySnack = false,
      this.color = Colors.transparent,
      required this.defaultV})
      : super(key: key);

  @override
  State<CountWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  late int _count;

  @override
  void initState() {
    _count = widget.defaultV;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all()
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              child: Icon(
                Icons.remove,
              ),
              onTap: () {
                if (widget.lowLimit == null || _count > widget.lowLimit!)
                  setState(() { _count--; });
              },
            ),
          ),
          Text(
            _count.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
          Expanded(
            child: InkWell(
              child: Icon(Icons.add),
              onTap: () {
                if (widget.highLimit == null || _count < widget.highLimit!)
                  setState(() { _count++; });
              },
            ),
          ),
        ],
      ),
    );
  }
}
