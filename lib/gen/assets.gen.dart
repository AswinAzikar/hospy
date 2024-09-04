/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsJpgGen {
  const $AssetsJpgGen();

  /// File path: assets/jpg/profile_photo.jpg
  AssetGenImage get profilePhoto =>
      const AssetGenImage('assets/jpg/profile_photo.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [profilePhoto];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/landing_image_png.png
  AssetGenImage get landingImagePng =>
      const AssetGenImage('assets/png/landing_image_png.png');

  /// List of all assets
  List<AssetGenImage> get values => [landingImagePng];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/care.svg
  String get care => 'assets/svg/care.svg';

  /// File path: assets/svg/enter_otp.svg
  String get enterOtp => 'assets/svg/enter_otp.svg';

  /// File path: assets/svg/get_started.svg
  String get getStarted => 'assets/svg/get_started.svg';

  /// File path: assets/svg/phone_auth.svg
  String get phoneAuth => 'assets/svg/phone_auth.svg';

  /// File path: assets/svg/tell_us_more.svg
  String get tellUsMore => 'assets/svg/tell_us_more.svg';

  /// List of all assets
  List<String> get values =>
      [care, enterOtp, getStarted, phoneAuth, tellUsMore];
}

class Assets {
  Assets._();

  static const $AssetsJpgGen jpg = $AssetsJpgGen();
  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
