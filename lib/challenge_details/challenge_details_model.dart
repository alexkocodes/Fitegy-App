import '/components/complete_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChallengeDetailsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for CompleteButton component.
  late CompleteButtonModel completeButtonModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    completeButtonModel = createModel(context, () => CompleteButtonModel());
  }

  void dispose() {
    completeButtonModel.dispose();
  }

  /// Additional helper methods are added here.

}
