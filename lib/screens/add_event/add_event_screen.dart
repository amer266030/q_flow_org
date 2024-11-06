import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/screens/add_event/network_functions.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import '../../model/event/event.dart';
import '../../reusable_components/buttons/date_btn_view.dart';
import '../../reusable_components/buttons/primary_btn.dart';
import '../../reusable_components/custom_text_field.dart';
import '../../reusable_components/dialogs/error_dialog.dart';
import '../../reusable_components/dialogs/loading_dialog.dart';
import '../../reusable_components/page_header_view.dart';
import '../../utils/validations.dart';
import '../add_event/add_event_cubit.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key, this.event, this.isInitialSetup = true});

  final Event? event;
  final bool isInitialSetup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEventCubit(event),
      child: Builder(builder: (context) {
        final cubit = context.read<AddEventCubit>();
        return BlocListener<AddEventCubit, AddEventState>(
          listener: (context, state) async {
            if (cubit.previousState is LoadingState) {
              await Navigator.of(context).maybePop();
            }
            if (state is LoadingState && cubit.previousState is! LoadingState) {
              showLoadingDialog(context);
            }
            if (state is ErrorState) {
              showErrorDialog(context, state.msg);
            }
          },
          child: Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView(
                  children: [
                    PageHeaderView(title: 'Add Event'),
                    Column(
                      children: [
                        BlocBuilder<AddEventCubit, AddEventState>(
                          builder: (context, state) {
                            return _ImgView(event: event, cubit: cubit);
                          },
                        ),
                        TextButton(
                            onPressed: cubit.getImage,
                            child: Text('Add Event Image',
                                style: TextStyle(
                                    fontSize: context.bodySmall.fontSize,
                                    color: context.primary,
                                    fontWeight: context.titleSmall.fontWeight)))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                              hintText: 'Job Fair 123',
                              controller: cubit.nameController,
                              validation: Validations.name),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                              hintText: 'Riyadh Front',
                              controller: cubit.locationController,
                              validation: Validations.name),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomTextField(
                            hintText: 'Start Date',
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
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomTextField(
                            hintText: 'End Date',
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
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomTextField(
                            hintText: 'Invited Companies .xlsx',
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
                                  return event?.didInviteCompanies == null
                                      ? Text('none', style: context.bodyMedium)
                                      : Icon(CupertinoIcons.doc_checkmark,
                                          color: context.textColor1);
                                },
                              ),
                              IconButton(
                                  onPressed: cubit.uploadCompanyFile,
                                  icon: Icon(
                                      CupertinoIcons.square_arrow_up_fill,
                                      color: context.primary))
                            ],
                          ),
                        )
                      ],
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomTextField(
                            hintText: 'Invited Users .xlsx',
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
                                  return event?.didInviteUsers == null
                                      ? Text('none', style: context.bodyMedium)
                                      : Icon(CupertinoIcons.doc_checkmark,
                                          color: context.textColor1);
                                },
                              ),
                              IconButton(
                                  onPressed: cubit.uploadVisitorsFile,
                                  icon: Icon(
                                      CupertinoIcons.square_arrow_up_fill,
                                      color: context.primary))
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    PrimaryBtn(
                        callback: () {
                          if (cubit.validateFields()) {
                            cubit.createEvent(context);
                          } else {
                            cubit.showSnackBar(
                              context,
                              'Please fill all required fields and upload necessary files.',
                              AnimatedSnackBarType.error,
                            );
                          }
                        },
                        title: isInitialSetup ? 'Save' : 'Update')
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ImgView extends StatelessWidget {
  const _ImgView({required this.event, required this.cubit});

  final Event? event;
  final AddEventCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: context.primary, width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 5,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: cubit.imgUrl != null
                            ? Image.file(cubit.imgUrl!, fit: BoxFit.cover)
                            : event?.imgUrl == null
                                ? Image(
                                    image: Img.logoOrange, fit: BoxFit.cover)
                                : Image.network(event!.imgUrl!,
                                    fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
