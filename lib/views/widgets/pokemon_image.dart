import 'package:flutter/material.dart';
import 'package:pokeflutter/utils/capitalize.dart';
import '../../model/pokemon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.dominantColor,
    required this.pokemon,
    required this.theme,
  });

  final Color? dominantColor;
  final Pokemon? pokemon;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [dominantColor ?? Colors.grey, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "#${pokemon?.id.toString().padLeft(3, "0") ?? ""}",
                  style: theme.textTheme.titleLarge,
                ),
                const Icon(Icons.favorite_border),
              ],
            ),
          ),
          Image.network(
            pokemon?.urlImage ?? "",
            width: 260.w,
            height: 260.h,
          ),
          Text(
            pokemon?.name.capitalize() ?? "",
            style: theme.textTheme.titleLarge,
          ),
          Text(
            "${pokemon?.typesList[0]}  Pokèmon".capitalize(),
            style: theme.textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
