import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/transactions.dart';

class TransationList extends StatefulWidget {
  final Function deleteTx;

  TransationList(this.deleteTx);

  @override
  State<TransationList> createState() => _TransationListState();
}

class _TransationListState extends State<TransationList> {
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                // padding: EdgeInsets.only(top: constraints.maxHeight * 0.2),
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      'No tranasctions yet',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.5,
                      width: constraints.maxWidth * 1,
                      child: FittedBox(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/20057866_118.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromARGB(255, 9, 89, 143),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: MediaQuery.of(context).size.width > 500
                        ? TextButton.icon(
                            onPressed: () => widget.deleteTx(index),
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            label: Text(
                              'Delete',
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => widget.deleteTx(index),
                            // splashColor: Colors.black,
                          ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
