/*
 *  A Dart package for Image Caching
 *
 *  Copyright (c) 2020 Vaibhav Bhasin
 *  LinkedIn : https://www.linkedin.com/in/vaibhavbhasin04
 *
 *  Released under MIT License.
 */

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vb_image_cache/vb_resource.dart';

class VBCacheImage extends ImageProvider<VBCacheImage> {
  VBCacheImage(
    String url, {
    this.scale = 1.0,
    this.cache = true,
    this.duration = const Duration(seconds: 1),
    this.durationMultiplier = 1.5,
    this.durationExpiration = const Duration(seconds: 10),
  })  : assert(url != null),
        _resource = VBResource(url, duration, durationMultiplier, durationExpiration);

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// Enable or disable image caching.
  final bool cache;

  /// Retry duration if download fails.
  final Duration duration;

  /// Retry duration multiplier.
  final double durationMultiplier;

  /// Retry duration expiration.
  final Duration durationExpiration;

  VBResource _resource;

  Future<Codec> _fetchImage() async {
    Uint8List file;
    await _resource.init();
    final bool check = await _resource.checkFile();
    if (check) {
      file = await _resource.getFile();
    } else {
      file = await _resource.storeFile();
    }
    if (file.length > 0) {
      return PaintingBinding.instance.instantiateImageCodec(file);
    }
    return null;
  }

  @override
  Future<VBCacheImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<VBCacheImage>(this);
  }

  @override
  ImageStreamCompleter load(VBCacheImage key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
        codec: key._fetchImage(),
        scale: key.scale,
        informationCollector: () sync* {
          yield DiagnosticsProperty<ImageProvider>('Image provider: $this \n Image key: $key', this,
              style: DiagnosticsTreeStyle.errorProperty);
        });
  }
}
