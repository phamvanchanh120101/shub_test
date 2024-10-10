import 'package:flutter/material.dart';

class TextFieldBase extends StatelessWidget {
  final String lableText;
  final Widget? suffixIcon;
  final bool readOnly;
  final String? hintText;
  final String? errorText;
  final Function(String?)? onChanged;
  final Function()? onTap;

  const TextFieldBase({
    super.key,
    required this.lableText,
    this.suffixIcon,
    this.readOnly = false,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(lableText),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              onTap: onTap,
                              readOnly: readOnly,
                              decoration: InputDecoration(
                                hintText: hintText,
                                contentPadding:
                                    const EdgeInsets.only(bottom: 15),
                                border: InputBorder.none,
                              ),
                              onChanged: onChanged,
                            ),
                          ),
                        ],
                      ),
                    ),
                    suffixIcon ?? const SizedBox.shrink(),
                  ],
                ),
              ),
              if (errorText != null)
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
