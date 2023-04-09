import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'user_preview_card_model.dart';
export 'user_preview_card_model.dart';

class UserPreviewCardWidget extends StatefulWidget {
  const UserPreviewCardWidget({
    Key? key,
    this.imageURL,
    this.displayName,
    this.username,
    this.emoji,
    this.userRef,
  }) : super(key: key);

  final String? imageURL;
  final String? displayName;
  final String? username;
  final String? emoji;
  final DocumentReference? userRef;

  @override
  _UserPreviewCardWidgetState createState() => _UserPreviewCardWidgetState();
}

class _UserPreviewCardWidgetState extends State<UserPreviewCardWidget> {
  late UserPreviewCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserPreviewCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed("ProfilePage",
            queryParams: {
              'userRef': serializeParam(
                widget.userRef,
                ParamType.DocumentReference,
              ),
              'name': serializeParam(
                widget.displayName,
                ParamType.String,
              ),
            }.withoutNulls);
      },
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: Color(0x33000000),
                offset: Offset(0, 5),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.imageURL ?? 'https://picsum.photos/seed/1/600',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.displayName,
                            'User',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Inter',
                                color: Color(0xFF1D2429),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleMediumFamily),
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Text(
                                widget.username!,
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                  child: Text(
                    widget.emoji != null ? widget.emoji! : '👋',
                    style: FlutterFlowTheme.of(context).titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
