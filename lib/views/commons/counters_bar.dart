import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';
import 'package:mtg_roulette/tools/tools.dart';



class CountersBar extends StatefulWidget {
  CountersBar({Key? key}) : super(key: key);

  @override
  State<CountersBar> createState() => _CountersBarState();
}

class _CountersBarState extends State<CountersBar> {
  List<String> _setCounterList = ['PSN', 'ENR', 'EXP'];
  bool _visible = false;

  void _toggleMenu() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          //border: Border.all()
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ---------- Set counters
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (String c in _setCounterList) CounterItem(tag: c,),
                ],
              ),
            ),
            // -------
            Container(
              /*width: getScreenWidth(context) / 8,
            height: getScreenWidth(context) / 8,*/
              child: Center(
                child: InkWell(
                  child: Icon(
                    Icons.add_circle_outline,
                  ),
                  onTap: () {
                    _toggleMenu();
                  },
                ),
              ),
            ),
            // ---------- Menu hidden
            SizedBox(
              child: Visibility(
                  visible: _visible,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: Row(
                    children: [
                      for (String c in _setCounterList) CounterItem(tag: c,),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}


class CounterItem extends StatelessWidget {
  final String tag;
  CounterItem({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.black,
      child: Text(tag, style: TextStyle(color: AppColors.white),),
    );
  }
}
