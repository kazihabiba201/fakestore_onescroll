import 'package:flutter/material.dart';

class CustomTextFormField extends FormField<String> {
  final TextEditingController? controller;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool enabled;
  final Function(String)? onChanged;

  CustomTextFormField({
    super.key,
    this.controller,
    super.initialValue,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.suffixIcon,
    this.enabled = true,
    this.onChanged,
  }) : super(
          builder: (FormFieldState<String> state) {
            return _CustomTextFormFieldInternal(
              state: state,
              controller: controller,
              maxLength: maxLength,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              obscureText: obscureText,
              suffixIcon: suffixIcon,
              enabled: enabled,
              onChanged: onChanged,
            );
          },
        );
}

class _CustomTextFormFieldInternal extends StatefulWidget {
  final FormFieldState<String> state;
  final TextEditingController? controller;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool enabled;
  final Function(String)? onChanged;

  const _CustomTextFormFieldInternal({
    required this.state,
    this.controller,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.suffixIcon,
    this.enabled = true,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFormFieldInternalState();
}

class _CustomTextFormFieldInternalState extends State<_CustomTextFormFieldInternal> {
  late final TextEditingController _internalController;

  @override
  void initState() {
    super.initState();

    _internalController = widget.controller ?? TextEditingController(text: widget.state.value);

    _internalController.addListener(() {
      widget.state.didChange(_internalController.text);
      if (widget.onChanged != null) widget.onChanged!(_internalController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: widget.state.hasError ? Colors.red : Colors.transparent,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            controller: _internalController,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            enabled: widget.enabled,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ),
        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              widget.state.errorText!,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }
}
