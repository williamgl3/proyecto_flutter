import 'package:flutter/material.dart';
import '../models/movimiento_model.dart';

class ItemMovimiento extends StatelessWidget {
  final MovimientoModel movimiento;

  const ItemMovimiento({super.key, required this.movimiento});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icono según categoría
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getColorCategoria().withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getIconoCategoria(),
              color: _getColorCategoria(),
              size: 22,
            ),
          ),
          const SizedBox(width: 15),
          
          // Información del movimiento
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movimiento.comercio,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      movimiento.banco,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      ' • ${movimiento.tipoTarjeta}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Monto y fecha
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${movimiento.monto.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: movimiento.esIngreso ? Colors.green : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                movimiento.fechaFormateada,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColorCategoria() {
    switch (movimiento.categoria) {
      case 'Compras':
        return Colors.purple;
      case 'Supermercado':
        return Colors.green;
      case 'Comida':
        return Colors.orange;
      case 'Transporte':
        return Colors.blue;
      case 'Entretenimiento':
        return Colors.pink;
      case 'Ingreso':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getIconoCategoria() {
    switch (movimiento.categoria) {
      case 'Compras':
        return Icons.shopping_bag_outlined;
      case 'Supermercado':
        return Icons.shopping_cart_outlined;
      case 'Comida':
        return Icons.restaurant_outlined;
      case 'Transporte':
        return Icons.directions_car_outlined;
      case 'Entretenimiento':
        return Icons.movie_outlined;
      case 'Ingreso':
        return Icons.trending_up_outlined;
      default:
        return Icons.receipt_outlined;
    }
  }
}