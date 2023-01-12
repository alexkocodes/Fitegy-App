import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChallengeCreatedWidget extends StatefulWidget {
  const ChallengeCreatedWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  _ChallengeCreatedWidgetState createState() => _ChallengeCreatedWidgetState();
}

class _ChallengeCreatedWidgetState extends State<ChallengeCreatedWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'imageOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1500.ms,
          begin: Offset(-100, -100),
          end: Offset(0, 0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: Offset(81, 0),
          end: Offset(0, 0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1500.ms,
          begin: Offset(87, 80),
          end: Offset(0, 0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1400.ms,
          begin: Offset(-36, 30),
          end: Offset(0, 0),
        ),
      ],
    ),
  };
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/iPhone_13_Pro_Max_-_30_(1).png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: AlignmentDirectional(-1.88, -0.64),
              child: Image.asset(
                'assets/images/bubble_(4).png',
                width: 300,
                fit: BoxFit.fill,
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation1']!),
            ),
            Align(
              alignment: AlignmentDirectional(0.81, 0.08),
              child: Image.asset(
                'assets/images/bubble_(2).png',
                width: 130,
                fit: BoxFit.cover,
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation2']!),
            ),
            Align(
              alignment: AlignmentDirectional(0.9, 0.33),
              child: Image.asset(
                'assets/images/bubble_(1).png',
                width: 200,
                fit: BoxFit.cover,
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation3']!),
            ),
            Align(
              alignment: AlignmentDirectional(0, -0.1),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0x94FFFFFF), Color(0x00FFFFFF)],
                          stops: [0, 0.7],
                          begin: AlignmentDirectional(-0.64, -1),
                          end: AlignmentDirectional(0.64, 1),
                        ),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Color(0x4DFFFFFF),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title!,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Archivo Black',
                                    fontSize: 16,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyText1Family),
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              child: Text(
                                dateTimeFormat('yMMMd', getCurrentTimestamp),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyText1Family,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1Family),
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Image.asset(
                                'assets/images/diamond.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.5, 0.25),
              child: Image.asset(
                'assets/images/bubble.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation4']!),
            ),
            Align(
              alignment: AlignmentDirectional(0.85, 0.93),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_forward,
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  size: 30,
                ),
                onPressed: () async {
                  context.pushNamed('MyChallenges');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
