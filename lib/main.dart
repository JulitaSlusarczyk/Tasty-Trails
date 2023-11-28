import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_trails/pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  await Flame.device.setPortrait();

  runApp(const ProviderScope(child: StartPage()));
}
