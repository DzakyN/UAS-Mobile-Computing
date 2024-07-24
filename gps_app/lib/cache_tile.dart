import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart'; // Pastikan ini diimpor untuk Coords

class CachedTileProvider extends TileProvider {
  @override
  ImageProvider getImage(Coords<num> coords, TileLayer options) {
    return CachedNetworkImageProvider(
      getTileUrl(coords, options),
    );
  }

  @override
  String getTileUrl(Coords<num> coords, TileLayer options) {
    return 'https://{s}.tile.openstreetmap.org/${coords.z}/${coords.x}/${coords.y}.png';
  }
}
