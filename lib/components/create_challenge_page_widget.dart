import 'package:flutter_platform_alert/flutter_platform_alert.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CreateChallengePageWidget extends StatefulWidget {
  const CreateChallengePageWidget({Key? key}) : super(key: key);

  @override
  _CreateChallengePageWidgetState createState() =>
      _CreateChallengePageWidgetState();
}

class _CreateChallengePageWidgetState extends State<CreateChallengePageWidget> {
  String? radioButtonValue;
  TextEditingController? commentsController;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController4;
  int buttonIndex = 1;

  @override
  void initState() {
    super.initState();
    commentsController = TextEditingController();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController4 = TextEditingController();
  }

  @override
  void dispose() {
    commentsController?.dispose();
    textController1?.dispose();
    textController2?.dispose();
    textController4?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(35, 0, 30, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 0,
                          runSpacing: 0,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Text(
                                  'Challenge yourself with a',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .title1Family),
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: GradientText(
                                  'new goal.',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2Family),
                                      ),
                                  colors: [
                                    Color(0xFFDA7DFD),
                                    FlutterFlowTheme.of(context).secondaryColor
                                  ],
                                  gradientDirection: GradientDirection.ltr,
                                  gradientType: GradientType.linear,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Divider(
                                thickness: 1,
                                color: Color(0xFFCFCFCF),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Challenge Name: ',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyText1Family,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyText1Family),
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Color(0x3416202A),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: textController1,
                        textCapitalization: TextCapitalization.sentences,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFB1B1B1),
                                fontWeight: FontWeight.w300,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText2Family),
                              ),
                          hintText: 'Use a fun name!',
                          hintStyle: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Inter',
                                color: Color(0xFFB1B1B1),
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText2Family),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          prefixIcon: Icon(
                            Icons.sports_handball_outlined,
                            color: FlutterFlowTheme.of(context).lineColor,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                      ),
                    ),
                  ),
                  Text(
                    'Challenge Details:',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyText1Family,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyText1Family),
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Color(0x3416202A),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: textController2,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFB1B1B1),
                                fontWeight: FontWeight.w300,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText2Family),
                              ),
                          hintText: 'What\'s your challenge about?',
                          hintStyle: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Inter',
                                color: Color(0xFFB1B1B1),
                                fontWeight: FontWeight.w300,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText2Family),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                        textAlign: TextAlign.start,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                  Text(
                    'Comments? 🤓',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyText1Family,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyText1Family),
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Color(0x3416202A),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: commentsController,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFB1B1B1),
                                fontWeight: FontWeight.w300,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText2Family),
                              ),
                          prefixIcon: Icon(
                            Icons.rocket_launch,
                            color: FlutterFlowTheme.of(context).lineColor,
                          ),
                          hintText: 'Anything special about this challenge?',
                          hintStyle: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Inter',
                                color: Color(0xFFB1B1B1),
                                fontWeight: FontWeight.w300,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText2Family),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                        textAlign: TextAlign.start,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                  // Text(
                  //   'Who to challenge?',
                  //   style: FlutterFlowTheme.of(context).bodyText1.override(
                  //         fontFamily:
                  //             FlutterFlowTheme.of(context).bodyText1Family,
                  //         color: FlutterFlowTheme.of(context).secondaryText,
                  //         fontSize: 16,
                  //         useGoogleFonts: GoogleFonts.asMap().containsKey(
                  //             FlutterFlowTheme.of(context).bodyText1Family),
                  //       ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  //   child: Container(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: FlutterFlowTheme.of(context).secondaryBackground,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           blurRadius: 6,
                  //           color: Color(0x3416202A),
                  //           offset: Offset(0, 2),
                  //         )
                  //       ],
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: TextFormField(
                  //       controller: textController4,
                  //       obscureText: false,
                  //       decoration: InputDecoration(
                  //         labelStyle: FlutterFlowTheme.of(context)
                  //             .bodyText2
                  //             .override(
                  //               fontFamily: 'Montserrat',
                  //               color: Color(0xFFB1B1B1),
                  //               fontWeight: FontWeight.w300,
                  //               useGoogleFonts: GoogleFonts.asMap().containsKey(
                  //                   FlutterFlowTheme.of(context)
                  //                       .bodyText2Family),
                  //             ),
                  //         hintText: 'Challenge your friends! ',
                  //         hintStyle: FlutterFlowTheme.of(context)
                  //             .bodyText2
                  //             .override(
                  //               fontFamily: 'Inter',
                  //               color: Color(0xFFB1B1B1),
                  //               useGoogleFonts: GoogleFonts.asMap().containsKey(
                  //                   FlutterFlowTheme.of(context)
                  //                       .bodyText2Family),
                  //             ),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Color(0x00000000),
                  //             width: 1,
                  //           ),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Color(0x00000000),
                  //             width: 1,
                  //           ),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         errorBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Color(0x00000000),
                  //             width: 1,
                  //           ),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         focusedErrorBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Color(0x00000000),
                  //             width: 1,
                  //           ),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         filled: true,
                  //         fillColor:
                  //             FlutterFlowTheme.of(context).secondaryBackground,
                  //         prefixIcon: Icon(
                  //           Icons.supervised_user_circle_sharp,
                  //           color: FlutterFlowTheme.of(context).lineColor,
                  //         ),
                  //       ),
                  //       style: FlutterFlowTheme.of(context).bodyText1.override(
                  //             fontFamily: 'Inter',
                  //             color: Colors.black,
                  //             fontSize: 14,
                  //             useGoogleFonts: GoogleFonts.asMap().containsKey(
                  //                 FlutterFlowTheme.of(context).bodyText1Family),
                  //           ),
                  //     ),
                  //   ),
                  // ),
                  Divider(
                    thickness: 1,
                    color: Color(0xFFCFCFCF),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-0.98, 0.2),
                          child: Text(
                            'Select a color theme:',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyText1Family,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyText1Family),
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: buttonIndex == 1
                                      ? Border.all(
                                          color: Colors.white, width: 3)
                                      : null),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    buttonIndex = 1;
                                  });
                                },
                              ),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 154, 225, 255),
                                    Color.fromARGB(255, 253, 255, 155)
                                  ],
                                  stops: [0, 1],
                                  begin: AlignmentDirectional(-0.34, -1),
                                  end: AlignmentDirectional(0.34, 1),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: buttonIndex == 2
                                      ? Border.all(
                                          color: Colors.white, width: 3)
                                      : null),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    buttonIndex = 2;
                                  });
                                },
                              ),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 89, 205, 114),
                                    Color.fromARGB(255, 253, 255, 155)
                                  ],
                                  stops: [0, 1],
                                  begin: AlignmentDirectional(-0.34, -1),
                                  end: AlignmentDirectional(0.34, 1),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: buttonIndex == 3
                                      ? Border.all(
                                          color: Colors.white, width: 3)
                                      : null),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    buttonIndex = 3;
                                  });
                                },
                              ),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 116, 116),
                                    Color.fromARGB(255, 253, 255, 155)
                                  ],
                                  stops: [0, 1],
                                  begin: AlignmentDirectional(-0.34, -1),
                                  end: AlignmentDirectional(0.34, 1),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: buttonIndex == 4
                                      ? Border.all(
                                          color: Colors.white, width: 3)
                                      : null),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    buttonIndex = 4;
                                  });
                                },
                              ),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 89, 200),
                                    Color.fromARGB(255, 253, 255, 155)
                                  ],
                                  stops: [0, 1],
                                  begin: AlignmentDirectional(-0.34, -1),
                                  end: AlignmentDirectional(0.34, 1),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: buttonIndex == 5
                                      ? Border.all(
                                          color: Colors.white, width: 3)
                                      : null),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    buttonIndex = 5;
                                  });
                                },
                              ),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFE6A0FF),
                                    Color(0xFF9AE1FF)
                                  ],
                                  stops: [0, 1],
                                  begin: AlignmentDirectional(-0.34, -1),
                                  end: AlignmentDirectional(0.34, 1),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            if (textController1!.text == '') {
                              await FlutterPlatformAlert.showAlert(
                                windowTitle: "Challenge name can\'t be empty!",
                                text:
                                    "Try something like: Spring Break Saadiyat 4k Run Challenge 🏃‍♂️",
                                iconStyle: IconStyle.information,
                              );
                            } else {
                              final challengesCreateData = {
                                ...createChallengesRecordData(
                                  title: textController1!.text,
                                  details: textController2!.text,
                                  createdAt: getCurrentTimestamp,
                                  createBy: currentUserReference,
                                  status: 'active',
                                  colorScheme: buttonIndex,
                                  comments: commentsController!.text,
                                  originalReference: null,
                                ),
                                'active_participants': [currentUserReference],
                                'invited_participants': [],
                              };
                              await ChallengesRecord.createDoc(
                                      currentUserReference!)
                                  .set(challengesCreateData);

                              context.pushNamed(
                                'ChallengeCreated',
                                queryParams: {
                                  'title': serializeParam(
                                    textController1!.text,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 800),
                                  ),
                                },
                              );
                            }
                          },
                          text: 'Create',
                          options: FFButtonOptions(
                            width: 110,
                            height: 40,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .subtitle2Family),
                                ),
                            elevation: 5,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
