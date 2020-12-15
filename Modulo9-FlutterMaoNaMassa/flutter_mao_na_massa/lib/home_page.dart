import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mao_na_massa/list_item.dart';
import 'package:flutter_mao_na_massa/fornecedor_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fornecedores = <Fornecedor>[];

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/dados.json').then((json) {
      var listConvert = <Map<String, dynamic>>[];

      jsonDecode(json).forEach((json) {
        listConvert.add(json as Map<String, dynamic>);
      });

      setState(() {
        fornecedores =
            listConvert.map((json) => Fornecedor.fromJson(json)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha uma Revenda'),
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.arrow_up_arrow_down), onPressed: () {}),
          IconButton(icon: Icon(CupertinoIcons.question), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                //physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => ListItem(fornecedores[index]),
                itemCount: fornecedores?.length ?? 0),
          ),
        ],
      ),
    );
  }
}

class _buildHeader extends StatelessWidget {
  const _buildHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Botijões de 13kg em: ',
                  style: TextStyle(fontSize: 9, color: Colors.grey),
                ),
                const Text(
                  'Av. Paulista, 1001',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Paulista, São Paulo, SP',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  'Mudar',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}
