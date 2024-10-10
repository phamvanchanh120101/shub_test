class Transaction {
  final int id;
  final DateTime date;
  final String time;
  final String station;
  final String pump;
  final String product;
  final double quantity;
  final double unitPrice;
  final double totalAmount;
  final String paymentStatus;
  final String customerCode;
  final String customerName;
  final String customerType;
  final DateTime paymentDate;
  final String employee;
  final String vehicleNumber;
  final String invoiceStatus;

  Transaction({
    required this.id,
    required this.date,
    required this.time,
    required this.station,
    required this.pump,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
    required this.paymentStatus,
    required this.customerCode,
    required this.customerName,
    required this.customerType,
    required this.paymentDate,
    required this.employee,
    required this.vehicleNumber,
    required this.invoiceStatus,
  });
}
