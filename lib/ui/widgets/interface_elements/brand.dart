import 'package:flutter/cupertino.dart';

import '../../../internal/config/theme_config.dart';
import 'fitted_text.dart';

class Brand extends StatelessWidget {
  const Brand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      FittedText("Photogram", textAlign: TextAlign.center, style: logoFont());
}
