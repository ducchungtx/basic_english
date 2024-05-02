import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_english/blocs/theme/theme_bloc.dart';
import 'package:basic_english/blocs/theme/theme_state.dart';
import 'package:basic_english/constants/color_constants.dart';
import 'package:basic_english/generated/locale_keys.g.dart';
import 'package:basic_english/views/auth/login/login_view.dart';

class PushToLoginButton extends StatelessWidget {
  const PushToLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (context) => const LoginView(),
              ),
              (route) => false,
            );
          },
          child: Text(
            LocaleKeys.login,
            style: TextStyle(
              color: themeState.isDark
                  ? ColorConstants.darkPrimaryIcon
                  : ColorConstants.lightPrimaryIcon,
            ),
          ).tr(),
        );
      },
    );
  }
}
