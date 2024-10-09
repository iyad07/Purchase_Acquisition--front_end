import 'package:flutter/material.dart';
import 'package:form_acquistion/Admindashresponsive/desktop_design.dart';
import 'package:form_acquistion/Admindashresponsive/mobile_design.dart';
import 'package:form_acquistion/Admindashresponsive/tablet_design.dart';
import 'package:form_acquistion/responsive.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileDesign: const MobileDesign(),
      tabletDesign: const TabletDesign(),
      desktopDesign: const DesktopDesign(),
    );}
}
