import 'package:flutter/material.dart';

import '../../widgets/debouncer.dart';

class UsernameField extends StatelessWidget {
  UsernameField({
    super.key,
    required this.callback,
  });

  final Debouncer _debouncer = Debouncer(
    delay: const Duration(seconds: 1),
  );
  final Function(String) callback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Username',
        fillColor: Colors.white,
        focusColor: Colors.white,
        border: UnderlineInputBorder(),
        filled: true,
      ),
      onChanged: (value) {
        _debouncer.run(() {
          if (value.isNotEmpty) {
            callback.call(value);
          }
        });
      },
    );
  }
}
