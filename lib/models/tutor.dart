/// Simple data model for a tutor card.
/// NOTE: In this activity, all tutor data is FICTIONAL demo data.
class Tutor {
  final String name;
  final String subject;
  final int hourlyRate; // in Philippine pesos
  final double rating; // 0.0 - 5.0

  const Tutor({
    required this.name,
    required this.subject,
    required this.hourlyRate,
    required this.rating,
  });
}
