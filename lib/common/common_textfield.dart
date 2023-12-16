import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogging_app/constant/text_style.dart';
import 'package:jogging_app/extensions/string_extension.dart';

import '../constant/spaces.dart';

const kColorFillTextField = Color(0xFFFEF1F2);
const kColorBackgroundBlur = Color.fromRGBO(0, 0, 0, 0.4);
const kColorBackgroundBlack1 = Color(0xFF6F6F70);
const String kObscuringPasswordCharacter = "*";

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.title,
    this.initText,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onFocusChange,
    this.textStyle,
    this.hintStyle,
    this.isPasswordField = false,
    this.enabledBorderColor = Colors.transparent,
    this.focusedBorderColor,
    this.backgroundColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.onValueChanged,
    this.onValidate,
    this.readOnly = false,
    this.errorText,
    this.autofocus = false,
    this.maxLength,
    this.inputFormatters,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.showValidCheckIcon = false,
    this.enableCheckValid = false,
    this.onTap,
    this.onSubmitted,
    this.borderRadius = 20,
    this.titleStyle,
    this.isNotChangeBorder = false,
    this.denyCopyMethod = false,
    this.denyCutMethod = false,
    this.denyPasteMethod = false,
    this.hasError = false,
    this.isDense = false,
    this.contentPadding,
    this.useShadow = true,
    this.height,
    this.minLines,
    this.maxLines,
  });

  final bool useShadow;
  final String? title;
  final String? initText;
  final String? hintText;
  final String? errorText;

  final bool isPasswordField;
  final bool readOnly;
  final bool autofocus;
  final bool showValidCheckIcon;
  final bool isNotChangeBorder;

  /// Enable data validation for the field
  final bool enableCheckValid;

  /// Data is valid -> automatically show the suffix icon
  /// Data is invalid -> action by default

  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double borderRadius;
  final double? height;

  final Color enabledBorderColor;
  final Color? focusedBorderColor;
  final Color backgroundColor;

  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<String>? onValueChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final bool denyCopyMethod;
  final bool denyCutMethod;
  final bool denyPasteMethod;
  final bool hasError;

  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;

  /// Callback when text has been changed
  final String? Function(String? value)? onValidate;

  @override
  State<InputField> createState() => _NewInputFieldState();
}

class _NewInputFieldState extends State<InputField> {
  late TextEditingController _textController;
  late FocusNode _focusNode;
  late bool _showValidCheckIcon;
  late Color _backgroundColor;
  late int _currentLength;

  late bool _isCheckEmptyFirstTime;

  String? _errorText;
  bool _showPassword = false;

  /// After the first use, the value will [always be false]
  bool _useBackgroundColorWhenDataValid = false;

  @override
  void initState() {
    super.initState();

    _textController = widget.controller ??
        TextEditingController(
          text: widget.initText,
        );

    _focusNode = widget.focusNode ?? FocusNode();

    _errorText = widget.errorText;

    _showValidCheckIcon = widget.showValidCheckIcon;
    _useBackgroundColorWhenDataValid = widget.showValidCheckIcon;
    _backgroundColor = _useBackgroundColorWhenDataValid
        ? kColorFillTextField
        : widget.backgroundColor;

    // check valid
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _textController.text.isNotEmpty) {
        setState(() {
          _backgroundColor = kColorFillTextField;
        });
      } else {
        setState(() {
          _backgroundColor = widget.backgroundColor;
        });
      }

      _useBackgroundColorWhenDataValid = false;

      if (!widget.enableCheckValid) {
        return;
      }

      if (_focusNode.hasFocus) {
        setState(() {
          _errorText = null;

          if (!_showValidCheckIcon) {
            _showValidCheckIcon = true;
          }
        });
      }
      //
      else {
        setState(() {
          _errorText =
              widget.onValidate?.call(_textController.text) ?? widget.errorText;
        });
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _textController.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  double get _getHeight => widget.height ?? 48;

  bool get _getObscureText {
    return widget.isPasswordField && !_showPassword;
  }

  int? get _getMaxLines {
    return _getObscureText ? 1 : widget.maxLines;
  }

  bool get _showCounter => widget.maxLength != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotNullAndNotEmpty) _buildTitle(widget.title ?? ''),
        if (widget.title.isNotNullAndNotEmpty) kVerticalSpace8,
        _buildTextField(),
        if (_errorText.isNotNullAndNotEmpty) kVerticalSpace6,
        if (_errorText.isNotNullAndNotEmpty) _buildError(_errorText ?? ''),
      ],
    );
  }

  Widget _buildError(String errorMsg) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        errorMsg,
        textAlign: TextAlign.right,
        style: AppStyles.caption12RegularItalic(
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: widget.titleStyle ??
            AppStyles.caption12Semibold(color: kColorBackgroundBlur),
      ),
    );
  }

  Widget _buildTextField() {
    return Focus(
      child: Container(
        height: _getHeight,
        decoration: BoxDecoration(
          boxShadow: widget.useShadow
              ? [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 8,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.3),
                  )
                ]
              : null,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: TextField(
          controller: _textController,
          focusNode: _focusNode,
          style: widget.textStyle ??
              AppStyles.button01(
                color: kColorBackgroundBlack1,
              ),
          obscureText: _getObscureText,
          obscuringCharacter: kObscuringPasswordCharacter,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: _getHeight),
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(12),
            hintText: widget.hintText,
            isDense: widget.isDense,
            hintStyle: widget.hintStyle ??
                AppStyles.caption12Regular(
                  color: kColorBackgroundBlur,
                ),
            enabledBorder: _enabledBorder(),
            focusedBorder: _focusedBorder(),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: _buildPrefixIcon(),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 24,
            ),
            suffixIcon: _buildSuffixIcon(),
            counterText: '',
          ),
          onChanged: (String value) {
            widget.onValueChanged?.call(value);
            _isCheckEmptyFirstTime = false;
            if (_showCounter) {
              setState(() {
                _currentLength = _textController.text.length;
              });
            }
          },
          onTapOutside: (PointerDownEvent event) {
            _focusNode.unfocus();
          },
          onTap: widget.onTap,
          onSubmitted: widget.onSubmitted,
          autofocus: widget.autofocus,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: _getMaxLines,
          inputFormatters: widget.inputFormatters,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  InputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(
        width: 1,
        color: widget.focusedBorderColor ?? Colors.white,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    );
  }

  InputBorder _enabledBorder() {
    Color borderColor = widget.enabledBorderColor;
    if (widget.enableCheckValid && !_focusNode.hasFocus) {
      borderColor = _errorText == null ? Colors.transparent : Colors.white;
    }
    if (widget.isNotChangeBorder && (_errorText == null || _errorText == '')) {
      borderColor = widget.enabledBorderColor;
    }
    if (widget.hasError) {
      borderColor = Colors.white;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    );
  }

  Widget? _buildPrefixIcon() {
    return widget.prefixIcon != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: widget.prefixIcon,
          )
        : null;
  }

  Widget? _buildSuffixIcon() {
    return widget.suffixIcon != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: widget.suffixIcon,
          )
        : null;
  }
}
