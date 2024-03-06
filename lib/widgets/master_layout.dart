import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/resources/app_sizes.dart';

class MasterScreen extends StatefulWidget {
  final List<Widget> widgets;
  final Widget? footer;

  const MasterScreen({super.key, required this.widgets, this.footer});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(left: AppSize.s20, right: AppSize.s20, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...widget.widgets],
                ),
              ),
              widget.footer != null ? widget.footer! : const SizedBox.shrink(),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
