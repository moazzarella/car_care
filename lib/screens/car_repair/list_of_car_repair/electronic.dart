import 'package:car_care/cubit/app_state.dart';
import 'package:car_care/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constants/app_colors.dart';
import '../car_repaier_details_screen.dart';
import '../details_of_car_repair/electronic_details.dart';



class ElectronicRepairScreen extends StatelessWidget {
  const ElectronicRepairScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context ,state){},
      builder: (context ,state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).getElectronicWorker != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Electronic',
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
                      Icons.search,
                      color: Colors.white,
                    ))
              ],
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7)),
                  gradient: LinearGradient(
                    colors: [appPrimaryColor,secondColor],
                    begin: Alignment.bottomRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder:(context, index) => SizedBox(height: 20,),
                itemCount: AppCubit.get(context).getElectronicWorker!.worker!.length,
                itemBuilder:(context, index) => buildListViewItem(context,index),
              ),
            ),
          ),
          fallback: (context) =>Center(child: CircularProgressIndicator(color: Colors.red,),),
        );
      },
    );
  }
}










Widget buildListViewItem(context,index)=>Container(
  child:Material(
    elevation: 7,
    shadowColor: appPrimaryColor,
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    child: ListTile(
      onTap: (){
        // navigateTo(context, CarRepairDetailsScreen());
        Navigator.push(context , MaterialPageRoute(builder: (context) => ElctronicCarRepairDetailsScreen(index))
        );
      },
      dense: true,
      leading: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: appPrimaryColor ,
          ),
          CircleAvatar(
            radius: 22,
            backgroundImage:NetworkImage('${AppCubit.get(context).getElectronicWorker!.worker![index].url}'),
          ),
        ],
      ),
      title: Text('${AppCubit.get(context).getElectronicWorker!.worker![index].name}',
        style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.bold ,color:appPrimaryColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,),
      subtitle: Text('electronic',style: TextStyle(fontSize: 15)),
      trailing: Icon(Icons.remove_red_eye_outlined , color:appPrimaryColor, size: 30,),
    ),
  ),
);