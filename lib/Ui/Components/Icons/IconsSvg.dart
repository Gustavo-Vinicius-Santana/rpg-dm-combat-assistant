import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static Widget personagemIcon({
    required int selectedIndex,
    double size = 35.0,
  }) {
    return SvgPicture.asset(
      'assets/personagem_icone.svg',
      width: size,
      height: size,
      color: selectedIndex == 0 ? Colors.blue : Colors.grey,
    );
  }

  static Widget combateIcon({
    required int selectedIndex,
    double size = 35.0,
  }) {
    return SvgPicture.asset(
      'assets/combate_icone.svg',
      width: size,
      height: size,
      color: selectedIndex == 1 ? Colors.blue : Colors.grey,
    );
  }

  static Widget monstroIcon({
    required int selectedIndex,
    double size = 35.0,
  }) {
    return SvgPicture.asset(
      'assets/monstro_icone.svg',
      width: size,
      height: size,
      color: selectedIndex == 2 ? Colors.blue : Colors.grey,
    );
  }
}
