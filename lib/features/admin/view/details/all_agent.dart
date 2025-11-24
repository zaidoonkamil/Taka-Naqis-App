import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:taka_naqis/core/widgets/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ navigation/navigation.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import 'details_person.dart';

class AllAgent extends StatelessWidget {
  const AllAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit()
        ..getNameAgent(context: context, page: '1' ),
      child: BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=AdminCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              navigateBack(context);
                            },
                            child: Icon(Icons.arrow_back_ios_new,)),
                        const Text(
                          textAlign: TextAlign.right,
                          'التجار',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ConditionalBuilder(
                        condition: cubit.user.isNotEmpty,
                        builder: (c){
                          return Expanded(
                            child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: cubit.user.length,
                                itemBuilder:(context,index){
                                  if (index == cubit.user.length - 1 && !cubit.isLastPage1) {
                                    cubit.getNameUser(page: (cubit.currentPage1 + 1).toString(),context:context);
                                  }
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          navigateTo(context, DetailsPerson(
                                              id: cubit.user[index].id.toString(),
                                              name: cubit.user[index].name,
                                              phone: cubit.user[index].phone,
                                            location: cubit.user[index].location!,
                                            isVerified: cubit.user[index].isVerified.toString(),
                                            role: cubit.user[index].role,
                                              createdAt:  cubit.user[index].createdAt.toString(),
                                          ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                          height: 45,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                blurRadius: 4,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                  onTap:(){
                                                    cubit.deleteUser(id: cubit.user[index].id.toString(), context: context);
                                                  },
                                                  child: Icon(Icons.delete,color: Colors.red,)),
                                              Text(
                                                cubit.user[index].name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Text(
                                                ' ${index+1} #',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                    ],
                                  );
                                }),
                          );
                        },
                        fallback: (c)=>Center(child: CircularProgress(),),
                    ),
                    SizedBox(height: 80,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
