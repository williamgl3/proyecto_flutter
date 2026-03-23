import 'package:flutter/material.dart';

class PantallaCuentas extends StatelessWidget {
  const PantallaCuentas({super.key});

  @override
  Widget build(BuildContext context) {
    final cuentas = <_CuentaBanco>[
      const _CuentaBanco(
        nombre: 'Cuenta Nomina',
        numeroCuenta: '**** 1287',
        clabe: '012 345 678901234567',
        saldoDisponible: 18450.75,
        saldoRetenido: 1250.00,
        moneda: 'MXN',
        estado: 'Activa',
      ),
      const _CuentaBanco(
        nombre: 'Cuenta Ahorro Meta Viaje',
        numeroCuenta: '**** 9042',
        clabe: '012 345 678901239042',
        saldoDisponible: 65230.10,
        saldoRetenido: 0,
        moneda: 'MXN',
        estado: 'Activa',
      ),
    ];

    final totalDisponible = cuentas.fold<double>(
      0,
      (acumulado, cuenta) => acumulado + cuenta.saldoDisponible,
    );
    final totalRetenido = cuentas.fold<double>(
      0,
      (acumulado, cuenta) => acumulado + cuenta.saldoRetenido,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cuentas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Entrando a: Abrir cuenta'),
                      duration: Duration(milliseconds: 1500),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Abrir cuenta'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _ResumenCuentas(
            totalDisponible: totalDisponible,
            totalRetenido: totalRetenido,
          ),
          const SizedBox(height: 20),
          const Text(
            'Mis cuentas bancarias',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...cuentas.map(_tarjetaCuenta),
          const SizedBox(height: 20),
          const Text(
            'Acciones rapidas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _AccionCuenta(icono: Icons.swap_horiz, texto: 'Transferir'),
              _AccionCuenta(icono: Icons.qr_code_scanner, texto: 'Cobrar'),
              _AccionCuenta(icono: Icons.receipt_long, texto: 'Pagar servicio'),
              _AccionCuenta(
                  icono: Icons.account_balance, texto: 'Estado cuenta'),
            ],
          ),
          const SizedBox(height: 20),
          _InfoOperativa(cuentaPrincipal: cuentas.first),
        ],
      ),
    );
  }

  Widget _tarjetaCuenta(_CuentaBanco cuenta) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cuenta.nombre,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    cuenta.estado,
                    style: const TextStyle(
                      color: Color(0xFF166534),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Cuenta ${cuenta.numeroCuenta}',
              style: const TextStyle(color: Colors.black54),
            ),
            Text(
              'CLABE ${cuenta.clabe}',
              style: const TextStyle(color: Colors.black54),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _datoSaldo('Disponible', cuenta.saldoDisponible, cuenta.moneda),
                _datoSaldo('Retenido', cuenta.saldoRetenido, cuenta.moneda),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _datoSaldo(String etiqueta, double valor, String moneda) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 2),
        Text(
          r'$' + _formatearMoneda(valor) + ' ' + moneda,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  String _formatearMoneda(double monto) {
    return monto.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }
}

class _ResumenCuentas extends StatelessWidget {
  final double totalDisponible;
  final double totalRetenido;

  const _ResumenCuentas({
    required this.totalDisponible,
    required this.totalRetenido,
  });

  @override
  Widget build(BuildContext context) {
    final totalGeneral = totalDisponible + totalRetenido;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F3B82), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saldo total en cuentas',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            r'$' + _formatearMoneda(totalGeneral) + ' MXN',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _resumenDato('Disponible', totalDisponible),
              ),
              Expanded(
                child: _resumenDato('Retenido', totalRetenido),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resumenDato(String titulo, double valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 2),
        Text(
          r'$' + _formatearMoneda(valor),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  String _formatearMoneda(double monto) {
    return monto.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }
}

class _AccionCuenta extends StatelessWidget {
  final IconData icono;
  final String texto;

  const _AccionCuenta({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Entrando a: $texto'),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.green,
          ),
        );
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 18, color: const Color(0xFF1E3A8A)),
            const SizedBox(width: 8),
            Text(
              texto,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoOperativa extends StatelessWidget {
  final _CuentaBanco cuentaPrincipal;

  const _InfoOperativa({required this.cuentaPrincipal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Datos para recibir transferencias',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _filaDato('Banco', 'Banco BBVA'),
          _filaDato('Titular', 'Stephanie Jones'),
          _filaDato('CLABE', cuentaPrincipal.clabe),
          _filaDato('Numero de cuenta', cuentaPrincipal.numeroCuenta),
          _filaDato('Tipo de deposito', 'SPEI 24/7'),
        ],
      ),
    );
  }

  Widget _filaDato(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              etiqueta,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            valor,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _CuentaBanco {
  final String nombre;
  final String numeroCuenta;
  final String clabe;
  final double saldoDisponible;
  final double saldoRetenido;
  final String moneda;
  final String estado;

  const _CuentaBanco({
    required this.nombre,
    required this.numeroCuenta,
    required this.clabe,
    required this.saldoDisponible,
    required this.saldoRetenido,
    required this.moneda,
    required this.estado,
  });
}
