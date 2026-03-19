class TarjetaModel {
  final String titular;
  final double balance;
  final double sobregiro;
  final String numeroTarjeta;
  final String fechaExpiracion;
  final String tipo;
  final String banco;
  final bool esPrincipal;

  TarjetaModel({
    required this.titular,
    required this.balance,
    required this.sobregiro,
    required this.numeroTarjeta,
    required this.fechaExpiracion,
    required this.tipo,
    required this.banco,
    this.esPrincipal = false,
  });

  // Datos de ejemplo
  static List<TarjetaModel> tarjetasEjemplo() {
    return [
      TarjetaModel(
        titular: 'Stephanie Jones',
        balance: 2505,
        sobregiro: 3125,
        numeroTarjeta: '**** **** **** 7230',
        fechaExpiracion: '12/25',
        tipo: 'Visa',
        banco: 'Citibank',
        esPrincipal: true,
      ),
      TarjetaModel(
        titular: 'Stephanie Jones',
        balance: 5430,
        sobregiro: 2000,
        numeroTarjeta: '**** **** **** 4567',
        fechaExpiracion: '09/24',
        tipo: 'Mastercard',
        banco: 'Chase',
        esPrincipal: false,
      ),
      TarjetaModel(
        titular: 'Stephanie Jones',
        balance: 1250,
        sobregiro: 1000,
        numeroTarjeta: '**** **** **** 8901',
        fechaExpiracion: '03/26',
        tipo: 'American Express',
        banco: 'Amex',
        esPrincipal: false,
      ),
    ];
  }

  static TarjetaModel tarjetaPrincipal() {
    return tarjetasEjemplo().firstWhere((t) => t.esPrincipal);
  }
}