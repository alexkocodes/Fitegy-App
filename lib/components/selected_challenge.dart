import 'package:flutter/services.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'challenge_bottom_sheet_widget.dart';

class SelectedChallengeCardWidget extends StatefulWidget {
  SelectedChallengeCardWidget({
    Key? key,
    this.title,
    this.time,
    this.path,
    this.color,
    this.index,
    this.callback,
  }) : super(key: key);

  final String? title;
  final DateTime? time;
  final String? path;
  final int? color;
  final int? index;
  final Function? callback;

  @override
  _SelectedChallengeCardWidgetState createState() =>
      _SelectedChallengeCardWidgetState();
}

class _SelectedChallengeCardWidgetState
    extends State<SelectedChallengeCardWidget> with TickerProviderStateMixin {
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
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: InkWell(
        onTap: () async {
          await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ChallengeBottomSheetWidget(),
                  ),
                );
              }).then((value) {
            widget.callback!(value);
          });
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
              width: 160,
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
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
                                fontSize: 16,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
