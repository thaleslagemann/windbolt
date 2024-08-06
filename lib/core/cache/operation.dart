import 'dart:convert';
import 'dart:developer';

import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

enum OperationStatus { SUCCESS, FAILURE, PENDING, EXECUTING }

class Operation {
  final String uuid;
  final String name;
  final String slug;
  final String? rawData;
  final String? rawMetadata;
  String? rawResponse;
  final String? method;
  final String? endpoint;
  OperationStatus status;
  DateTime timestamp;

  Operation({
    String? uuid,
    required this.name,
    required this.slug,
    String? data,
    String? metadata,
    String? response,
    String? method,
    this.endpoint,
    OperationStatus? status,
    String? timestamp,
  })  : uuid = uuid ?? const Uuid().v4(),
        rawData = data,
        rawMetadata = metadata,
        rawResponse = response,
        method = method ?? 'GET',
        status = status ?? OperationStatus.PENDING,
        timestamp = timestamp != null ? DateTime.parse(timestamp) : DateTime.now();

  bool get isExecutable => endpoint != null && (status == OperationStatus.PENDING || status == OperationStatus.FAILURE);

  String? get data {
    return data;
  }

  get response {
    return response;
  }

  Future<T> execute<T extends Operation>() async {
    if (endpoint == null || endpoint!.isEmpty) {
      return this as T;
    }
    OperationStatus initialStatus = status;

    status = OperationStatus.EXECUTING;

    try {
      int statusCode = 0;
      switch (method) {
        case 'GET':
          log(endpoint! + slug);
          final response = await http.get(Uri.parse(endpoint! + slug));

          statusCode = response.statusCode;
          if (response.statusCode == 201) {
            rawResponse = jsonEncode(response.body);
          }
          if (statusCode == 201 || statusCode == 409) {
            status = OperationStatus.SUCCESS;
          } else {
            status = initialStatus;
          }
          break;
        case 'POST':
          if (rawData == null) {
            throw Exception('Data is required for POST method');
          }

          log("reaching for ${endpoint! + slug}");
          final res = await http.post(
            Uri.parse(endpoint! + slug),
            headers: {
              'Content-Type': 'application/json',
            },
            body: rawData!,
          );
          log("Response body: ${res.body}");
          statusCode = res.statusCode;
          if (res.statusCode == 201) {
            rawResponse = jsonEncode(res.body);
          }
          break;
      }
    } catch (e) {
      log(e.toString());
    }
    return this as T;
  }

  Map<String, String?> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'slug': slug,
      'data': rawData,
      'metadata': rawMetadata,
      'response': rawResponse,
      'method': method,
      'endpoint': endpoint,
      'status': status.name,
      'timestamp': timestamp.toString(),
    };
  }

  String toJson() => json.encode(toMap());

  Operation fromJson(Map<String, dynamic> map) {
    return Operation(
      uuid: map['uuid'],
      name: map['name'],
      slug: map['slug'],
      data: map['data'],
      metadata: map['metadata'],
      response: map['response'],
      method: map['method'],
      endpoint: map['endpoint'],
      status: OperationStatus.values.firstWhere((e) => e.name == map['status']),
      timestamp: map['timestamp'],
    );
  }
}
