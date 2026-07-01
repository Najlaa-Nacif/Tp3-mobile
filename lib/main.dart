import 'package:flutter/material.dart';

void main() {
  runApp(const TpFlutterApp());
}

class TpFlutterApp extends StatelessWidget {
  const TpFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TP Flutter Corrigé',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final apps = <_AppItem>[
      _AppItem('App 1', 'StatelessWidget + Interface simple', Icons.widgets, const PresentationPage()),
      _AppItem('App 2', 'StatefulWidget + Compteur', Icons.add_circle, const CounterPage()),
      _AppItem('App 3', 'Liste de produits + panier', Icons.shopping_cart, const ProductsPage()),
      _AppItem('App 4', 'Formulaire login amélioré', Icons.login, const LoginPage()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('TP Flutter Corrigé'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final item = apps[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(child: Icon(item.icon)),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => item.page));
              },
            ),
          );
        },
      ),
    );
  }
}

class _AppItem {
  final String title;
  final String description;
  final IconData icon;
  final Widget page;
  _AppItem(this.title, this.description, this.icon, this.page);
}

class PresentationPage extends StatelessWidget {
  const PresentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application 1')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.flutter_dash, size: 80, color: Colors.blue),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bienvenue dans Flutter',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Application multiplateforme avec des Widgets Material Design.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  void increment() => setState(() => counter++);
  void decrement() => setState(() { if (counter > 0) counter--; });
  void reset() => setState(() => counter = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application 2 - StatefulWidget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Valeur du compteur', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 16),
            Text('$counter', style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: decrement, icon: const Icon(Icons.remove), label: const Text('Moins')),
                const SizedBox(width: 12),
                ElevatedButton.icon(onPressed: reset, icon: const Icon(Icons.refresh), label: const Text('Reset')),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;
  final IconData icon;
  bool selected;

  Product(this.name, this.description, this.price, this.icon, {this.selected = false});
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final products = <Product>[
    Product('PC Portable', 'Lenovo / HP / Dell', 6500, Icons.laptop),
    Product('Smartphone', 'Android ou iOS', 2800, Icons.phone_android),
    Product('Casque', 'Bluetooth', 350, Icons.headphones),
    Product('Clavier', 'USB / Wireless', 180, Icons.keyboard),
  ];

  int get count => products.where((p) => p.selected).length;
  double get total => products.where((p) => p.selected).fold(0, (sum, p) => sum + p.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application 3 - Panier')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('Articles sélectionnés: $count | Total: ${total.toStringAsFixed(0)} DH',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: CheckboxListTile(
                    value: p.selected,
                    secondary: Icon(p.icon, size: 36),
                    title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${p.description}\n${p.price.toStringAsFixed(0)} DH'),
                    onChanged: (value) => setState(() => p.selected = value ?? false),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connexion réussie: ${emailController.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application 4 - Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Icon(Icons.account_circle, size: 100, color: Colors.blue),
                const SizedBox(height: 20),
                const Text('Connexion', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Veuillez saisir email';
                    if (!value.contains('@')) return 'Email invalide';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => obscure = !obscure),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 4) return 'Mot de passe minimum 4 caractères';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: login,
                    icon: const Icon(Icons.login),
                    label: const Text('Se connecter'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
