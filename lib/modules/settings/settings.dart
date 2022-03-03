import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/cubit.dart';
import 'package:shop_app/bloc/cubit/states.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/translation/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  final nameController=TextEditingController();
  final phoneController=TextEditingController();
  final emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {},
      builder: (context,state){
        var model = ShopCubit.get(context).userModel;
        var formKey=GlobalKey<FormState>();
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel !=null,
          builder:(context)=>  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                   const LinearProgressIndicator(),
                   const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return'name must not be empty';
                        }
                        return null;
                      },
                      label: LocaleKeys.userName.tr(),
                      prefix: Icons.person,
                    ),
                   const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return'email must not be empty';
                        }
                        return null;
                      },
                      label:  LocaleKeys.emailAddress.tr(),
                      prefix: Icons.email,
                    ),
                   const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return'phone must not be empty';
                        }
                        return null;
                      },
                      label:  LocaleKeys.phone.tr(),
                      prefix: Icons.phone,
                    ),
                   const SizedBox(
                      height: 15.0,
                    ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            ElevatedButton(onPressed: ()async
                            {
                             await context.setLocale( const Locale('en'));
                             
                              //ShopCubit.get(context).changeLanguage('en');
                              
                            }, 
                            child: const Text("English")),

                            ElevatedButton(onPressed: ()async
                            {
                              await context.setLocale( const Locale('ar'));
                              //ShopCubit.get(context).changeLanguage('ar');
                            }, 
                            child: const Text("العربية"))
                        ],
                      ),
                    defaultTextButton(text: LocaleKeys.update.tr(),
                      function:(){
                      if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name:nameController.text.toString(),
                            email: emailController.text.toString(),
                            phone: phoneController.text.toString(),
                          );
                        }
                      },
                    ),
                   const SizedBox(
                      height: 15.0,
                    ),

                    defaultTextButton(text: LocaleKeys.logout.tr(),
                      function:(){
                      signOut(context);
                    },
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator(),),

        );
      },
    );
  }
}