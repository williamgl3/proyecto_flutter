import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  final List<String> opciones;
  final int indiceSeleccionado;
  final Function(int) onItemTapped;

  const MenuLateral({
    super.key,
    required this.opciones,
    required this.indiceSeleccionado,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.white,
      child: Column(
        children: [
          // Logo del banco
          _buildHeader(),
          
          // Opciones del menú
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: opciones.length,
              itemBuilder: (context, index) {
                return _buildMenuItem(
                  opcion: opciones[index],
                  isSelected: indiceSeleccionado == index,
                  onTap: () => onItemTapped(index),
                );
              },
            ),
          ),
          
          // Información del usuario
          _buildUserInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: const Text(
        'Mi Banco',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String opcion,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              _getIconForOption(opcion),
              size: 20,
              color: isSelected ? Colors.blue : Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Text(
              opcion,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stephanie Jones',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                'Cuenta Premium',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForOption(String opcion) {
    switch (opcion) {
      case 'Tarjetas':
        return Icons.credit_card;
      case 'Cuentas':
        return Icons.account_balance_wallet;
      case 'Movimientos':
        return Icons.swap_horiz;
      case 'Inversiones':
        return Icons.trending_up;
      case 'Configuración':
        return Icons.settings;
      default:
        return Icons.circle;
    }
  }
}