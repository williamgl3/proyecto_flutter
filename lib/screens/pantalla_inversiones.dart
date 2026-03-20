import 'package:flutter/material.dart';

class PantallaInversiones extends StatelessWidget {
  final bool ocultarSaldos;

  const PantallaInversiones({
    super.key,
    this.ocultarSaldos = false,
  });

  @override
  Widget build(BuildContext context) {
    // Datos simulados
    final inversiones = [
      ('Fondo Conservador', 12500.00, 2.5),
      ('CETES 28 dias', 8300.00, 11.25),
      ('Plazo fijo', 15000.00, 5.0),
      ('Apple Inc.', 4250.50, 1.2),
      ('S&P 500 ETF', 8900.00, -0.5),
    ];

    final total = inversiones.fold<double>(
      0,
      (acumulado, item) => acumulado + item.$2,
    );

    // Rendimiento total simulado
    const rendimientoTotal = 1240.50;
    const porcentajeRendimiento = 5.2;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inversiones',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Tarjeta Principal de Balance
          _buildBalanceCard(total, rendimientoTotal, porcentajeRendimiento),
          
          const SizedBox(height: 25),

          // Gráfico simulado
          const Text(
            'Rendimiento Histórico',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          _buildChartPlaceholder(),

          const SizedBox(height: 25),

          // Accesos rápidos
          _buildQuickActions(context),

          const SizedBox(height: 25),

          // Lista de Portafolio
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Portafolio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () => _mostrarPortafolioCompleto(context, inversiones),
                child: const Text('Ver todo'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...inversiones.map((item) => GestureDetector(
            onTap: () => _mostrarDetalleInversion(context, item),
            child: _buildInvestmentItem(item),
          )),

          const SizedBox(height: 25),

          // Sección de Noticias/Tips
          const Text(
            'Recomendaciones',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          _buildNewsCard(
            context,
            'Diversifica tu portafolio',
            'Aprende cómo balancear tus inversiones para minimizar riesgos.',
            'La diversificación es una estrategia de gestión de riesgos que combina una amplia variedad de inversiones dentro de una cartera. Una cartera diversificada contiene una combinación de distintos tipos de activos y vehículos de inversión en un intento por limitar la exposición a un solo activo o riesgo.',
            Icons.pie_chart,
            Colors.orange,
          ),
          const SizedBox(height: 10),
           _buildNewsCard(
            context,
            'Tendencias de Mercado',
            'El sector tecnológico muestra un repunte del 3% esta semana.',
            'Las acciones tecnológicas han liderado el mercado esta semana, impulsadas por los avances en inteligencia artificial y resultados trimestrales positivos de las grandes empresas del sector. Los analistas sugieren mantener posiciones pero vigilar la volatilidad a corto plazo.',
            Icons.trending_up,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(double total, double ganancia, double porcentaje) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Valor Total',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            ocultarSaldos ? '****' : '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_upward, color: Colors.greenAccent, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$porcentaje%',
                      style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                ocultarSaldos ? '****' : '+\$${ganancia.toStringAsFixed(2)} rendimientos',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder() {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          final height = 40 + (index * 12) % 80 + (index % 2 * 20); 
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 12,
                height: height.toDouble(),
                decoration: BoxDecoration(
                  color: index == 6 ? Colors.blue : Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ['L', 'M', 'M', 'J', 'V', 'S', 'D'][index],
                style: TextStyle(color: Colors.grey[600], fontSize: 10),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      ('Depositar', Icons.add, Colors.green, () => _mostrarBottomSheetOperacion(context, 'Depositar')),
      ('Retirar', Icons.remove, Colors.orange, () => _mostrarBottomSheetOperacion(context, 'Retirar')),
      ('Análisis', Icons.analytics, Colors.purple, () => _mostrarDialogoAnalisis(context)),
      ('Historial', Icons.history, Colors.blue, () => _mostrarHistorial(context)),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((action) {
        return GestureDetector(
          onTap: action.$4 as VoidCallback,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: action.$3.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(action.$2, color: action.$3),
              ),
              const SizedBox(height: 8),
              Text(
                action.$1,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInvestmentItem((String, double, double) item) {
    final isPositive = item.$3 >= 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isPositive ? Icons.trending_up : Icons.trending_down,
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.$1,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  isPositive ? 'Rendimiento positivo' : 'Requiere atención',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ocultarSaldos ? '****' : '\$${item.$2.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${isPositive ? '+' : ''}${item.$3}%',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, String title, String subtitle, String content, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 18))),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
                const SizedBox(height: 20),
                const Text('Fuente: Análisis Financiero Interno', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cerrar'),
            )
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // --- Funciones de Interacción ---

  void _mostrarBottomSheetOperacion(BuildContext context, String operacion) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              operacion,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monto',
                prefixText: '\$ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Operación "$operacion" realizada con éxito (Simulado)'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Confirmar $operacion'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoAnalisis(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Análisis de Portafolio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              color: Colors.blue[50],
              child: const Center(child: Text('Gráfico Detallado Aquí')),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tu portafolio tiene un rendimiento superior al 85% de los inversores con perfil similar.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _mostrarHistorial(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Historial de Inversiones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildHistoryItem('Compra Apple Inc.', 'Hace 2 días', '- \$500.00'),
                  _buildHistoryItem('Dividendo CETES', 'Hace 5 días', '+ \$120.00'),
                  _buildHistoryItem('Depósito a Fondo', 'Hace 1 semana', '+ \$1,000.00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String titulo, String fecha, String monto) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(titulo),
      subtitle: Text(fecha),
      trailing: Text(
        monto,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: monto.startsWith('+') ? Colors.green : Colors.black,
        ),
      ),
    );
  }

  void _mostrarPortafolioCompleto(BuildContext context, List<dynamic> inversiones) {
    // Aquí podrías navegar a una pantalla más detallada o mostrar un modal full-screen
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
         shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, controller) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Portafolio Completo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: inversiones.map((item) => _buildInvestmentItem(item)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _mostrarDetalleInversion(BuildContext context, (String, double, double) item) {
     showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.$1),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Valor Actual: \$${item.$2.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Rendimiento: ${item.$3}%', 
              style: TextStyle(
                fontSize: 16, 
                color: item.$3 >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 20),
            const Text('Detalles adicionales del instrumento financiero simulados aquí.')
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
               _mostrarBottomSheetOperacion(context, 'Comprar más de ${item.$1}');
            },
            child: const Text('Invertir más'),
          )
        ],
      ),
    );
  }
}
