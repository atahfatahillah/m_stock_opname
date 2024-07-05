import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:m_stock_opname/entities/items.dart';
import 'package:m_stock_opname/services/app_db.dart';
import 'package:m_stock_opname/utils/locator.dart';
import 'package:m_stock_opname/utils/sharedpreference_helper.dart';
import 'package:m_stock_opname/utils/values.dart';

import '../routers/router_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final dummyDatas = Values.dummyProduct;

  startTime() async {
    await GetIt.instance.allReady();

    final database = locator<AppDB>();

    for (int i = 0; i < dummyDatas.length; i++) {
      database.itemsDao.insertItems(Items(
          id: null,
          code: dummyDatas[i]['code'],
          name: dummyDatas[i]['name'],
          description: dummyDatas[i]['description']));
    }

    var duration = Duration(seconds: 5);
    return Timer(duration, await navigationPage);
  }

  Future<void> navigationPage() async {
    SharedpreferenceHelper.getBoolPref(SharedpreferenceHelper.isLoggedIn)
        .then((value) {
      if (value == null || !value) {
        context.goNamed(APP_PAGE.login.routeName);
      } else {
        context.goNamed(APP_PAGE.home.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Image(
            height: 275,
            image: AssetImage('assets/images/official_logo.png'),
          ),
        ),
      ),
    );
  }
}
