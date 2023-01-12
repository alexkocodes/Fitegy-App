import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostActionBarWidget extends StatefulWidget {
  const PostActionBarWidget({
    Key? key,
    this.likeCount,
  }) : super(key: key);

  final int? likeCount;

  @override
  _PostActionBarWidgetState createState() => _PostActionBarWidgetState();
}

class _PostActionBarWidgetState extends State<PostActionBarWidget> {
  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.07, 0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 0,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.favorite_border_rounded,
                      color: Color(0xFFCFCFCF),
                      size: 20,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.45, -0.12),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      valueOrDefault<String>(
                        widget.likeCount?.toString(),
                        '0',
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyText1Family,
                            color: Color(0xFFCFCFCF),
                            fontSize: 13,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.09, 0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 0,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.mode_comment_outlined,
                      color: Color(0xFFCFCFCF),
                      size: 18,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.8, 0.52),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      'Comments',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyText1Family,
                            color: Color(0xFFCFCFCF),
                            fontSize: 13,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.8, 0.1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      'See Challenge',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyText1Family,
                            color: Color(0xFFCFCFCF),
                            fontSize: 13,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.09, -1.59),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 0,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.local_fire_department_outlined,
                      color: Color(0xFFCFCFCF),
                      size: 20,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
