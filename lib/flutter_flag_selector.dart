import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/language_provider.dart';

class FlagSelector extends StatefulWidget {
  const FlagSelector({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlagSelectorState createState() => _FlagSelectorState();
}

final List<Map<String, String>> countryList = [
  {"name": "France", "code": "fr"},
  {"name": "États-Unis", "code": "en"},
];

class _FlagSelectorState extends State<FlagSelector> {
  Map<String, String>? _selectedCountry = countryList.first;

  void _openCountryPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Sélectionnez votre pays",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: countryList.length,
                  itemBuilder: (context, index) {
                    final country = countryList[index];
                    return ListTile(
                      leading: Image.asset(
                        'assets/image/${country["code"]}.png',
                        width: 30,
                        height: 20,
                      ),
                      title: Text(country["name"]!),
                      onTap: () {
                        setState(() {
                          _selectedCountry = country;
                        });
                        // Utilisez LanguageProvider pour changer la locale
                        // final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
                        // languageProvider.setLocale(Locale(country["code"]!));
                        print("Nouvelle langue: ${country["code"]}");
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openCountryPicker,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/image/${_selectedCountry!["code"]}.png',
              width: 30,
              height: 20,
            ),
            SizedBox(width: 8),
            Text(
              _selectedCountry!["name"]!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}