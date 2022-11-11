import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengeActionBarWidget extends StatefulWidget {
  const ChallengeActionBarWidget({Key? key}) : super(key: key);

  @override
  _ChallengeActionBarWidgetState createState() =>
      _ChallengeActionBarWidgetState();
}

class _ChallengeActionBarWidgetState extends State<ChallengeActionBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 32),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x411D2429),
              offset: Offset(0, -2),
            )
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 44),
          child: Text(
            'Button Text',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).title2.override(
                  fontFamily: FlutterFlowTheme.of(context).title2Family,
                  color: Colors.white,
                  useGoogleFonts: GoogleFonts.asMap()
                      .containsKey(FlutterFlowTheme.of(context).title2Family),
                ),
          ),
        ),
      ),
    );
  }
}
