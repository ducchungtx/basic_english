import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_english/blocs/auth/login/login_bloc.dart';
import 'package:basic_english/blocs/auth/login/login_event.dart';
import 'package:basic_english/blocs/auth/login/login_state.dart';
import 'package:basic_english/blocs/auth/register/register_bloc.dart';
import 'package:basic_english/blocs/auth/register/register_event.dart';
import 'package:basic_english/blocs/profile/profile_bloc.dart';
import 'package:basic_english/blocs/profile/profile_event.dart';
import 'package:basic_english/constants/app_constants.dart';
import 'package:basic_english/generated/locale_keys.g.dart';
import 'package:basic_english/helpers/app_helper.dart';
import 'package:basic_english/models/user_model.dart';
import 'package:basic_english/services/user_service.dart';
import 'package:basic_english/views/auth/login/login_view.dart';
import 'package:basic_english/views/navigation/navigation_view.dart';
import 'package:basic_english/views/profile/profile_view.dart';
part "splash_view_mixin.dart";

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    return CupertinoPageScaffold(
      child: FutureBuilder(
        future: _future(context),
        builder: (context, snapshot) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (snapshot.hasData) {
                _listener(state,
                    loginBloc: loginBloc,
                    profileBloc: profileBloc,
                    registerBloc: registerBloc);
              }
            },
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
      ),
    );
  }
}
