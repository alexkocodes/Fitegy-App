import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

class ProfileStatesBar extends StatefulWidget {
  const ProfileStatesBar({Key? key, this.authorRef}) : super(key: key);
  final DocumentReference? authorRef;

  @override
  State<ProfileStatesBar> createState() => _ProfileStatesBarState();
}

Future<Map> getData(DocumentReference<Object?> documentReference) {
  return documentReference.get().then((value) => value.data() as Map);
}

class _ProfileStatesBarState extends State<ProfileStatesBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 20.0),
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 249, 252),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<int>(
                  future: queryChallengesRecordCount(
                    parent: widget.authorRef,
                    queryBuilder: (challengesRecord) => challengesRecord
                        .where('status', isEqualTo: 'completed'),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                            ),
                          ),
                        ),
                      );
                    }
                    int textCount = snapshot.data!;
                    return Text(
                      valueOrDefault<String>(
                        textCount.toString(),
                        '?',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    );
                  },
                ),
                Text(
                  'Completed',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyText1Family,
                        color: FlutterFlowTheme.of(context).grayIcon,
                        fontWeight: FontWeight.w300,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyText1Family),
                      ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
              child: VerticalDivider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).lineColor,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: getData(widget.authorRef!),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                            ),
                          ),
                        ),
                      );
                    }

                    final data = snapshot.data as Map<String, dynamic>;
                    // if friends is a field in data

                    return Text(
                      data['friends'] == null
                          ? "0"
                          : data['friends'].length.toString(),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyText1Family,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    );
                  },
                ),
                Text(
                  'Friends',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyText1Family,
                        color: FlutterFlowTheme.of(context).grayIcon,
                        fontWeight: FontWeight.w300,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyText1Family),
                      ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
              child: VerticalDivider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).lineColor,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '0',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyText1Family,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyText1Family),
                      ),
                ),
                Text(
                  'Streaks',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyText1Family,
                        color: FlutterFlowTheme.of(context).grayIcon,
                        fontWeight: FontWeight.w300,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyText1Family),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
