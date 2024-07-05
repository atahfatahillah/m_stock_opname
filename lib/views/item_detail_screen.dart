import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:m_stock_opname/entities/items.dart';
import 'package:m_stock_opname/entities/trans_opname.dart';
import 'package:m_stock_opname/routers/router_utils.dart';
import 'package:m_stock_opname/services/app_db.dart';
import 'package:m_stock_opname/utils/app_theme.dart';
import 'package:m_stock_opname/utils/utils.dart';
import 'package:m_stock_opname/utils/values.dart';

import '../utils/locator.dart';

// ignore: must_be_immutable
class ItemDetailScreen extends StatefulWidget {
  String code;
  ItemDetailScreen({super.key, required this.code});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  final database = locator<AppDB>();
  String _code = "";
  Items? itemData;
  late TextEditingController etQtyController;

  @override
  void initState() {
    super.initState();
    _code = widget.code;
    etQtyController = TextEditingController();

    fetchData();
  }

  void fetchData() async {
    final item = await database.itemsDao.findItemsByCode(_code).first;
    final trans =
        await database.transOpnameDao.getTransOpname(_code, currentDateTime());
    setState(() {
      itemData = item;
      if (trans != null) {
        etQtyController.text = trans.qty.toString();
      }
    });
  }

  void updateStock() async {
    TransOpname opname = TransOpname(
        code: _code,
        qty: int.parse(etQtyController.text.toString()),
        uom: "pcs",
        createdAt: currentDateTime(),
        updatedAt: currentDateTime());
    database.transOpnameDao.insert(opname);
    showToast("Item saved successfully");
    context.pushReplacementNamed(APP_PAGE.home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Item',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Name:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${itemData?.name}',
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
                              'Code:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${itemData?.code}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                        // Expanded(
                        Text(
                          '${itemData?.description}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: Values.inputHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: etQtyController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only
                    decoration: AppTheme.getInputDecoration('Qty (Pcs)'),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FilledButton(
                    onPressed: () {
                      updateStock();
                    },
                    child: const Text(
                      'Submit',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
