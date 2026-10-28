import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart';

/// Application d'exemple de flutter_flag_selector ; les GIF du README en sont issus.
void main() => runApp(const DemoApp());

const _ink = Color(0xFF0A2540);
const _brand = Color(0xFF1B4DFF);
const _muted = Color(0xFF697386);
const _border = Color(0xFFE3E8EE);

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter_flag_selector',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: _brand, surface: Colors.white),
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  FlagSelectorOptionType _mode = FlagSelectorOptionType.modalBottomSheet;
  String _lang = 'en';
  // Même pays de départ que le sélecteur : celui de l'appareil, sinon le premier.
  late Country _country = _deviceCountry();

  static Country _deviceCountry() {
    final code = WidgetsBinding.instance.platformDispatcher.locale.countryCode
        ?.toLowerCase();
    return defaultCountries.firstWhere((c) => c.code == code,
        orElse: () => defaultCountries.first);
  }

  static const _modes = {
    FlagSelectorOptionType.modalBottomSheet: 'Sheet',
    FlagSelectorOptionType.dialog: 'Dialog',
    FlagSelectorOptionType.popupMenu: 'Popup',
    FlagSelectorOptionType.draggableSheet: 'Drag',
  };

  static const _langs = {
    'en': 'EN',
    'fr': 'FR',
    'de': 'DE',
    'es': 'ES',
    'jp': 'JA'
  };

  @override
  Widget build(BuildContext context) {
    final dial = _country.dialCode;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: _brand, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.flag_rounded,
                      color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                const Text('flutter_flag_selector',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _ink)),
              ],
            ),
            const SizedBox(height: 28),
            const Text('Create your account',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                    letterSpacing: -0.5)),
            const SizedBox(height: 6),
            const Text('We will send you a verification code.',
                style: TextStyle(fontSize: 15, color: _muted)),
            const SizedBox(height: 24),
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Label('Country'),
                  const SizedBox(height: 8),
                  FlagSelector(
                    // La clé force la reconstruction quand le mode ou la langue change.
                    key: ValueKey('$_mode-$_lang'),
                    flagSelectorOptionType: _mode,
                    flagSelectorLanguageCode: _lang,
                    flagSelectorInitialCountry: _country.code,
                    flagSelectorFlagWidth: 32,
                    flagSelectorFlagHeight: 22,
                    flagSelectorPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    flagSelectorDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _border),
                    ),
                    flagSelectorTextStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500, color: _ink),
                    onFlagSelectorCountryChanged: (c) =>
                        setState(() => _country = c),
                  ),
                  const SizedBox(height: 18),
                  const _Label('Phone number'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _border),
                    ),
                    child: Row(
                      children: [
                        Text(dial,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _ink)),
                        Container(
                            width: 1,
                            height: 20,
                            color: _border,
                            margin: const EdgeInsets.symmetric(horizontal: 12)),
                        const Text('6 12 34 56 78',
                            style: TextStyle(fontSize: 16, color: _muted)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: _brand,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      child: const Text('Continue',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const _Label('Display mode'),
            const SizedBox(height: 10),
            _Segmented<FlagSelectorOptionType>(
              values: _modes,
              selected: _mode,
              onChanged: (m) => setState(() => _mode = m),
            ),
            const SizedBox(height: 18),
            const _Label('Language'),
            const SizedBox(height: 10),
            _Segmented<String>(
              values: _langs,
              selected: _lang,
              onChanged: (l) => setState(() => _lang = l),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0F0A2540), blurRadius: 20, offset: Offset(0, 6))
        ],
      ),
      child: child,
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: _muted,
          letterSpacing: 0.2));
}

class _Segmented<T> extends StatelessWidget {
  final Map<T, String> values;
  final T selected;
  final ValueChanged<T> onChanged;

  const _Segmented(
      {required this.values, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF1F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (final entry in values.entries)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(entry.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: entry.key == selected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: entry.key == selected
                        ? const [
                            BoxShadow(
                                color: Color(0x140A2540),
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: entry.key == selected ? _ink : _muted,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
