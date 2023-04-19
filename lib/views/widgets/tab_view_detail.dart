import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokeflutter/model/pokemon.dart';
import 'package:pokeflutter/utils/capitalize.dart';
import 'package:pokeflutter/utils/pokemon_api.dart';
import 'package:pokeflutter/views/widgets/styled_text.dart';

import '../../utils/palette.dart';

class TabViewDetail extends StatefulWidget {
  final Pokemon? pokemon;
  const TabViewDetail({required this.pokemon, super.key});

  @override
  State<TabViewDetail> createState() => _TabViewDetailState();
}

class _TabViewDetailState extends State<TabViewDetail>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  String flavourText = "";
  bool isloading = false;

  void getFlavourText() async {
    setState(() {
      isloading = true;
    });
    flavourText =
        await PokemonApi.getPokemonFlavourText(widget.pokemon?.name ?? "");

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    getFlavourText();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 400.h,
      child: Column(
        children: [
          Container(
            height: 48.h,
            child: TabBar(tabs: [
              Text(
                "About",
                style: theme.textTheme.labelLarge,
              ),
              Text(
                "Stats",
                style: theme.textTheme.labelLarge,
              ),
              Text(
                "Moves",
                style: theme.textTheme.labelLarge,
              ),
              Text(
                "Evolutions",
                style: theme.textTheme.labelLarge,
              ),
            ], controller: controller),
          ),
          Expanded(
            child: TabBarView(controller: controller, children: [
              isloading
                  ? CircularProgressIndicator()
                  : Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            flavourText.replaceAll(RegExp("\n"), " "),
                            style: TextStyle(height: 24 / 16),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
              Text("test2"),
              GridView.count(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                children: moveList(widget.pokemon!, context),
              ),
              Text("test4"),
            ]),
          )
        ],
      ),
    );
  }
}

List<Widget> moveList(Pokemon pokemon, BuildContext context) {
  List<Widget> typesList = [];
  for (var i = 0; i < pokemon.moves.length; i++) {
    typesList.add(
      Container(
        // height: 50.r,
        // width: 100.r,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1.w, color: Colors.black))),
        padding: EdgeInsets.zero,
        child: Text(
          pokemon.moves[i],
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
  return typesList;
}
