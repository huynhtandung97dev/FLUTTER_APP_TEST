import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveNum on num {
  double get w => ScreenUtil().setWidth(toDouble());
  double get h => ScreenUtil().setHeight(toDouble());
  double get sp => ScreenUtil().setSp(toDouble());
  double get r => ScreenUtil().radius(toDouble());
}
