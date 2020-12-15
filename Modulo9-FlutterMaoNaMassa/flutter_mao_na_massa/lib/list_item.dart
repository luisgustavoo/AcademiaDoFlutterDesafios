import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mao_na_massa/fornecedor_model.dart';
import 'package:flutter_mao_na_massa/shop_cart.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final Fornecedor fornecedor;
  final String color;

  ListItem(this.fornecedor) : color = '0xFF${fornecedor.cor}';

  @override
  Widget build(BuildContext context) {
    var formatNumber = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(

        borderRadius: BorderRadius.circular(5),
        onTap: () => Navigator.pushNamed(context, ShopCart.routeName, arguments: fornecedor),
        child: Container(
          height: 107,
          child: Card(
            child: Row(
              children: [
                _buildType(color: color, fornecedor: fornecedor),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHead(fornecedor: fornecedor),
                        _buildContent(
                            fornecedor: fornecedor, formatNumber: formatNumber)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    Key key,
    @required this.fornecedor,
    @required this.formatNumber,
  }) : super(key: key);

  final Fornecedor fornecedor;
  final NumberFormat formatNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nota',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Row(
              children: [
                Text(
                  fornecedor.nota.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20,
                )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tempo Médio',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${fornecedor.tempoMedio}',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'min',
                  style: TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
        Column(
          children: [
            Text(
              'Preço',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              formatNumber.format(fornecedor.preco),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class _buildHead extends StatelessWidget {
  const _buildHead({
    Key key,
    @required this.fornecedor,
  }) : super(key: key);

  final Fornecedor fornecedor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 15, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fornecedor.nome,
            style: TextStyle(fontSize: 12),
          ),
          Visibility(
            visible: fornecedor.melhorPreco,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
              child: Container(
                color: Colors.orange[300],
                padding: const EdgeInsets.all(5),
                /*decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.orange[300],
                ),*/
                height: 30,
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      'Melhor Preço',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _buildType extends StatelessWidget {
  const _buildType({
    Key key,
    @required this.color,
    @required this.fornecedor,
  }) : super(key: key);

  final String color;
  final Fornecedor fornecedor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        color: Color(int.parse(color)),
        height: double.infinity,
        width: 35,
        child: RotatedBox(
          quarterTurns: 3,
          child: Text(
            fornecedor.tipo,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
