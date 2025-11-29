import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/bloc/locale/locale_cubit.dart';
import 'package:frontend/core/bloc/locale/locale_state.dart';

class LanguageSwitcher extends StatelessWidget {
  final Color? iconColor;

  const LanguageSwitcher({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return PopupMenuButton<Locale>(
          icon: Icon(Icons.language, color: iconColor ?? Colors.black),
          onSelected: (Locale locale) {
            context.read<LocaleCubit>().changeLocale(locale);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
            const PopupMenuItem<Locale>(
              value: Locale('en'),
              child: Text('English'),
            ),
            const PopupMenuItem<Locale>(
              value: Locale('ar'),
              child: Text('العربية'),
            ),
            const PopupMenuItem<Locale>(
              value: Locale('es'),
              child: Text('Español'),
            ),
          ],
        );
      },
    );
  }
}
