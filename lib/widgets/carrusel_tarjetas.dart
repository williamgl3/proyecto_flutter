import 'package:flutter/material.dart';
import 'tarjeta_bancaria.dart';
import '../models/tarjeta_model.dart';

class CarruselTarjetas extends StatelessWidget {
  final List<TarjetaModel> tarjetas;
  final bool ocultarSaldos;

  const CarruselTarjetas({
    super.key,
    required this.tarjetas,
    this.ocultarSaldos = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tarjetas.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 16),
            child: TarjetaBancaria(
              tarjeta: tarjetas[index],
              esPequena: index != 0, // La primera es más grande
              ocultarSaldo: ocultarSaldos,
            ),
          );
        },
      ),
    );
  }
}
