# VBImageCache

[![pub package](https://img.shields.io/pub/v/cache_image.svg)](https://pub.dartlang.org/packages/cache_image)

A Flutter plugin to load and cache network or firebase storage images with a retry mechanism if the download fails.

This package supports the download of images from a standard *network path* and from a *firebase storage gs path*.

Images are stored in the temporary directory of the app.

## Usage

To use this plugin, add firebase_storage as a dependency in your pubspec.yaml file.

```
dependencies:
  vb_image_cache: "^1.0.0"

```

Import vb_image_cache in a dart file:
```
import 'package:cache_image/vb_image_cache.dart';
```

To support firebase storage download the generated google-services.json file and place it inside android/app. Next, modify the android/build.gradle file and the android/app/build.gradle file to add the Google services plugin as described by the Firebase assistant.

## How to use

VBCacheImage can be used with any widget that support an ImageProvider.

``` dart
Image(
    fit: BoxFit.cover,
    image: VBCacheImage('https://paste-your-link-here.com/image.png'),
),
Image(
    fit: BoxFit.cover,
    image: VBCacheImage('https://paste-your-link-here.com/image.png', duration: Duration(seconds: 2), durationExpiration: Duration(seconds: 10)),
),
FadeInImage(
    fit: BoxFit.cover,
    placeholder: AssetImage('assets/placeholder.png'),
    image: VBCacheImage('https://paste-your-link-here.com/image.png')
)
 ```

See the `example` directory for a complete sample app using Cache Image.

An extension to [cache_image](https://github.com/oxequa/flutter_cache_image) library.