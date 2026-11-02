import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lzosxcfevifbeznkxojb.supabase.co',
    publishableKey: 'sb_publishable_iqUGDRJ8m8FY1JrlLToYgw_NSyB9hV3',
  );
  runApp(const ProviderScope(child: AlertoApp()));
}
