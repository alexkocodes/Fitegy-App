import '/auth/firebase_auth/auth_util.dart';
import '/components/comment_widget.dart';
import '/components/post_action_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommentPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for PostActionBar component.
  late PostActionBarModel postActionBarModel;
  // Model for Comment component.
  late CommentModel commentModel;
  // State field(s) for commentBox widget.
  TextEditingController? commentBoxController;
  String? Function(BuildContext, String?)? commentBoxControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    postActionBarModel = createModel(context, () => PostActionBarModel());
    commentModel = createModel(context, () => CommentModel());
  }

  void dispose() {
    postActionBarModel.dispose();
    commentModel.dispose();
    commentBoxController?.dispose();
  }

  /// Additional helper methods are added here.

}