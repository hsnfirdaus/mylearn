import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylearn/components/custom_controller.dart';
import 'package:mylearn/components/input_label.dart';
import 'package:mylearn/components/select_class.dart';
import 'package:mylearn/router.dart';
import 'package:mylearn/style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

final supabase = Supabase.instance.client;

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(
    text: supabase.auth.currentUser?.userMetadata?['full_name'],
  );
  final CustomController _classController = CustomController();

  Future doSubmit() async {
    final res = await supabase.from("student").upsert({
      'nim': _nimController.text,
      'user_id': supabase.auth.currentUser!.id,
      'name': _nameController.text,
      'email': supabase.auth.currentUser!.email,
      'class_id': _classController.value!['id'],
    });
    if (res?.error == null) {
      await supabase.auth.updateUser(UserAttributes(data: {'isBoarded': true}));
      toHome();
    } else {
      showError('Error: ${res.error.message}');
    }
  }

  void toHome() {
    context.pushReplacement(AppRoute.home);
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/icon.png'),
                fit: BoxFit.contain,
                width: 60,
                height: 60,
              ),
              SizedBox(height: 12),
              Text(
                "Atur Akun Kamu",
                style: AppTextStyles.heading2,
                textAlign: TextAlign.center,
              ),
              Text(
                "Isi data dirimu sebelum mulai menggunakan aplikasi",
                style: AppTextStyles.bodyText,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              InputLabel(
                label: "Nomor Induk Mahasiswa",
                hintText: "43xxxxxxx",
                controller: _nimController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "NIM tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              InputLabel(
                label: "Nama Lengkap",
                hintText: "Masukkan Nama Anda...",
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              SelectClass(
                label: "Kelas",
                controller: _classController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Silahkan pilih kelas!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Menyimpan Data')),
                      );
                      doSubmit();
                    }
                  },
                  child: Text(
                    "Simpan Informasi",
                    style: AppTextStyles.buttonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
