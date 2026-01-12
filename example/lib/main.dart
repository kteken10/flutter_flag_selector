import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart';

void main() {
  CountryService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Flag Selector Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExamplesPage(),
    );
  }
}

class ExamplesPage extends StatelessWidget {
  const ExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Picker Examples'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select an example to see different implementations of the Flutter Flag Selector:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          _ExampleCard(
            title: 'Example 1: Basic Country Picker',
            description: 'Simple country picker with default settings',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BasicExample()),
            ),
          ),
          _ExampleCard(
            title: 'Example 2: Phone Number Input',
            description: 'Country picker integrated with phone number input field',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PhoneNumberExample()),
            ),
          ),
          _ExampleCard(
            title: 'Example 3: Customized Bottom Sheet',
            description: 'Beautifully customized bottom sheet with custom styling',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomizedBottomSheetExample()),
            ),
          ),
          _ExampleCard(
            title: 'Example 4: Dialog Mode',
            description: 'Country picker displayed as a centered dialog',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DialogExample()),
            ),
          ),
          _ExampleCard(
            title: 'Example 5: Popup Menu Mode',
            description: 'Compact popup menu for space-constrained layouts',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PopupMenuExample()),
            ),
          ),
          _ExampleCard(
            title: 'Example 6: Multi-Language Support',
            description: 'Switch between different languages for country names',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MultiLanguageExample()),
            ),
          ),
          _ExampleCard(
            title: 'Example 7: Form Integration',
            description: 'Country picker integrated with Flutter forms',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FormExample()),
            ),
          ),
          _ExampleCard(
            title: 'Example 8: Custom Styling',
            description: 'Fully customized appearance with custom colors and decorations',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomStylingExample()),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ExampleCard({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

// Example 1: Basic Country Picker
class BasicExample extends StatelessWidget {
  const BasicExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Country Picker')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select your country',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              FlagSelector(
                onFlagSelectorCountryChanged: (country) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${country.name} (${country.dialCode})'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 2: Phone Number Input
class PhoneNumberExample extends StatefulWidget {
  const PhoneNumberExample({super.key});

  @override
  State<PhoneNumberExample> createState() => _PhoneNumberExampleState();
}

class _PhoneNumberExampleState extends State<PhoneNumberExample> {
  Country? selectedCountry;
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Number Input')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlagSelector(
              flagSelectorInitialCountry: selectedCountry?.code ?? 'us',
              onFlagSelectorCountryChanged: (country) {
                setState(() {
                  selectedCountry = country;
                  phoneController.text = country.dialCode;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
            if (selectedCountry != null) ...[
              const SizedBox(height: 20),
              Text(
                'Selected: ${selectedCountry!.name}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Dial Code: ${selectedCountry!.dialCode}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Example 3: Customized Bottom Sheet
class CustomizedBottomSheetExample extends StatelessWidget {
  const CustomizedBottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customized Bottom Sheet')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Customized Country Picker',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              FlagSelector(
                flagSelectorOptionType: FlagSelectorOptionType.modalBottomSheet,
                flagSelectorModalTitle: 'Choose Your Country',
                flagSelectorModalTitleStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                flagSelectorSelectedCountryItemColor: Colors.blue.shade100,
                flagSelectorCountryItemHeight: 60.0,
                flagSelectorDecoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                onFlagSelectorCountryChanged: (country) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${country.name}'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 4: Dialog Mode
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Mode')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Country Picker in Dialog',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              FlagSelector(
                flagSelectorOptionType: FlagSelectorOptionType.dialog,
                flagSelectorModalTitle: 'Select Country',
                flagSelectorModalHeightFactor: 0.8,
                onFlagSelectorCountryChanged: (country) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${country.name}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 5: Popup Menu Mode
class PopupMenuExample extends StatelessWidget {
  const PopupMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popup Menu Mode')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Compact Popup Menu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              FlagSelector(
                flagSelectorOptionType: FlagSelectorOptionType.popupMenu,
                flagSelectorWidth: 200,
                flagSelectorHeight: 50,
                onFlagSelectorCountryChanged: (country) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${country.name}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 6: Multi-Language Support
class MultiLanguageExample extends StatefulWidget {
  const MultiLanguageExample({super.key});

  @override
  State<MultiLanguageExample> createState() => _MultiLanguageExampleState();
}

class _MultiLanguageExampleState extends State<MultiLanguageExample> {
  String currentLanguage = 'en';
  Country? selectedCountry;

  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'fr', 'name': 'French'},
    {'code': 'es', 'name': 'Spanish'},
    {'code': 'de', 'name': 'German'},
    {'code': 'it', 'name': 'Italian'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi-Language Support')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: currentLanguage,
              isExpanded: true,
              items: languages.map((lang) {
                return DropdownMenuItem(
                  value: lang['code'],
                  child: Text(lang['name']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  currentLanguage = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Country',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FlagSelector(
              flagSelectorLanguageCode: currentLanguage,
              onFlagSelectorCountryChanged: (country) {
                setState(() {
                  selectedCountry = country;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${country.getName(currentLanguage)}'),
                  ),
                );
              },
            ),
            if (selectedCountry != null) ...[
              const SizedBox(height: 24),
              Text(
                'Country Name: ${selectedCountry!.getName(currentLanguage)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Example 7: Form Integration
class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  Country? selectedCountry;
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Integration')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'User Registration Form',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FlagSelector(
                flagSelectorInitialCountry: selectedCountry?.code,
                onFlagSelectorCountryChanged: (country) {
                  setState(() {
                    selectedCountry = country;
                  });
                },
              ),
              if (selectedCountry == null)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please select a country',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && selectedCountry != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Form submitted: ${nameController.text} from ${selectedCountry!.name}',
                        ),
                      ),
                    );
                  } else if (selectedCountry == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a country'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 8: Custom Styling
class CustomStylingExample extends StatelessWidget {
  const CustomStylingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Styling')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Fully Customized Country Picker',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              FlagSelector(
                flagSelectorDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                flagSelectorTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                flagSelectorFlagWidth: 40,
                flagSelectorFlagHeight: 30,
                flagSelectorGap: 12,
                flagSelectorModalTitle: 'Choose Country',
                flagSelectorModalTitleStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                flagSelectorSelectedCountryItemColor: Colors.purple.shade100,
                flagSelectorCountryItemHeight: 60.0,
                onFlagSelectorCountryChanged: (country) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${country.name}'),
                      backgroundColor: Colors.purple,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
