// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';

const Duration _kExpand = Duration(milliseconds: 200);

/// A single-line [ListTile] with a trailing button that expands or collapses
/// the tile to reveal or hide the [children].
///
/// This widget is typically used with [ListView] to create an
/// "expand / collapse" list entry. When used with scrolling widgets like
/// [ListView], a unique [PageStorageKey] must be specified to enable the
/// [ExpansionTile] to save and restore its expanded state when it is scrolled
/// in and out of view.
///
/// See also:
///
///  * [ListTile], useful for creating expansion tile [children] when the
///    expansion tile represents a sublist.
///  * The "Expand/collapse" section of
///    <https://material.io/guidelines/components/lists-controls.html>.
class ExpansionTile extends StatefulWidget {
  /// Creates a single-line [ListTile] with a trailing button that expands or collapses
  /// the tile to reveal or hide the [children]. The [initiallyExpanded] property must
  /// be non-null.
  const ExpansionTile({
    Key? key,
    this.headerBackgroundColor,
    this.leading,
    this.title,
    this.backgroundColor,
    this.iconColor,
    this.isElevation,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  final Widget? leading;

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool>? onExpansionChanged;

  /// The widgets that are displayed when the tile expands.
  ///
  /// Typically [ListTile] widgets.
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color? backgroundColor;

  /// The color to display the background of the header.
  final Color? headerBackgroundColor;

  /// The color to display the icon of the header.
  final Color? iconColor;
  final bool? isElevation;
  /// A widget to display instead of a rotating arrow icon.
  final Widget? trailing;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool? initiallyExpanded;

  @override
  _ExpansionTileState createState() => _ExpansionTileState();
}

class _ExpansionTileState extends State<ExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
  CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
  CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
  Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController? _controller;
  late Animation<double> _iconTurns;
  Animation<double?>? _heightFactor;

  Animation<Color?>? _headerColor;
  Animation<Color?>? _iconColor;
  Animation<Color?>? _backgroundColor;
  bool isElevation =true;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller!.drive(_easeInTween);
    _iconTurns = _controller!.drive(_halfTween.chain(_easeInTween));
    isElevation = widget.isElevation ?? true;
    _headerColor = _controller!.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller!.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller!.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller!.value = 1.0;
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller!.forward();
      } else {
        _controller!.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged!(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color? titleColor = _headerColor!.value;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 0.5, color: ColorsOf().primaryBackGround(),style: BorderStyle.solid),
          color:ColorsOf().backGround(), //_backgroundColor.value ?? Colors.transparent,

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor!.value),
            child: Container(

              decoration: BoxDecoration(
                color: widget.headerBackgroundColor ?? Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black, width: 0,style: BorderStyle.solid),
                boxShadow: (isElevation)?[

                  BoxShadow(
                    color: Color(0x40000000),//.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ]:[],
              ),
              child: ListTile(
                onTap: _handleTap,
                leading: widget.leading,
                title: DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: titleColor),
                  child: widget.title??Container(),
                ),
                trailing: widget.trailing ??
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.expand_more,
                        color: widget.iconColor ?? Colors.grey,
                      ),
                    ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor!.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween..end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.bodyLarge!.color
      ..end = theme.canvasColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.canvasColor;
    _backgroundColorTween..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller!.isDismissed;
    return AnimatedBuilder(
      animation: _controller!.view,
      builder: _buildChildren,
      child: closed ? null : Column( children: widget.children),
    );
  }
}