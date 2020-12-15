import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mao_na_massa/fornecedor_model.dart';
import 'package:intl/intl.dart';

enum OrderCycle { comprar, pagamento, confirmacao }

class ShopCart extends StatefulWidget {
  static const routeName = '/order';
  final Fornecedor fornecedor;
  final String color;

  ShopCart({@required this.fornecedor}) : color = '0xFF${fornecedor.cor}';

  @override
  _ShopCartState createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  final formatNumber = NumberFormat.currency(locale: 'pt_BR', symbol: '');
  var _orderCycle = OrderCycle.comprar;
  var quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar Produto'),
        actions: [
          IconButton(icon: Icon(CupertinoIcons.question), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_head(), _content()],
      ),
      floatingActionButton: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 60,
          width: 200,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue[300], Colors.blue]),
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(
            'IR PARA O PAGAMENTO',
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _head() {
    return Column(
      children: [
        Container(
          height: 90,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: Radio(
                              value: OrderCycle.comprar,
                              groupValue: _orderCycle,
                              onChanged: (OrderCycle value) {
                                setState(() {
                                  _orderCycle = value;
                                });
                              }),
                        ),
                        Text(
                          'Comprar',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 15,
                        decoration: BoxDecoration(
                          border: Border(
                            top: createBorderSide(context,
                                color: Colors.black, width: 0.2),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: Radio(
                              value: OrderCycle.pagamento,
                              groupValue: _orderCycle,
                              onChanged: (OrderCycle value) {
                                setState(() {
                                  _orderCycle = value;
                                });
                              }),
                        ),
                        Text(
                          'Pagamento',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 15,
                        decoration: BoxDecoration(
                          border: Border(
                            top: createBorderSide(context,
                                color: Colors.black, width: 0.2),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: Radio(
                              value: OrderCycle.confirmacao,
                              groupValue: _orderCycle,
                              onChanged: (OrderCycle value) {
                                setState(() {
                                  _orderCycle = value;
                                });
                              }),
                        ),
                        Text(
                          'Confirmar',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: createBorderSide(context, color: Colors.black, width: 0.2),
            ),
          ),
        ),
        Container(
          height: 50,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    height: 25,
                    width: 25,
                    child: CircleAvatar(
                      child: Text(
                        '1',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      backgroundColor: Color(int.parse(widget.color)),
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                  '${widget.fornecedor.nome} - Botijão de 13Kg',
                  style: TextStyle(fontSize: 12),
                )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${formatNumber.format(widget.fornecedor.preco)}',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _content() {
    return Expanded(
      child: ListView(
        //physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15.0),
        children: [
          Card(
            child: Container(
              height: 160,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 8.0, right: 8.0, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.home,
                            color: Colors.grey,
                            size: 33,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.fornecedor.nome}',
                              style: TextStyle(fontSize: 12),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.fornecedor.nota}',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 12,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Text(
                          '${widget.fornecedor.tempoMedio} min',
                          style: TextStyle(fontSize: 12),
                        )),
                        Container(
                          height: 25,
                          color: Color(int.parse(widget.color)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                '${widget.fornecedor.tipo}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Botijão de 13gk',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              widget.fornecedor.nome,
                              style: TextStyle(fontSize: 12),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'R\$',
                                  style: TextStyle(
                                      fontSize: 8, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  formatNumber.format(widget.fornecedor.preco),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          color: Colors.grey,
                          icon: Icon(
                            Icons.remove_circle,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              quantity--;
                              if (quantity < 0) {
                                quantity = 0;
                              }
                            });
                          },
                        ),
                        Container(
                          child: Center(
                              child: Text(
                            '$quantity',
                            style: TextStyle(fontSize: 12),
                          )),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(50)),
                          height: 25,
                          width: 15,
                        ),
                        IconButton(
                          color: Colors.grey,
                          icon: Icon(
                            Icons.add_circle,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static BorderSide createBorderSide(BuildContext context,
      {Color color, double width}) {
    final effectiveColor = color ??
        (context != null
            ? (DividerTheme.of(context).color ?? Theme.of(context).dividerColor)
            : null);
    final effectiveWidth = width ??
        (context != null ? DividerTheme.of(context).thickness : null) ??
        0.0;

    if (effectiveColor == null) {
      return BorderSide(
        width: effectiveWidth,
      );
    }
    return BorderSide(
      color: effectiveColor,
      width: effectiveWidth,
    );
  }
}
