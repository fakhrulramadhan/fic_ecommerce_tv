import 'package:fic_ecommerce_tv/bloc/login/login_bloc.dart';
import 'package:fic_ecommerce_tv/bloc/register/register_bloc.dart';
import 'package:fic_ecommerce_tv/common/global_variable.dart';
import 'package:fic_ecommerce_tv/data/datasources/auth_local_datasource.dart';
import 'package:fic_ecommerce_tv/data/models/login_request_modlel.dart';
import 'package:fic_ecommerce_tv/data/models/register_request_model.dart';
import 'package:fic_ecommerce_tv/presentation/home/home_page.dart';
import 'package:fic_ecommerce_tv/widgets/custom_button_widget.dart';
import 'package:fic_ecommerce_tv/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utk memilih apakah mode UInya dalam bentuk login atau daftar
enum Auth { signIn, signUp }

//di bloc, harus pakai stateful
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Auth _auth = Auth.signUp;

  //buat form key utk isian form, _ini artinya privat
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.backgroundColor,
        // appBar: AppBar(
        //   title: const Text("Dashboard"),
        //   actions: const [],
        // ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                tileColor: GlobalVariables.backgroundColor,
                title: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //utk memilihi mode login / daftar
                leading: Radio(
                  value: Auth.signUp, //nilai awalnya signup
                  //group value dari data auth
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth != val; //ketika diklik, akan nilai kebalikannya
                    });
                  },
                ),
              ),
              //  ================================
              //jika authnya mode signup, maka tampilkan form pendaftaran
              if (_auth == Auth.signUp)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey, //key utk form
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _nameController,
                            hintText: "Nama",
                            maxLines: 1),
                        CustomTextField(
                          hintText: "Email",
                          maxLines: 1,
                          controller: _emailController,
                        ),
                        CustomTextField(
                            controller: _passwordController,
                            hintText: "Password",
                            maxLines: 1),
                        const SizedBox(
                          height: 10.0,
                        ),
                        //pakai bloc counsumer (ada opsi listener, loaded, dan builder)
                        //bbuat register bloc dan login bloc dulu
                        BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            //pakai maybe wher utk menampilkan semua opsi
                            // yang terjadi pada state
                            state.maybeWhen(
                              orElse: () {},
                              error: () {
                                //kondisi kalau error akan menampilkan pesan error
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "text",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              },
                              loaded: (model) async {
                                //kalau daftar, di save dulu data user barunya
                                await AuthLocalDataSource().saveAuthData(model);

                                //arahkan ke homepage (beranda toko), langsung
                                //pakai => aja
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              },
                            );
                          },
                          //utk meemasuukan suatu kondisi di dalam button register
                          //builder, utk menampilkan UInya (based Login Bloc)
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return CustomButton(
                                  text: "SignUp",
                                  onTap: () {
                                    //await data source nya pas loaded
                                    //jika isiannya tervalidasi semua, maka
                                    //panggil fungsi register event di register bloc
                                    //name sama username pakai textcont sama
                                    if (_signUpFormKey.currentState!
                                        .validate()) {
                                      final requestModel = RegisterRequestModel(
                                          name: _nameController.text,
                                          password: _passwordController.text,
                                          email: _emailController.text,
                                          username: _nameController.text);

                                      //add diisi oleh naam eventnya /
                                      //nama blocnya
                                      context.read<RegisterBloc>().add(
                                          RegisterEvent.register(requestModel));
                                    }
                                  },
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),

              //========
              // KONDISI KETIKA MENAMPILKAN FORM LOGIN
              ListTile(
                tileColor: _auth == Auth.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greybackgroundColor,
                title: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  value: Auth.signIn,
                  groupValue: _auth,
                  //? blm tentu ada
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth != val;
                    });
                  },
                ),
              ),

              if (_auth == Auth.signIn)
                Container(
                  padding: const EdgeInsets.all(10),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                      child: Column(
                    children: [
                      CustomTextField(
                          controller: _nameController,
                          hintText: "Nama",
                          maxLines: 1),
                      CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                          maxLines: 1),
                      CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          maxLines: 1),
                      CustomTextField(
                          controller: _nameController,
                          hintText: "Username",
                          maxLines: 1),
                      const SizedBox(
                        height: 8.0,
                      ),
                      //button untuk login, pakainya loginbloc
                      BlocConsumer<LoginBloc, LoginState>(
                        //listener = lakukan sesuatu pada saat state tertentu
                        listener: (context, state) async {
                          // TODO: implement listener

                          //state ketikA loginnya termuat, maka
                          //simpan data user di local (shared pref)
                          if (state is LoginLoaded) {
                            await AuthLocalDataSource()
                                .saveAuthData(state.model);

                            //kemudian arahkan ke homepage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          }

                          //jika state dalam kondisi error
                          if (state is LoginError) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "Anda tidak dapat login, data login tidak sesuai",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ));
                          }
                        },
                        //builder, utk menampilkan UInya (based Login Bloc)
                        builder: (context, state) {
                          //jika statenya loading
                          if (state is LoginLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CustomButton(
                            text: "Sign In",
                            onTap: () async {
                              //jika isiaannya tervalidasi semua
                              if (_signInFormKey.currentState!.validate()) {
                                //request model (data dari inputan)
                                final requestModel = LoginRequestModel(
                                    //identifiernya dari email
                                    identifier: _emailController.text,
                                    password: _passwordController.text);

                                //panggil fungsi login (login bloc), a
                                //add nya dari nama event

                                context
                                    .read<LoginBloc>()
                                    .add(DoLoginEvent(model: requestModel));
                              }
                            },
                          );
                        },
                      )
                    ],
                  )),
                ),
              //  =============================
              // CASE KALAU LOGINNYA SEBAGAI TAMUU (GUEST)
              const SizedBox(
                height: 18.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Center(
                      child: Text(
                    "Login Sebagai Tamu",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0, //fs15
                        fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ],
          ),
        )));
  }
}
