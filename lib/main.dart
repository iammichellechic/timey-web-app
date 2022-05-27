import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/app/app.dart';
import 'package:timey_web/locator.dart';
import 'package:timey_web/presentation/pages/base_layout.dart';
import 'package:timey_web/presentation/resources/routes_manager.dart';
import 'package:timey_web/presentation/resources/theme_manager.dart';


import 'data/providers/tags.dart';
import 'data/providers/timeblocks.dart';
import 'navigation-service.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}
