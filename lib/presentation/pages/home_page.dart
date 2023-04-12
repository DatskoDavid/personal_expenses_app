import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/transactions.dart';
import '../../domain/models/transaction.dart';
import '../widgets/chart.dart';
import '../widgets/input_form.dart';
import '../widgets/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  final String titleText;

  MyHomePage({required this.titleText});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _mainPadding = 20.0;
  bool _showChart = true;

  List<Transaction> get _recentTransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startNewTransaction() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (_) {
        return GestureDetector(
          child: SizedBox(
            // height: 200,
            child: InputForm(_addNewTransaction),
          ),
          //onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: 't${transactions.length - 1}',
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(
      () => transactions.add(newTx),
    );
  }

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = (Platform.isAndroid
        ? AppBar(
            title: Text(
              widget.titleText,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: _startNewTransaction,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        : CupertinoNavigationBar(
            middle: Text(widget.titleText),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: GestureDetector(
                      onTap: _startNewTransaction,
                      child: Icon(CupertinoIcons.add),
                    ),
                  ),
                ),
              ],
            ),
          )) as PreferredSizeWidget;

    final txList = SizedBox(
      height: (mediaQuery.size.height -
              _mainPadding * 2 -
              -appBar.preferredSize.height
          /* insted mediaQuery.padding.top bcs of web -*/
          /* appBar.preferredSize.height * 1.5 */
          /* mediaQuery.padding.top */) *
          (isLandscape ? 0.5 : 0.55),
      child: TransationList(_deleteTransaction),
    );

    final appBody = SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          // vertical: _mainPadding,
          horizontal: _mainPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show Chart: ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Switch.adaptive(
                      value: _showChart,
                      onChanged: ((_) {
                        setState(
                          () {
                            _showChart = !_showChart;
                          },
                        );
                      }),
                    ),
                  ],
                ),
              if (!isLandscape)
                SizedBox(
                  height: (mediaQuery.size.height -
                          _mainPadding * 2 -
                          appBar.preferredSize
                              .height /* -
                          mediaQuery.padding.top */
                      // appBar.preferredSize.height * 1.5 - for web)
                      ) *
                      0.3,
                  child: Chart(recentTransaction: _recentTransaction),
                ),
              if (!isLandscape) txList,
              if (isLandscape)
                _showChart
                    ? SizedBox(
                        height: (mediaQuery.size.height -
                                _mainPadding * 2 -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top
                            // appBar.preferredSize.height * 1.5 - for web
                            ) *
                            0.75,
                        child: Chart(recentTransaction: _recentTransaction),
                      )
                    : txList,
            ],
          ),
        ),
      ),
    );

    return Platform.isAndroid
        ? Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Theme(
                data: Theme.of(context).copyWith(splashColor: Colors.indigo),
                child: Platform.isAndroid
                    ? FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: _startNewTransaction,
                      )
                    : Container()),
          )
        : CupertinoPageScaffold(
            child: appBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          );
  }
}
