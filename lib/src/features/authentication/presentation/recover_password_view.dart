import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../core/error_handling/logger.dart';
import '../../core/error_handling/snackbar_controller.dart';
import '../domain/auth_controller.dart';

class RecoverPasswordView extends ConsumerStatefulWidget {
  const RecoverPasswordView({super.key});

  @override
  RecoverPasswordViewState createState() => RecoverPasswordViewState();
}

class RecoverPasswordViewState extends ConsumerState<RecoverPasswordView> {
  late bool isFieldsEnabled;
  late final TextEditingController _emailController;
  late final Logger _logger;

  @override
  void initState() {
    super.initState();
    isFieldsEnabled = true;
    _emailController = TextEditingController();
    _logger = getLogger(RecoverPasswordView);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    snackbarDisplayer(context, ref);
    _logger.d('build');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text(
              AppLocalizations.of(context)!.recoverPassword,
              style: const TextStyle(fontSize: 46),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Consumer(
              builder: (
                final BuildContext context,
                final WidgetRef ref,
                final Widget? child,
              ) {
                return TextField(
                  controller: _emailController,
                  enabled: isFieldsEnabled,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterEmail,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 26,
            ),
            Consumer(
              builder: (
                final BuildContext context,
                final WidgetRef ref,
                final Widget? child,
              ) =>
                  ElevatedButton(
                onPressed: () async {
                  bool? success;
                  setState(() {
                    isFieldsEnabled = false;
                  });
                  if (_emailController.text.isNotEmpty) {
                    success = await ref
                        .read(authControllerProvider)
                        .recoverPassword(_emailController.text);
                  }
                  setState(() {
                    isFieldsEnabled = true;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (success != null && success == true && context.mounted) {
                    context.go('/signin');
                  }
                },
                child: child,
              ),
              child: Text(AppLocalizations.of(context)!.recoverPassword),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {
                context.go('/signin');
              },
              child: Text(
                AppLocalizations.of(context)!.signIn,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
