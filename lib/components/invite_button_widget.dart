import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InviteButtonWidget extends StatefulWidget {
  const InviteButtonWidget({Key? key}) : super(key: key);

  @override
  _InviteButtonWidgetState createState() => _InviteButtonWidgetState();
}

class _InviteButtonWidgetState extends State<InviteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        print('Button pressed ...');
      },
      text: 'Invite 🔥',
      options: FFButtonOptions(
        width: 110,
        height: 40,
        color: FlutterFlowTheme.of(context).customColor4,
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
