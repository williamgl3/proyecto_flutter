import 'package:flutter/material.dart';

class PantallaConfiguracion extends StatefulWidget {
  final bool ocultarSaldos;
  final ValueChanged<bool> onOcultarSaldosChanged;

  const PantallaConfiguracion({
    super.key,
    required this.ocultarSaldos,
    required this.onOcultarSaldosChanged,
  });

  @override
  State<PantallaConfiguracion> createState() => _PantallaConfiguracionState();
}

class _PantallaConfiguracionState extends State<PantallaConfiguracion> {
  bool _notificaciones = true;
  bool _biometria = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Configuración',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Perfil
          _buildSectionHeader('Perfil'),
          _buildProfileCard(),
          const SizedBox(height: 25),

          // General
          _buildSectionHeader('General'),
          _buildSwitchItem(
            'Ocultar Saldos',
            'Oculta los montos en todas las pantallas por privacidad',
            Icons.visibility_off,
            widget.ocultarSaldos,
            (val) {
              widget.onOcultarSaldosChanged(val);
              _mostrarSnackBar(context, 'Entrando a: Ocultar Saldos');
            },
          ),
          _buildSwitchItem(
            'Notificaciones Push',
            'Recibe alertas de movimientos y ofertas',
            Icons.notifications_active,
            _notificaciones,
            (val) {
              setState(() => _notificaciones = val);
              _mostrarSnackBar(context, 'Entrando a: Notificaciones Push');
            },
          ),

          const SizedBox(height: 25),

          // Seguridad
          _buildSectionHeader('Seguridad'),
          _buildSwitchItem(
            'Biometría',
            'Usar huella o rostro para ingresar',
            Icons.fingerprint,
            _biometria,
            (val) {
              setState(() => _biometria = val);
              _mostrarSnackBar(context, 'Entrando a: Biometría');
            },
          ),
          _buildActionItem(
            'Cambiar Contraseña',
            Icons.lock_outline,
            () {
              _mostrarSnackBar(context, 'Entrando a: Cambio de Contraseña');
              _mostrarDialogoConstruccion(context, 'Cambio de Contraseña');
            },
          ),

          const SizedBox(height: 25),

          // Soporte
          _buildSectionHeader('Soporte'),
          _buildActionItem(
            'Ayuda y Soporte',
            Icons.help_outline,
            () {
              _mostrarSnackBar(context, 'Entrando a: Centro de Ayuda');
              _mostrarDialogoConstruccion(context, 'Centro de Ayuda');
            },
          ),
          _buildActionItem(
            'Términos y Condiciones',
            Icons.description_outlined,
            () {
              _mostrarSnackBar(context, 'Entrando a: Términos Legales');
              _mostrarDialogoConstruccion(context, 'Términos Legales');
            },
          ),

          const SizedBox(height: 30),
          Center(
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cerrando sesión...'),
                    duration: Duration(milliseconds: 1500),
                    backgroundColor: Color(0xFFDC2626),
                  ),
                );
                _mostrarDialogoCerrarSesion(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Cerrar Sesión'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
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
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=200&q=80',
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stephanie Jones',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'stephanie.jones@email.com',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () =>
                _mostrarDialogoConstruccion(context, 'Editar Perfil'),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        activeThumbColor: Colors.blue,
      ),
    );
  }

  Widget _buildActionItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.black87),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }

  void _mostrarSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(milliseconds: 500),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _mostrarDialogoConstruccion(BuildContext context, String titulo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: const Text('Esta funcionalidad está en desarrollo.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás segura de que quieres salir?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _mostrarSnackBar(context, 'Entrando a: Cerrar Sesión');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sesión cerrada (Simulado)')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Salir'),
          ),
        ],
      ),
    );
  }
}
