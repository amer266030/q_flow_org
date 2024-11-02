import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/extensions/img_ext.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({
    super.key,
    required this.company,
    required this.rateCompany,
  });
  final Company company;
  final Function()? rateCompany;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: InkWell(
          onTap: rateCompany,
          child: Container(
              decoration: BoxDecoration(
                  color: context.bg2,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: context.textColor1.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 0.5,
                        offset: Offset(3, 3))
                  ]),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image(
                                        image: Img.logoOrange,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(company.name ?? '',
                                          style: context.bodyMedium,
                                          maxLines: 1,
                                          softWrap: true),
                                      Text(company.description ?? '',
                                          style: context.bodySmall,
                                          maxLines: 3,
                                          softWrap: true),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]))),
        ));
  }
}
