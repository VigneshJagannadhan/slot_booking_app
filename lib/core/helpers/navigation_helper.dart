import 'package:flutter/widgets.dart';

pushToNamedRoute({required BuildContext context, required String route}) =>
    Navigator.pushNamed(context, route);

pushReplaceNamedRoute({required BuildContext context, required String route}) =>
    Navigator.pushReplacementNamed(context, route);

popRoute({required BuildContext context}) {
  Navigator.pop(context);
}
