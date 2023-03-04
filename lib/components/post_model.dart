import '/auth/auth_util.dart';
import '/components/post_action_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // Model for PostActionBar component.
  late PostActionBarModel postActionBarModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    postActionBarModel = createModel(context, () => PostActionBarModel());
  }

  void dispose() {
    postActionBarModel.dispose();
  }

  /// Additional helper methods are added here.

}
