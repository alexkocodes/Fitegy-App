import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengeCardWidget extends StatefulWidget {
  const ChallengeCardWidget({
    Key? key,
    this.title,
    this.time,
    this.details,
    this.comments,
    this.id,
    this.color,
  }) : super(key: key);

  final String? title;
  final DateTime? time;
  final String? details;
  final String? comments;
  final String? id;
  final int? color;

  @override
  _ChallengeCardWidgetState createState() => _ChallengeCardWidgetState();
}

class _ChallengeCardWidgetState extends State<ChallengeCardWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: InkWell(
        onTap: () async {
          context.pushNamed(
            'ChallengeDetails',
            queryParams: {
              'title': serializeParam(
                widget.title,
                ParamType.String,
              ),
              'time': serializeParam(
                widget.time,
                ParamType.DateTime,
              ),
              'details': serializeParam(
                widget.details,
                ParamType.String,
              ),
              'comments': serializeParam(
                widget.comments,
                ParamType.String,
              ),
              'id': serializeParam(
                widget.id,
                ParamType.String,
              ),
              'color': serializeParam(
                widget.color,
                ParamType.int,
              ),
            }.withoutNulls,
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: Color(0x33000000),
                offset: Offset(0, 5),
              )
            ],
            gradient: LinearGradient(
              colors: [Color(0xFFE6A0FF), Color(0xFF9AE1FF)],
              stops: [0, 1],
              begin: AlignmentDirectional(-0.34, -1),
              end: AlignmentDirectional(0.34, 1),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title!,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Archivo Black',
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: Text(
                        dateTimeFormat('yMMMd', widget.time),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyText1Family,
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/Hole.png',
                      width: 15,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
    );
  }
}
