import 'package:car_care/cubit/app_state.dart';
import 'package:car_care/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/contact.dart';
import '../../shared/components/default_button.dart';

import '../../shared/components/form_field.dart';
import '../../shared/components/show_model.dart';
import '../../shared/constants/app_colors.dart';

class CarRepairDetailsScreen extends StatelessWidget {

  var star = 4;
  final int index;
  CarRepairDetailsScreen(this.index);
  @override
  Widget build(BuildContext context,) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {},
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Car Repair',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              MaterialButton(
                  minWidth: 10,
                  height: 10,
                  onPressed: (){
                    //navigateTo(context, ProfileScreen());
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ))
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7)),
                gradient: LinearGradient(
                  colors: [appPrimaryColor,Colors.red],
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage:NetworkImage('https://vid.alarabiya.net/images/2020/01/07/b2fd1b6e-2a72-4038-b86b-985993fd4479/b2fd1b6e-2a72-4038-b86b-985993fd4479_16x9_1200x676.png?width=1138',),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '${AppCubit.get(context).getElectronicWorker!.worker![index].name}',
                      style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold,color: appPrimaryColor),maxLines: 2,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: star >= 1 ? Colors.yellow: Colors.grey ,size: 40,),
                        Icon(Icons.star , color: star >= 2 ? Colors.yellow: Colors.grey ,size: 40,),
                        Icon(Icons.star , color: star >= 3 ? Colors.yellow: Colors.grey ,size: 40,),
                        Icon(Icons.star , color: star >= 4 ? Colors.yellow: Colors.grey ,size: 40,),
                        Icon(Icons.star , color: star >= 5 ? Colors.yellow: Colors.grey ,size: 40,),
                      ],
                    ),
                    SizedBox(height: 30,),
                    information(describe: 'Specialization' , text: 'electronic'),
                    SizedBox(height: 20,),
                    information(describe: 'E-mail' , text: 'email'),
                    SizedBox(height: 20,),
                    information(describe: 'Phone Number' , text: '${AppCubit.get(context).getElectronicWorker!.worker![index].phone}'),
                    SizedBox(height: 20,),
                    information(describe: 'location' , text: 'location'),

                  ],
                ),
              ),
            ),
          ),
          persistentFooterButtons: [
            Center(
                child: defaultButton(
                    height: 50,
                    text: 'Contact Information', colorText: Colors.white, color: appPrimaryColor, width: 200,function: (){
                  openModel(context: context,index: index, phone: '${AppCubit.get(context).getElectronicWorker!.worker![index].phone}');
                }
                )
            ),
          ],
        );
      },
    );
  }
}