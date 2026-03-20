import 'package:flutter/material.dart';
import '../models/tarjeta_model.dart';

class TarjetaBancaria extends StatelessWidget {
  final TarjetaModel tarjeta;
  final bool esPequena;
  final bool ocultarSaldo;

  const TarjetaBancaria({
    super.key,
    required this.tarjeta,
    this.esPequena = false,
    this.ocultarSaldo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: esPequena ? 260 : double.infinity,
      height: esPequena ? 150 : 190,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E2B3A), Color(0xFF0F1A26)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Fila superior con nombre e icono
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tarjeta.titular,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: esPequena ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildTarjetaIcono(),
            ],
          ),
          
          if (!esPequena) ...[
            const SizedBox(height: 10),
            Text(
              ocultarSaldo ? '****' : '\$${tarjeta.balance.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(
              tarjeta.numeroTarjeta,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),
          ],
          
         
          
          // Información de balance y sobregiro
          Row(
            children: [
              _buildInfoItem(
                'Balance',
                ocultarSaldo ? '****' : '\$${tarjeta.balance.toStringAsFixed(0)}',
                esPequena,
              ),
              const SizedBox(width: 20),
              _buildInfoItem(
                'Sobregiro',
                ocultarSaldo ? '****' : '\$${tarjeta.sobregiro.toStringAsFixed(0)}',
                esPequena,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, bool esPequena) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: esPequena ? 10 : 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: esPequena ? 12 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTarjetaIcono() {
    IconData icono;
    Color color = Colors.white;

    switch (tarjeta.tipo) {
      case 'Visa':
        icono = Icons.credit_card;
        break;
      case 'Mastercard':
        icono = Icons.circle;
        color = Colors.orange;
        break;
      case 'American Express':
        icono = Icons.stars;
        break;
      default:
        icono = Icons.credit_card;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icono, color: color, size: 20),
    );
  }
}
