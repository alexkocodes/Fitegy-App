import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'challenge_card_model.dart';
export 'challenge_card_model.dart';

class ChallengeCardWidget extends StatefulWidget {
  const ChallengeCardWidget({
    Key? key,
    this.title,
    this.time,
    this.details,
    this.comments,
    this.id,
    this.color,
    this.documentId,
  }) : super(key: key);

  final String? title;
  final DateTime? time;
  final String? details;
  final String? comments;
  final String? id;
  final int? color;
  final DocumentReference? documentId;

  @override
  _ChallengeCardWidgetState createState() => _ChallengeCardWidgetState();
}

class _ChallengeCardWidgetState extends State<ChallengeCardWidget>
    with TickerProviderStateMixin {
  late ChallengeCardModel _model;

  final animationsMap = {
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 260.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(0.8, 0.8),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 600.ms,
          begin: Offset(0.8, 0.8),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChallengeCardModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
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
              'challengeReference': serializeParam(
                widget.documentId,
                ParamType.DocumentReference,
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
                blurRadius: 12.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 5.0),
              )
            ],
            gradient: LinearGradient(
              colors: [Color(0xFFE6A0FF), Color(0xFF9AE1FF)],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(-0.34, -1.0),
              end: AlignmentDirectional(0.34, 1.0),
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
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
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Archivo Black',
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                      child: Text(
                        dateTimeFormat('yMMMd', widget.time),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ).animateOnActionTrigger(
        animationsMap['containerOnActionTriggerAnimation']!,
      ),
    );
  }
}
