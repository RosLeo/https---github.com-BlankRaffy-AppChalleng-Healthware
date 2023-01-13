import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.88, -1.01),
                  child: InkWell(
                    onTap: () async {
                      context.pushNamed('About_Us');
                    },
                    child: Container(
                      width: 440.2,
                      height: 937.2,
                      decoration: BoxDecoration(
                        color: Color(0xFF6497B1),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.67, 0),
                  child: Image.asset(
                    'assets/images/Logo_bozza_definitiva_1_1.png',
                    width: 418,
                    height: 932,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.02, 0.02),
                  child: InkWell(
                    onTap: () async {
                      context.pushNamed('How_To_Use');
                    },
                    child: Container(
                      width: 214,
                      height: 253,
                      decoration: BoxDecoration(
                        color: Color(0x00FFFFFF),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: Image.asset(
                            'assets/images/Logo_bozza_definitiva_(1).png',
                          ).image,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.03, 0.51),
                  child: InkWell(
                    onTap: () async {
                      context.pushNamed('About_Us');
                    },
                    child: Text(
                      'Lifting Vision',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Dancing Script',
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
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
