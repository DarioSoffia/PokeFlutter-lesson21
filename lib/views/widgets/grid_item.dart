import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokeflutter/utils/palette.dart';
import 'package:pokeflutter/views/widgets/styled_text.dart';

import '../../utils/capitalize.dart';
import '../../model/pokemon.dart';
import '../../model/pokemon_list_item.dart';
import '../../utils/pokemon_api.dart';
import '../../utils/pokemon_costants.dart';

class GridItem extends StatefulWidget {
  final PokemonListItem pokemon;
  const GridItem({super.key, required this.pokemon});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  Pokemon? pokemon;
  bool _isLoading = true;
  Color? pokemonColor;

  @override
  void initState() {
    fetchPokemonData();
    super.initState();
  }

  void fetchPokemonData() async {
    pokemon = await PokemonApi.getPokemonDetails(widget.pokemon.name);
    pokemonColor = listPokemonTypeColor[pokemon?.typesList[0].toLowerCase()];
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed("detail-page", arguments: pokemon);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: pokemonColor,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Stack(children: [
                Positioned(
                  child: SvgPicture.asset(
                    "assets/pokeball.svg",
                    height: 88.r,
                    width: 88.r,
                    color: Colors.white12,
                  ),
                  bottom: -20.r,
                  right: -11.r,
                ),
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _header(context),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: typesList(pokemon!),
                          ),
                          Container(
                            height: 56.r,
                            width: 56.r,
                            child: Image.network(
                              pokemon!.urlSprite,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ]),
            ),
          );
  }

  List<Widget> typesList(Pokemon pokemon) {
    List<Widget> typesList = [];
    for (var i = 0; i < pokemon.typesList.length; i++) {
      if (i >= 1) {
        typesList.add(SizedBox(
          height: 4.h,
        ));
      }
      typesList.add(
        Container(
          decoration: BoxDecoration(
            color: gray[500]?.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24.r),
          ),
          padding:
              EdgeInsets.only(left: 2.w, top: 2.h, bottom: 2.h, right: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                    "assets/types_icons/Pokémon_${pokemon.typesList[i].capitalize()}_Type_Icon.png"),
                height: 15.r,
                width: 15.r,
              ),
              SizedBox(
                width: 4.w,
              ),
              StyledText(
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.white),
                textHeight: 16.h,
                text: pokemon.typesList[i].capitalize(),
              )
            ],
          ),
        ),
      );
    }
    return typesList;
  }

  Row _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StyledText(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
          text: pokemon?.name.capitalize(),
          textHeight: 16.h,
        ),
        StyledText(
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
              ),
          text: "#${pokemon?.id.toString().padLeft(3, "0")}",
          textHeight: 16.h,
        ),
      ],
    );
  }
}
