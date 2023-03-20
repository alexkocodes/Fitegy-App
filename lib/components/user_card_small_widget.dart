import '../flutter_flow/flutter_flow_model.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_card_small_model.dart';
export 'user_card_small_model.dart';

class UserCardSmallWidget extends StatefulWidget {
  UserCardSmallWidget({
    Key? key,
    this.imageURL,
    String? username,
    this.emoji,
    this.color,
    required this.callback,
    this.uid,
  })  : this.username = username ?? '',
        super(key: key);

  final String? imageURL;
  final String username;
  final String? emoji;
  final String? color;
  Function callback;
  final String? uid;

  @override
  _UserCardSmallWidgetState createState() => _UserCardSmallWidgetState();
}

class _UserCardSmallWidgetState extends State<UserCardSmallWidget> {
  late UserCardSmallModel _model;
  var showCheck = false;
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserCardSmallModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: InkWell(
        onTap: () {
          setState(() {
            showCheck = !showCheck!;
            widget.callback(widget.uid);
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: widget.color == "grey" ? Color(0xFFF4F4F4) : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 5, 30, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    showCheck == true
                        ? Image.asset(
                            'assets/images/check.png',
                            width: 25,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(
                            width: 25,
                          ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Container(
                        width: 36,
                        height: 36,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          widget.imageURL!,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(
                        widget.username,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Inter',
                              color: Color(0xFFCFCFCF),
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                      ),
                    ),
                  ],
                ),
                SelectionArea(
                    child: Text(
                  widget.emoji!,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyText1Family,
                        fontSize: 20,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyText1Family),
                      ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
