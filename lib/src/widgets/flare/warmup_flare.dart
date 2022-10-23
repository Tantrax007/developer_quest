import 'package:flare_flutter/flare_cache.dart';

/// Ensure all Flare assets used by this app are cached and ready to
/// be displayed as quickly as possible.
Future<void> warmupFlare() async {
  await cachedActor();
  await Future<void>.delayed(const Duration(milliseconds: 16));
}
