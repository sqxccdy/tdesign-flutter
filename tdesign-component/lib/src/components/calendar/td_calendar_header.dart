import 'package:flutter/material.dart';

import '../../util/context_extension.dart';
import '../icon/td_icons.dart';
import '../text/td_text.dart';

class TDCalendarHeader extends StatelessWidget {
  const TDCalendarHeader({
    Key? key,
    required this.firstDayOfWeek,
    required this.weekdayGap,
    required this.padding,
    this.weekdayStyle,
    required this.weekdayHeight,
    this.title,
    this.titleStyle,
    this.titleWidget,
    this.titleMaxLine,
    this.titleOverflow,
    this.closeBtn = true,
    this.closeColor,
    this.onClose,
  }) : super(key: key);

  final int firstDayOfWeek;
  final double weekdayGap;
  final double padding;
  final TextStyle? weekdayStyle;
  final double weekdayHeight;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? titleWidget;
  final int? titleMaxLine;
  final TextOverflow? titleOverflow;
  final bool closeBtn;
  final Color? closeColor;
  final VoidCallback? onClose;

  List<String> _getDays(BuildContext context) {
    final raw = [
      context.resource.sunday,
      context.resource.monday,
      context.resource.tuesday,
      context.resource.wednesday,
      context.resource.thursday,
      context.resource.friday,
      context.resource.saturday,
    ];
    final ans = <String>[];
    var i = firstDayOfWeek % 7;
    while (ans.length < 7) {
      ans.add(raw[i]);
      i = (i + 1) % 7;
    }
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    final list = _getDays(context);
    return Container(
      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
      child: Column(
        children: [
          if (title?.isNotEmpty == true || titleWidget != null || closeBtn)
            Container(
              padding: EdgeInsets.fromLTRB(0, padding, 0, padding),
              child: Row(
                children: [
                  if (closeBtn) const SizedBox(width: 24),
                  Expanded(
                    child: Center(
                      child: titleWidget ??
                          TDText(
                            title,
                            style: titleStyle,
                            maxLines: titleMaxLine,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                  if (closeBtn)
                    SizedBox(
                      width: 24,
                      child: GestureDetector(
                        child: Icon(TDIcons.close, color: closeColor),
                        onTap: () {
                          onClose?.call();
                        },
                      ),
                    ),
                ],
              ),
            ),
          Row(
            children: List.generate(list.length, (index) {
              return Expanded(
                child: Container(
                  height: weekdayHeight,
                  margin: list.length == index + 1 ? null : EdgeInsets.only(right: weekdayGap),
                  child: Center(
                    child: TDText(
                      list[index],
                      style: weekdayStyle,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
