// Copyright (c) 2017, Matan Lurey.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

/// Returns true if [object] is considered a primitive type.
bool isPrimitive(Object object) =>
    object is num ||
    object is bool ||
    object is String ||
    object == null;

/// Returns a clone of [object].
///
/// **NOTE**: It is strongly preferable to use a `cloneX` method when you know
/// the the type of the object ahead-of-time. This avoids runtime checks!
T cloneAny<T>(T object) {
  if (isPrimitive(object)) {
    return object;
  }
  if (object is List) {
    return cloneList<dynamic>(object) as T;
  }
  if (object is Map) {
    return cloneMap<dynamic, dynamic>(object) as T;
  }
  if (object is Set) {
    return cloneSet<dynamic>(object) as T;
  }
  throw new ArgumentError('Cannot clone: $object.');
}

/// Returns a clone of [list].
List<T> cloneList<T>(List<T> list, {bool deep: false}) {
  return deep ? list.map(cloneAny).toList() : list.toList();
}

/// Returns a clone of [map].
Map<K, V> cloneMap<K, V>(Map<K, V> map, {bool deep: false}) {
  final clone = map is HashMap ? new HashMap<K, V>() : <K, V>{};
  if (deep) {
    map.forEach((key, value) {
      clone[cloneAny(key)] = cloneAny(value);
    });
  } else {
    clone.addAll(map);
  }
  return clone;
}

/// Returns a clone of [set].
Set<T> cloneSet<T>(Set<T> set, {bool deep: false}) {
  return deep ? set.map(cloneAny).toSet(): set.toSet();
}
