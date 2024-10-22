import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/extensions/screen_size.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

import '../../reusable_components/buttons/date_btn_view.dart';
import '../../reusable_components/buttons/primary_btn.dart';
import '../../reusable_components/custom_text_field.dart';
import '../../utils/validations.dart';
import '../add_event/add_event_cubit.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEventCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AddEventCubit>();
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: context.screenWidth * 0.4),
                  Padding(
                    padding: EdgeInsets.only(left: context.screenWidth * 0.08),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Add Event', style: context.titleLarge)),
                  ),
                  SizedBox(height: context.screenWidth * 0.03),
                  CircleAvatar(
                    radius: context.screenWidth * 0.3,
                    backgroundColor: context.bg3,
                    child: Icon(
                      Icons.person,
                      size: context.screenWidth * 0.2,
                      color: context.secondary,
                    ),
                  ),
                  SizedBox(height: context.screenWidth * 0.01),
                  TextButton(
                      onPressed: cubit.addEventPicture,
                      child: Text(
                        'Add Event Picture',
                        style:
                            context.bodyMedium.copyWith(color: context.primary),
                      )),
                  SizedBox(height: context.screenWidth * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.08),
                    child: CustomTextField(
                      hintText: 'Event Name',
                      controller: TextEditingController(),
                      validation: (String value) {},
                    ),
                  ),
                  SizedBox(height: context.screenWidth * 0.001),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.08),
                    child: CustomTextField(
                      hintText: 'Description',
                      controller: TextEditingController(),
                      validation: (String value) {},
                    ),
                  ),
                  SizedBox(height: context.screenWidth * 0.001),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomTextField(
                          hintText: 'Start date',
                          readOnly: true,
                          controller: TextEditingController(),
                          validation: Validations.none),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlocBuilder<AddEventCubit, AddEventState>(
                              builder: (context, state) {
                                return DateBtnView(
                                    date: cubit.startDate,
                                    callback: (date) =>
                                        cubit.updateStartDate(date));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: context.screenWidth * 0.001),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomTextField(
                          hintText: 'End date',
                          readOnly: true,
                          controller: TextEditingController(),
                          validation: Validations.none),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlocBuilder<AddEventCubit, AddEventState>(
                              builder: (context, state) {
                                return DateBtnView(
                                    date: cubit.endDate,
                                    callback: (date) =>
                                        cubit.updateEndDate(date));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: context.screenWidth * 0.001),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.08),
                    child: CustomTextField(
                      hintText: 'Upload company .xlsx',
                      suffixIcon: IconButton(
                          onPressed: cubit.uploadCompanyFile,
                          icon: Icon(Icons.upload_file)),
                      controller: TextEditingController(),
                      validation: (String value) {},
                    ),
                  ),
                  SizedBox(height: context.screenWidth * 0.001),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.08),
                    child: CustomTextField(
                      suffixIcon: IconButton(
                          onPressed: cubit.uploadVisitorsFile,
                          icon: Icon(Icons.upload_file)),
                      hintText: 'Upload visitors .xlsx',
                      controller: TextEditingController(),
                      validation: (String value) {},
                    ),
                  ),
                  SizedBox(height: context.screenWidth * 0.01),
                  PrimaryBtn(
                    callback: cubit.createEvent(context),
                    title: 'Create Event',
                  ),
                  SizedBox(height: context.screenWidth * 0.01),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
