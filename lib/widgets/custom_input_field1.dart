import 'dart:async';

import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomInputField1 extends StatefulWidget {
  final String? hint;
  final String? label;
  final bool? isPasswordField;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Function(String? value)? onChange;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefix;
  final int? limit;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? readOnly;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final String? text;
  final Color? counterColor;
  final bool? showCounter;
  final bool? showBorder;
  final bool? isDense;
  final Key? key;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? margin;
  final String? Function(String?)? validator;
  final Future<String?> Function(String?)? asyncValidator;
  final Widget? suffix;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorderType1? borderType;

  CustomInputField1(
      {this.hint,
      this.isPasswordField,
      this.onChange,
      this.keyboardType,
      this.prefix,
      this.contentPadding,
      this.limit,
      this.controller,
      this.onTap,
      this.readOnly,
      this.fillColor,
      this.maxLines,
      this.text,
      this.showCounter,
      this.counterColor,
      this.showBorder,
      this.minLines,
      this.margin,
      this.suffix,
      this.validator,
      this.isDense,
      this.onFieldSubmitted,
      this.asyncValidator,
      this.label,
      this.key,
      this.textStyle,
      this.border,
      this.enabledBorder,
      this.borderType,
      this.focusNode,
      this.focusedBorder,
      this.hintStyle})
      : super(key: key);

  final _state = _CustomInputField1State();

  @override
  _CustomInputField1State createState() {
    return _state;
  }

  Future<void> validate() async {
    if (asyncValidator != null) {
      await _state.validate();
    }
  }
}

enum InputBorderType1 { outline, underline }

class _CustomInputField1State extends State<CustomInputField1> {
  late bool _isHidden;
  String text = "";
  bool isPasswordField = false;

  @override
  void initState() {
    isPasswordField = widget.isPasswordField ?? false;
    _isHidden = isPasswordField;
    errorMessage = null;
    if (widget.validator != null && widget.asyncValidator != null) {
      throw "validator and asyncValidator are not allowed at same time";
    }

    if (widget.controller != null && widget.text != null) {
      widget.controller!.text = widget.text!;
    }

    super.initState();
  }

  var isValidating = false;
  var isValid = false;
  var isDirty = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLength: widget.limit,
        key: widget.key,
        onChanged: widget.asyncValidator == null
            ? widget.onChange
            : (value) {
                text = value.toString();
                validateValue(text);
                if (widget.onChange != null) {
                  widget.onChange!(text);
                }
              },
        style: widget.textStyle,
        obscureText: _isHidden,
        onTap: widget.onTap,
        validator: widget.validator ??
            (widget.asyncValidator != null
                ? (value) {
                    text = value.toString();
                    return errorMessage;
                  }
                : null),
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines,
        readOnly: widget.readOnly ?? false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        initialValue: widget.controller == null ? widget.text : null,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: widget.focusNode,
        enabled: widget.keyboardType != TextInputType.none,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        buildCounter: (_,
            {required currentLength, maxLength, required isFocused}) {
          return Visibility(
            visible: widget.showCounter ?? false,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  currentLength.toString() +
                      (widget.limit != null ? "/" + maxLength.toString() : ""),
                  style: TextStyle(color: widget.counterColor),
                ),
              ),
            ),
          );
        },
        // decoration: InputDecoration(
        //   suffixIcon: IconButton(
        //     onPressed: () {
        //       visible = !visible;
        //     },
        //     icon: visible == false
        //         ? Icon(Icons.visibility)
        //         : Icon(Icons.visibility_off),
        //   ),
        //   hintText: '.......',
        //   hintStyle: TextStyle(
        //       fontFamily: 'DMSansR',
        //       color: Color(0xff000000),
        //       fontSize: 20.sp,
        //       fontWeight: FontWeight.w400),
        //   contentPadding: EdgeInsets.only(left: 5),
        //   border: InputBorder.none,
        //   focusedBorder: InputBorder.none,
        //   enabledBorder: InputBorder.none,
        //   errorBorder: InputBorder.none,
        //   disabledBorder: InputBorder.none,
        // ),
        decoration: InputDecoration(
            hintStyle: widget.hintStyle,
            // contentPadding: EdgeInsets.only(left: 10),
            prefixIcon: widget.prefix,
            hintText: widget.hint,

            labelText: widget.label,
            isDense: widget.isDense,
            fillColor: widget.fillColor ?? /*Color(0xFFECECEC)*/
                Colors.transparent,
            filled: widget.fillColor != null,
            suffixIconConstraints: BoxConstraints(minWidth: 50.sp),
            suffixIcon: widget.suffix ??
                (isPasswordField
                    ? IconButton(
                        onPressed: () {
                          if (isPasswordField) {
                            if (mounted) {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            }
                          }
                        },
                        icon: Visibility(
                          visible: isPasswordField,
                          child: Icon(
                            isPasswordField
                                ? (_isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off)
                                : null,
                          ),
                        ),
                      )
                    : (widget.asyncValidator != null
                        ? _getSuffixIcon()
                        : null)),
            // hintStyle: TextStyle(color: hintColor),
            contentPadding:widget.contentPadding?? EdgeInsets.zero,

            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: widget.border ??
                ((widget.showBorder != null && widget.showBorder == false)
                    ? InputBorder.none
                    : widget.borderType != null
                        ? (widget.borderType == InputBorderType1.outline
                            ? OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: hintColor),
                              )
                            : UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: hintColor, width: 1)))
                        : null),
            enabledBorder: widget.enabledBorder ??
                ((widget.showBorder != null && widget.showBorder == false)
                    ? InputBorder.none
                    : widget.borderType != null
                        ? (widget.borderType == InputBorderType1.outline
                            ? OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: hintColor),
                              )
                            : UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: hintColor),
                              ))
                        : null),
            focusedBorder: widget.enabledBorder ??
                ((widget.showBorder != null && widget.showBorder == false)
                    ? InputBorder.none
                    : widget.borderType != null
                        ? (widget.borderType == InputBorderType1.outline
                            ? OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: hintColor),
                              )
                            : UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: hintColor),
                              ))
                        : null)
            // filled: true,
            // fillColor: Color(0xF0BBBBBB),
            ),
      ),
    );
  }

  Widget _getSuffixIcon() {
    if (isValidating) {
      return Transform.scale(scale: 0.7, child: CupertinoActivityIndicator());
    } else {
      if (!isValid && isDirty) {
        return Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid) {
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return SizedBox(
          height: 1,
          width: 1,
        );
      }
    }
  }

  Future<void> validateValue(String newValue) async {
    isDirty = true;
    if (text.isEmpty) {
      if (mounted) {
        setState(() {
          isValid = false;
        });
      }
      return;
    }
    isValidating = true;
    if (mounted) {
      setState(() {});
    }
    errorMessage = await widget.asyncValidator!(newValue);
    isValidating = false;
    isValid = errorMessage == null;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> validate() async {
    await validateValue(text);
  }
}
