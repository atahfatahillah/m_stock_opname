import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:m_stock_opname/routers/router_utils.dart';
import 'package:m_stock_opname/services/app_db.dart';
import 'package:m_stock_opname/utils/locator.dart';
import 'package:m_stock_opname/utils/sharedpreference_helper.dart';
import 'package:m_stock_opname/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _fullName;
  final database = locator<AppDB>();
  final String today =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  var _items = [];
  int totalProduct = 0;
  int totalProductOpnamed = 0;
  int totalProductOutstandingOpnamed = 0;

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _refreshItems() async {
    final masterItems = await database.itemsDao.finalAllItems();
    int jumlah = 0;
    masterItems.forEach((item) async {
      final trans = await database.transOpnameDao
          .getTransOpname(item.code ?? "", currentDateTime());
      setState(() {
        if (trans?.createdAt != null) {
          totalProductOpnamed += jumlah + 1;
        }
        totalProductOutstandingOpnamed = totalProduct - totalProductOpnamed;
        _items.add({
          "id": item.id,
          "code": item.code,
          "name": item.name,
          "description": item.description,
          "qty": trans?.qty,
          "uom": trans?.uom,
          "created_at": trans?.createdAt,
          "updated_at": trans?.updatedAt,
        });
      });
    });
    setState(() {
      totalProduct = masterItems.length;
      SharedpreferenceHelper.getStringPref(SharedpreferenceHelper.full_name)
          .then((value) => _fullName = value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        tooltip: 'SCAN QR',
        onPressed: () {
          context.goNamed(APP_PAGE.scannerScreen.routeName);
        },
        child: const Icon(Icons.qr_code, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    height: 55,
                    image: AssetImage('assets/images/person.png'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back,',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '$_fullName',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.logout_rounded,
                    ),
                    iconSize: 20,
                    onPressed: () {
                      SharedpreferenceHelper.clearAllPreference().whenComplete(
                          () => context.goNamed(APP_PAGE.login.routeName));
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Summary',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Assets:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${totalProduct.toString()} Items',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Finish Opname:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${totalProductOpnamed.toString()} Items',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Outstanding Opname:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${totalProductOutstandingOpnamed.toString()} Items',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Assets List',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: ListsWithCards(items: _items))
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListsWithCards extends StatelessWidget {
  ListsWithCards({super.key, required this.items});
  var items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final String code = items[index]['code'];
        return GestureDetector(
          onTap: () => {
            context.goNamed(APP_PAGE.itemDetailScreen.routeName,
                pathParameters: {'code': code})
            // context.goNamed(APP_PAGE.scannerScreen.routeName)
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Name',
                                ),
                                Text(
                                    '${items[index]['code'] ?? ""} - ${items[index]['name'] ?? ""}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800))
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Status',
                                    ),
                                    Text(
                                        items[index]['created_at'] != null
                                            ? 'Opnamed'
                                            : 'Not Opnamed',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800))
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Stock',
                                    ),
                                    Text(
                                        '${items[index]['qty'] ?? "0"} ${items[index]['uom'] ?? ""}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
