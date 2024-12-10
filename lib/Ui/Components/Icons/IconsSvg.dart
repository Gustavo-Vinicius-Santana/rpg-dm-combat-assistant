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

  static Widget combateEspadasIcon({
    double sizeheight = 30.0,
    double sizeWidth = 10.0,
  }) {
    return SvgPicture.asset(
      'assets/combate_espadas_icone.svg',
      width: sizeWidth,
      height: sizeheight,
      color: Colors.grey,
    );
  }

  static Widget combateBigEspadasIcon({
    double sizeheight = 100.0,
    double sizeWidth = 100.0,
  }) {
    return SvgPicture.asset(
      'assets/combate_espadas_icone.svg',
      width: sizeWidth,
      height: sizeheight,
      color: Colors.grey,
    );
  }

  static Widget monstrosCabecaIcon({
    double sizeheight = 30.0,
    double sizeWidth = 10.0,
  }) {
    return SvgPicture.asset(
      'assets/monstros_cabeca_icone.svg',
      width: sizeWidth,
      height: sizeheight,
      color: Colors.grey,
    );
  }

  static Widget monstrosBigCabecaIcon({
    double sizeheight = 100.0,
    double sizeWidth = 100.0,
  }) {
    return SvgPicture.asset(
      'assets/monstros_cabeca_icone.svg',
      width: sizeWidth,
      height: sizeheight,
      color: Colors.grey,
    );
  }

  static Widget jogadorCabecaIcon({
    double sizeheight = 30.0,
    double sizeWidth = 10.0,
  }) {
    return SvgPicture.asset(
      'assets/jogador_cabeca_icone.svg',
      width: sizeWidth,
      height: sizeheight,
      color: Colors.grey,
    );
  }

  static Widget jogadorBigCabecaIcon({
    double sizeheight = 100.0,
    double sizeWidth = 100.0,
  }) {
    return SvgPicture.asset(
      'assets/jogador_cabeca_icone.svg',
      width: sizeWidth,
      height: sizeheight,
      color: Colors.grey,
    );
  }
}
