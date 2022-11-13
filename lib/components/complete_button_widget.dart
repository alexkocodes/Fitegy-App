import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteButtonWidget extends StatefulWidget {
  const CompleteButtonWidget({
    Key? key,
    this.challengeReference,
  }) : super(key: key);

  final DocumentReference? challengeReference;

  @override
  _CompleteButtonWidgetState createState() => _CompleteButtonWidgetState();
}

class _CompleteButtonWidgetState extends State<CompleteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        final challengesUpdateData = createChallengesRecordData(
          status: 'completed',
        );
        await widget.challengeReference!.update(challengesUpdateData);

        context.goNamed(
          'ChallengeCompleted',
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 300),
            ),
          },
        );
      },
      text: 'Complete',
      options: FFButtonOptions(
        width: 110,
        height: 40,
        color: Color(0xFF59CD72),
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'Archivo Black',
              color: Colors.white,
              useGoogleFonts: GoogleFonts.asMap()
                  .containsKey(FlutterFlowTheme.of(context).subtitle2Family),
            ),
        elevation: 10,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
