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
      width: 210,
      color: const Color(0xFF1E1B66),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(14, 8, 14, 16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A247A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: opciones.length,
                itemBuilder: (context, index) {
                  return _buildMenuItem(
                    context: context,
                    opcion: opciones[index],
                    isSelected: indiceSeleccionado == index,
                    onTap: () {
                      onItemTapped(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Entrando a: ${opciones[index]}'),
                          duration: const Duration(milliseconds: 500),
                          backgroundColor:
                              const Color.fromARGB(255, 44, 44, 44),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.search, color: Colors.white70, size: 20),
            ],
          ),
          const SizedBox(height: 18),
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=200&q=80',
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Stephanie Jones',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String opcion,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3A3592) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              _getIconForOption(opcion),
              size: 18,
              color: isSelected ? Colors.white : Colors.white70,
            ),
            const SizedBox(width: 10),
            Text(
              opcion,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForOption(String opcion) {
    switch (opcion) {
      case 'Tarjetas':
        return Icons.credit_card;
      case 'Cuentas':
        return Icons.account_balance_wallet_outlined;
      case 'Movimientos':
        return Icons.swap_horiz_rounded;
      case 'Inversiones':
        return Icons.show_chart_rounded;
      case 'Configuración':
        return Icons.settings;
      default:
        return Icons.star;
    }
  }
}
