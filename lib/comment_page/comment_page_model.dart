import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/comment_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class CommentPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for ListView widget.
  PagingController<DocumentSnapshot?, CommentsRecord>? pagingController;
  Query? pagingQuery;
  List<StreamSubscription?> streamSubscriptions = [];

  // State field(s) for commentBox widget.
  TextEditingController? commentBoxController;
  String? Function(BuildContext, String?)? commentBoxControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    streamSubscriptions.forEach((s) => s?.cancel());
    commentBoxController?.dispose();
  }

  /// Additional helper methods are added here.

}
