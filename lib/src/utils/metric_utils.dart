import '../models/metric_value_level.dart';

/// Returns a threshold from [Map] based [config] for metrics with [metricId] otherwise [defaultValue]
T readThreshold<T extends num>(
  Map<String, Object> config,
  String metricId,
  T defaultValue,
) {
  final configValue = config[metricId] as String;

  if (configValue != null && T == int) {
    return int.tryParse(configValue) as T ?? defaultValue;
  } else if (configValue != null && T == double) {
    return double.tryParse(configValue) as T ?? defaultValue;
  }

  return defaultValue;
}

MetricValueLevel valueLevel(num value, num warningLevel) {
  if (value == null || warningLevel == null) {
    return MetricValueLevel.none;
  }

  if (value > warningLevel * 2) {
    return MetricValueLevel.alarm;
  } else if (value > warningLevel) {
    return MetricValueLevel.warning;
  } else if (value > warningLevel * 0.8) {
    return MetricValueLevel.noted;
  }

  return MetricValueLevel.none;
}
