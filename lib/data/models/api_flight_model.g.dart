// Hand-written Hive TypeAdapter for ApiFlightModel.
/// Replaces what build_runner would generate — no code generation required.
/// If you add/remove @HiveField fields in api_flight_model.dart, update
/// the read/write methods here accordingly.

import 'package:hive_flutter/hive_flutter.dart';
import 'api_flight_model.dart';

class ApiFlightModelAdapter extends TypeAdapter<ApiFlightModel> {
  @override
  final int typeId = 0;

  @override
  ApiFlightModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApiFlightModel(
      id: fields[0] as String,
      airline: fields[1] as String,
      flightNumber: fields[2] as String,
      departureAirport: fields[3] as String,
      arrivalAirport: fields[4] as String,
      departureTime: fields[5] as String,
      arrivalTime: fields[6] as String,
      duration: fields[7] as String,
      price: fields[8] as int,
      travelClass: fields[9] as String,
      airlineLogo: fields[10] as String,
      departureCity: fields[11] as String,
      arrivalCity: fields[12] as String,
      date: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ApiFlightModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.airline)
      ..writeByte(2)
      ..write(obj.flightNumber)
      ..writeByte(3)
      ..write(obj.departureAirport)
      ..writeByte(4)
      ..write(obj.arrivalAirport)
      ..writeByte(5)
      ..write(obj.departureTime)
      ..writeByte(6)
      ..write(obj.arrivalTime)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.travelClass)
      ..writeByte(10)
      ..write(obj.airlineLogo)
      ..writeByte(11)
      ..write(obj.departureCity)
      ..writeByte(12)
      ..write(obj.arrivalCity)
      ..writeByte(13)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiFlightModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
