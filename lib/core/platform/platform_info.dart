import 'dart:io';
import 'package:flutter/foundation.dart';

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isWindows => !kIsWeb && Platform.isWindows;
bool get isLinux => !kIsWeb && Platform.isLinux;
bool get isDesktop => isWindows || isLinux;
