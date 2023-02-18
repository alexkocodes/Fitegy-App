import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogSignModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;
  // State field(s) for LogInEmail widget.
  TextEditingController? logInEmailController;
  String? Function(BuildContext, String?)? logInEmailControllerValidator;
  // State field(s) for LogInPass widget.
  TextEditingController? logInPassController;
  late bool logInPassVisibility;
  String? Function(BuildContext, String?)? logInPassControllerValidator;
  // State field(s) for first_name widget.
  TextEditingController? firstNameController;
  String? Function(BuildContext, String?)? firstNameControllerValidator;
  // State field(s) for last_name widget.
  TextEditingController? lastNameController;
  String? Function(BuildContext, String?)? lastNameControllerValidator;
  // State field(s) for NewEmail widget.
  TextEditingController? newEmailController;
  String? Function(BuildContext, String?)? newEmailControllerValidator;
  // State field(s) for NewPass widget.
  TextEditingController? newPassController;
  late bool newPassVisibility;
  String? Function(BuildContext, String?)? newPassControllerValidator;
  // State field(s) for ConfirmPass widget.
  TextEditingController? confirmPassController;
  late bool confirmPassVisibility;
  String? Function(BuildContext, String?)? confirmPassControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    logInPassVisibility = false;
    newPassVisibility = false;
    confirmPassVisibility = false;
  }

  void dispose() {
    logInEmailController?.dispose();
    logInPassController?.dispose();
    firstNameController?.dispose();
    lastNameController?.dispose();
    newEmailController?.dispose();
    newPassController?.dispose();
    confirmPassController?.dispose();
    textController4?.dispose();
  }

  /// Additional helper methods are added here.

}
