class MovimientoModel {
  final String comercio;
  final String banco;
  final String tipoTarjeta;
  final double monto;
  final String categoria;
  final DateTime fecha;
  final bool esIngreso;

  MovimientoModel({
    required this.comercio,
    required this.banco,
    required this.tipoTarjeta,
    required this.monto,
    required this.categoria,
    required this.fecha,
    required this.esIngreso,
  });

  String get fechaFormateada {
    final now = DateTime.now();
    final difference = now.difference(fecha).inDays;
    
    if (difference == 0) return 'Hoy';
    if (difference == 1) return 'Ayer';
    if (difference < 7) return 'Hace $difference días';
    return '${fecha.day} ${_getMes(fecha.month)} ${fecha.year}';
  }

  String _getMes(int mes) {
    const meses = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
    ];
    return meses[mes - 1];
  }

  // Datos de ejemplo
  static List<MovimientoModel> movimientosEjemplo() {
    final now = DateTime.now();
    return [
      MovimientoModel(
        comercio: 'Amazon',
        banco: 'Citibank Plus',
        tipoTarjeta: 'Visa',
        monto: 253,
        categoria: 'Compras',
        fecha: now,
        esIngreso: false,
      ),
      MovimientoModel(
        comercio: 'Walmart',
        banco: 'Citibank',
        tipoTarjeta: 'Visa',
        monto: 79,
        categoria: 'Supermercado',
        fecha: now.subtract(const Duration(days: 1)),
        esIngreso: false,
      ),
      MovimientoModel(
        comercio: 'Supermercados',
        banco: 'Varios',
        tipoTarjeta: 'Débito',
        monto: 534,
        categoria: 'Supermercado',
        fecha: now.subtract(const Duration(days: 2)),
        esIngreso: false,
      ),
      MovimientoModel(
        comercio: 'Restaurantes',
        banco: 'Varios',
        tipoTarjeta: 'Crédito',
        monto: 343,
        categoria: 'Comida',
        fecha: now.subtract(const Duration(days: 3)),
        esIngreso: false,
      ),
      MovimientoModel(
        comercio: 'Uber',
        banco: 'Citibank',
        tipoTarjeta: 'Visa',
        monto: 45,
        categoria: 'Transporte',
        fecha: now.subtract(const Duration(days: 3)),
        esIngreso: false,
      ),
      MovimientoModel(
        comercio: 'Netflix',
        banco: 'Chase',
        tipoTarjeta: 'Mastercard',
        monto: 15.99,
        categoria: 'Entretenimiento',
        fecha: now.subtract(const Duration(days: 5)),
        esIngreso: false,
      ),
      MovimientoModel(
        comercio: 'Salario',
        banco: 'Empresa',
        tipoTarjeta: 'Depósito',
        monto: 4950,
        categoria: 'Ingreso',
        fecha: DateTime(now.year, now.month, 1),
        esIngreso: true,
      ),
    ];
  }

  static List<MovimientoModel> movimientosRecientes() {
    return movimientosEjemplo().where((m) => !m.esIngreso).take(4).toList();
  }
}