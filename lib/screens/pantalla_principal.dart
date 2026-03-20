import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';
import '../widgets/encabezado_perfil.dart';
import '../widgets/carrusel_tarjetas.dart';
import '../widgets/resumen_balance.dart';
import '../widgets/item_movimiento.dart';
import '../models/tarjeta_model.dart';
import '../models/movimiento_model.dart';
import 'pantalla_cuentas.dart';
import 'pantalla_inversiones.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int indiceSeleccionado = 0;

  final List<String> opcionesMenu = [
    'Tarjetas',
    'Cuentas',
    'Movimientos',
    'Inversiones',
    'Configuración'
  ];

  void cambiarOpcion(int indice) {
    setState(() {
      indiceSeleccionado = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menú lateral
          MenuLateral(
            opciones: opcionesMenu,
            indiceSeleccionado: indiceSeleccionado,
            onItemTapped: cambiarOpcion,
          ),

          // Contenido principal
          Expanded(
            child: Column(
              children: [
                // Encabezado con perfil
                const EncabezadoPerfil(
                  nombre: 'Stephanie Jones',
                  saludo: 'Bienvenida',
                ),

                // Contenido según la opción seleccionada
                Expanded(
                  child: _construirContenido(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirContenido() {
    switch (indiceSeleccionado) {
      case 0:
        return const PantallaTarjetas();
      case 1:
        return const PantallaCuentas();
      case 2:
        return const PantallaMovimientos();
      case 3:
        return const PantallaInversiones();
      default:
        return PantallaGenerica(titulo: opcionesMenu[indiceSeleccionado]);
    }
  }
}

// Pantalla de Tarjetas
class PantallaTarjetas extends StatelessWidget {
  const PantallaTarjetas({super.key});

  @override
  Widget build(BuildContext context) {
    final tarjetas = TarjetaModel.tarjetasEjemplo();
    final movimientos = MovimientoModel.movimientosRecientes();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tus Tarjetas',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('+ Agregar Tarjeta'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Carrusel de tarjetas
          CarruselTarjetas(tarjetas: tarjetas),
          const SizedBox(height: 30),

          // Resumen de balance
          const ResumenBalance(
            balance: 2505,
            gastos: 343,
            ingresos: 950,
            mes: 227,
          ),
          const SizedBox(height: 30),

          // Movimientos recientes
          const Text(
            'Movimientos Recientes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movimientos.length,
            itemBuilder: (context, index) {
              return ItemMovimiento(movimiento: movimientos[index]);
            },
          ),
        ],
      ),
    );
  }
}

// Pantalla de Movimientos
class PantallaMovimientos extends StatelessWidget {
  const PantallaMovimientos({super.key});

  @override
  Widget build(BuildContext context) {
    final movimientos = MovimientoModel.movimientosEjemplo();

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: movimientos.length,
      itemBuilder: (context, index) {
        return ItemMovimiento(movimiento: movimientos[index]);
      },
    );
  }
}

// Pantalla genérica para otras opciones
class PantallaGenerica extends StatelessWidget {
  final String titulo;
  const PantallaGenerica({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Pantalla de $titulo',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
