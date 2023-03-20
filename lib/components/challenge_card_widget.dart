import 'package:flutter/services.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengeCardWidget extends StatefulWidget {
  ChallengeCardWidget({
    Key? key,
    this.title,
    this.time,
    this.details,
    this.comments,
    this.path,
    this.color,
    this.index,
    this.destination,
    this.callback,
    this.showCheck,
    this.document_id,
  }) : super(key: key);

  final String? title;
  final DateTime? time;
  final String? details;
  final String? comments;
  final String? path;
  final int? color;
  final int? index;
  final String? destination;
  final Function? callback;
  final bool? showCheck;
  final String? document_id;

  @override
  _ChallengeCardWidgetState createState() => _ChallengeCardWidgetState();
}

class _ChallengeCardWidgetState extends State<ChallengeCardWidget>
    with TickerProviderStateMixin {
  Animation<double>? _scale;
  AnimationController? _controller;

  final colorSchemes = [
    [Color.fromARGB(255, 154, 225, 255), Color.fromARGB(255, 253, 255, 155)],
    [Color.fromARGB(255, 89, 205, 114), Color.fromARGB(255, 253, 255, 155)],
    [Color.fromARGB(255, 255, 116, 116), Color.fromARGB(255, 253, 255, 155)],
    [Color.fromARGB(255, 255, 89, 200), Color.fromARGB(255, 253, 255, 155)],
    [Color(0xFFE6A0FF), Color(0xFF9AE1FF)],
  ];
  var animationsMap = {
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ShakeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          hz: 4,
          offset: Offset(0, 0),
          rotation: 0.087,
        ),
      ],
    ),
  };
  static var animationDelay;

  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.9)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.ease));
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.index! % 6) {
      case 0:
        animationDelay = 100;
        break;
      case 1:
        animationDelay = 200;
        break;
      case 2:
        animationDelay = 300;
        break;
      case 3:
        animationDelay = 400;
        break;
      case 4:
        animationDelay = 500;
        break;
      case 5:
        animationDelay = 600;
        break;
      default:
    }

    animationsMap['containerOnPageLoadAnimation'] = AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: Duration(milliseconds: animationDelay),
          duration: 600.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: Duration(milliseconds: animationDelay),
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
      ],
    );
    var index = -1;
    var path = "";
    var title;
    var time;
    var color;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(18, 0, 15, 20),
      child: InkWell(
        onTap: () async {
          if (widget.destination == "challenge details") {
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
                'path': serializeParam(
                  widget.path,
                  ParamType.String,
                ),
                'color': serializeParam(
                  widget.color,
                  ParamType.int,
                ),
              }.withoutNulls,
            );
          } else {
            setState(() {
              if (widget.showCheck!) {
                index = -1;
              }
              index = widget.index!;
              path = widget.path!;
              title = widget.title;
              time = widget.time;
              color = widget.color;
              widget.callback!(
                index,
                path,
                title,
                time,
                color,
              );
            });
          }
        },
        onLongPress: () async {
          HapticFeedback.lightImpact();
          if (animationsMap['containerOnActionTriggerAnimation'] != null) {
            await animationsMap['containerOnActionTriggerAnimation']!
                .controller
                .forward(from: 0.0);
          }
          if (widget.destination == "select") {
            context.pushNamed(
              "ChallengeDetails",
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
                'path': serializeParam(
                  widget.path,
                  ParamType.String,
                ),
                'color': serializeParam(
                  widget.color,
                  ParamType.int,
                ),
                'type': serializeParam(
                  widget.destination,
                  ParamType.String,
                ),
              }.withoutNulls,
            );
          }
        },
        child: Listener(
          onPointerUp: (event) {
            _controller!.reverse();
          },
          onPointerDown: (event) {
            _controller!.forward();
          },
          child: ScaleTransition(
            scale: _scale!,
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
                  colors: colorSchemes[widget.color! - 1],
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
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Archivo Black',
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText1Family),
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            dateTimeFormat('yMMMd', widget.time),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyText1Family,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyText1Family),
                                ),
                          ),
                        ),
                      ],
                    ),
                    widget.destination == "select"
                        ? Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                widget.showCheck!
                                    ? 'assets/images/check.png'
                                    : 'assets/images/Hole.png',
                                width: 15,
                                fit: BoxFit.cover,
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
          .animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!)
          .animateOnActionTrigger(
              animationsMap['containerOnActionTriggerAnimation']!),
    );
  }
}
