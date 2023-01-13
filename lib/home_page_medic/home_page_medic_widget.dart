//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:lifting_vision/Bean/DoctorBean.dart';
import 'package:lifting_vision/dbConnection.dart';
import 'package:path_provider/path_provider.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifting_vision/file_operation.dart';
import 'package:lifting_vision/Bean/PatientBean.dart';

class HomePageMedicWidget extends StatefulWidget {
  const HomePageMedicWidget({Key? key}) : super(key: key);

  @override
  _HomePageMedicWidgetState createState() => _HomePageMedicWidgetState();
}

class _HomePageMedicWidgetState extends State<HomePageMedicWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isSearch = false;

  dynamic _emailmessage;
  var patientList;
  var searchlist;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  Future<List<PatientBean>> loadPatient() async {
    var token = await readFileToken();
    return patientList =
        await DbConnection().getPatient(token) as List<PatientBean>;
  }

  searchPatient(String value) async {
    var templist = await loadPatient();
    List<PatientBean>? searchPatientList = <PatientBean>[];

    for (PatientBean e in templist) {
      if (e.name.toLowerCase().contains(value.toLowerCase()) ||
          e.surname.toLowerCase().contains(value.toLowerCase())) {
        print("contiene il nome o una lettera");
        print(value + " " + e.name + " " + e.surname);
        searchPatientList.add(e as PatientBean);
      }
    }
    searchlist = searchPatientList;
    if (value == null || value.isEmpty) {
      searchlist = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      endDrawer: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          elevation: 16,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () async {
                    context.pushNamed('User_Profile');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        icon: Icon(
                          Icons.person,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 30,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                      Text(
                        'Profile',
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.exit_to_app_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                    Text(
                      'Exit',
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        heightFactor: 5,
                        alignment: AlignmentDirectional(-1, -1),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          icon: Icon(
                            Icons.add,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 30,
                          ),
                          onPressed: () async {
                            context.pushNamed('Add_Patient');
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'Lifting Vision',
                              style:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: 'Dancing Script',
                                      ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/Logo_bozza_definitiva_(1).png',
                            width: 240,
                            height: 240,
                            fit: BoxFit.fitWidth,
                          )
                        ],
                      ),
                      Align(
                        heightFactor: 5,
                        alignment: AlignmentDirectional(1, -1),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          icon: Icon(
                            Icons.menu,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 30,
                          ),
                          onPressed: () async {
                            scaffoldKey.currentState!.openEndDrawer();
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                          child: TextFormField(
                        onChanged: (value) async {
                          if (value != null || !value.isEmpty) {
                            isSearch = true;
                            await searchPatient(value);
                          }
                          if (value == null || value.isEmpty) isSearch = false;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person_search),
                          hintText: 'Enter a search term',
                        ),
                      )),
                      FutureBuilder(
                        future: loadPatient(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (!isSearch) {
                              print("non è stata fatta una ricerca");
                              patientList = snapshot.data;
                            }
                            if (isSearch) {
                              print("è stata fatta una ricerca");
                              if (searchlist != null) {
                                patientList = searchlist;
                              }
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (PatientBean e in patientList)
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Card(
                                      elevation: 0.5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 20,
                                              top: 120,
                                            ),
                                          ),
                                          CircleAvatar(
                                              radius: 40,
                                              child: Icon(
                                                Icons.person,
                                                size: 40,
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 55, 99, 143)),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 250)),
                                              Text(
                                                e.name + " " + e.surname,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                e.email,
                                                style: const TextStyle(),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
