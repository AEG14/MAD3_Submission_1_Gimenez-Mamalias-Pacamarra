import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WaitingDialog extends StatelessWidget {
  static Future<T?> show<T>(BuildContext context,
      {required Future<T> future, String? prompt, Color? color}) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dCon) {
          return WaitingDialog(prompt: prompt, color: color);
        },
      );

      T result = await future;

      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      return result;
    } catch (e, st) {
      print(e);
      print(st);
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();

        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Login Failed',
            message: 'User does not exist or password does not match!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      return null;
    }
  }

  final String? prompt;
  final Color? color;

  const WaitingDialog({Key? key, this.prompt, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: color ?? Colors.white,
              size: 40,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              prompt ?? "Please wait . . .",
              style: TextStyle(color: color ?? Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
