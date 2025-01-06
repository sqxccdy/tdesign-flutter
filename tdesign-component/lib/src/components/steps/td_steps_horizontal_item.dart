import 'package:flutter/material.dart';
import '../../../tdesign_flutter.dart';

/// Steps步骤条，水平步骤item
class TDStepsHorizontalItem extends StatefulWidget {
  final TDStepsItemData data;
  final int index;
  final int stepsCount;
  final int activeIndex;
  final TDStepsStatus status;
  final bool simple;
  final bool readOnly;
  final TDStepsDirection textDirection;
  const TDStepsHorizontalItem({
    super.key,
    required this.data,
    required this.index,
    required this.stepsCount,
    required this.activeIndex,
    required this.status,
    required this.simple,
    required this.readOnly,
    required this.textDirection,
  });

  @override
  State<TDStepsHorizontalItem> createState() => _TDStepsHorizontalItemState();
}

class _TDStepsHorizontalItemState extends State<TDStepsHorizontalItem> {
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    /// 步骤条数字背景色
    var stepsNumberBgColor = TDTheme.of(context).brandNormalColor;
    /// 步骤条数字颜色
    var stepsNumberTextColor = TDTheme.of(context).whiteColor1;
    /// 步骤条标题颜色
    var stepsTitleColor = TDTheme.of(context).brandColor7;
    /// 步骤条icon颜色
    var stepsIconColor = TDTheme.of(context).brandColor7;
    /// 简略步骤条icon颜色
    var simpleStepsIconColor = TDTheme.of(context).brandColor7;

    /// 是否要设置步骤图标widget的Decoration
    var shouldSetIconWidgetDecoration = true;

    Widget? completeIconWidget;
    /// 错误icon图标显示
    Widget errorIconWidget = Icon(TDIcons.close, color: TDTheme.of(context).errorColor6, size: 16,);

    /// 激活索引大于当前索引
    if (widget.activeIndex > widget.index) {
      stepsNumberBgColor = TDTheme.of(context).brandColor1;
      stepsNumberTextColor = TDTheme.of(context).brandColor7;
      stepsTitleColor = TDTheme.of(context).fontGyColor1;
      /// 已完成的用icon图标显示
      completeIconWidget = Icon(TDIcons.check, color: TDTheme.of(context).brandColor7, size: 16,);
    }else if (widget.activeIndex < widget.index) {
      /// 激活索引小于当前索引
      stepsNumberBgColor = TDTheme.of(context).grayColor1;
      stepsNumberTextColor = TDTheme.of(context).fontGyColor3;
      stepsTitleColor = TDTheme.of(context).fontGyColor3;
      stepsIconColor = TDTheme.of(context).fontGyColor3;
      simpleStepsIconColor = TDTheme.of(context).grayColor4;
    }

    /// 步骤条icon图标组件，默认为索引文字
    Widget? stepsIconWidget = Text(
      (widget.index + 1).toString(),
      style: TextStyle(
        color: stepsNumberTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );

    /// 已完成的用icon图标显示
    if (completeIconWidget != null) {
      stepsIconWidget = completeIconWidget;
    }

    /// 传递了成功的icon图标, 已完成的step都需要显示
    if (widget.data.successIcon != null) {
      stepsIconWidget = Icon(widget.data.successIcon, color: stepsIconColor, size: 22,);
      /// 传了图标则不用设置背景色
      shouldSetIconWidgetDecoration = false;
    }

    /// 状态是错误状态，激活索引是当前索引，只有当前激活索引才需要显示
    if (widget.status == TDStepsStatus.error && widget.activeIndex == widget.index) {
      /// 显示错误颜色
      stepsNumberBgColor = TDTheme.of(context).errorColor1;
      stepsTitleColor = TDTheme.of(context).errorColor6;
      /// 显示错误图标
      stepsIconWidget = errorIconWidget;
      if (widget.data.errorIcon != null) {
        stepsIconWidget = Icon(widget.data.errorIcon, color: TDTheme.of(context).errorColor6, size: 22,);
      }
      /// 传了图标则不用设置背景色等Decoration
      shouldSetIconWidgetDecoration = widget.data.errorIcon == null;
      if (widget.simple) {
        simpleStepsIconColor = TDTheme.of(context).errorColor6;
      }
    }

    /// 步骤条icon图标背景和形状
    var iconWidgetDecoration = shouldSetIconWidgetDecoration ? BoxDecoration(
      color: stepsNumberBgColor,
      shape: BoxShape.circle,
    ): null;


    // icon组件容器大小
    var iconContainerSize = 22;
    /// 简略步骤条
    if (widget.simple || widget.readOnly) {
      /// readOnly纯展示
      if (widget.readOnly) {
        simpleStepsIconColor = TDTheme.of(context).brandColor7;
        stepsTitleColor = TDTheme.of(context).fontGyColor1;
      }
      iconContainerSize = 8;
      stepsIconWidget = null;
      /// 简略步骤条BoxDecoration
      var simpleDecoration = BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: simpleStepsIconColor,
          width: 1,
        ),
      );
      if (widget.activeIndex == widget.index && !widget.readOnly) {
        simpleDecoration = BoxDecoration(
          color: simpleStepsIconColor,
          shape: BoxShape.circle,
        );
      }
      iconWidgetDecoration = simpleDecoration;
    }
    if(widget.textDirection == TDStepsDirection.horizontal){
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Opacity(
                opacity: widget.index == 0 ? 0 : 1,
                child: SizedBox(
                  height: iconContainerSize.toDouble(),
                  child: Center(child: Container(
                      width: double.infinity,
                      height: 1,
                      color: (widget.activeIndex >= widget.index || widget.readOnly) ? TDTheme.of(context).brandColor7 : TDTheme.of(context).grayColor4
                  )),
                ),
              ),
            ),
            Container(
              width: iconContainerSize.toDouble(),
              height: iconContainerSize.toDouble(),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 8, right: 8),
              decoration: iconWidgetDecoration,
              child: stepsIconWidget,
            ),
            Wrap(direction:Axis.vertical, children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                alignment: Alignment.center,
                child: TDText(
                  widget.data.title,
                  style: TextStyle(
                    fontWeight: (widget.activeIndex == widget.index && !widget.readOnly)  ? FontWeight.w600 : FontWeight.w400,
                    color: stepsTitleColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                alignment: Alignment.center,
                child: TDText(
                  widget.data.content,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: TDTheme.of(context).fontGyColor3,
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            Expanded(
              flex: 1,
              child: Opacity(
                opacity: widget.index == widget.stepsCount - 1 ? 0 : 1,
                child: SizedBox(
                  height: iconContainerSize.toDouble(),
                  child: Center(child: Container(
                    width: double.infinity,
                    height: 1,
                    color: (widget.activeIndex > widget.index || widget.readOnly) ? TDTheme.of(context).brandColor7 : TDTheme.of(context).grayColor4,
                  )),
                ),
              ),
            ),
          ],
        );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Opacity(
                opacity: widget.index == 0 ? 0 : 1,
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: (widget.activeIndex >= widget.index || widget.readOnly) ? TDTheme.of(context).brandColor7 : TDTheme.of(context).grayColor4
                ),
              ),
            ),
            Container(
              width: iconContainerSize.toDouble(),
              height: iconContainerSize.toDouble(),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 8, right: 8),
              decoration: iconWidgetDecoration,
              child: stepsIconWidget,
            ),
            Expanded(
              flex: 1,
              child: Opacity(
                opacity: widget.index == widget.stepsCount - 1 ? 0 : 1,
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: (widget.activeIndex > widget.index || widget.readOnly) ? TDTheme.of(context).brandColor7 : TDTheme.of(context).grayColor4,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          alignment: Alignment.center,

          child: TDText(
            widget.data.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: (widget.activeIndex == widget.index && !widget.readOnly)  ? FontWeight.w600 : FontWeight.w400,
              color: stepsTitleColor,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          child: TDText(
            widget.data.content,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: TDTheme.of(context).fontGyColor3,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

