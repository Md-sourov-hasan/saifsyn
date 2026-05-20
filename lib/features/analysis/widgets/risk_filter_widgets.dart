import 'package:flutter/material.dart';
import '../controller/analysis_controller.dart';
import 'package:get/get.dart';

class RiskFilterWidget extends StatelessWidget {
  final AnalysisController controller;

  const RiskFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _chip("All Risk", RiskType.all),
              const SizedBox(width: 8),
              _chip("Low Risk", RiskType.low),
              const SizedBox(width: 8),
              _chip("Medium Risk", RiskType.medium),
            ],
          ),
        ));
  }

  Widget _chip(String title, RiskType type) {
    final selected = controller.selectedRisk.value == type;

    return GestureDetector(
      onTap: () => controller.changeRisk(type),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xff0A0A8F) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected
                  ? const Color(0xff0A0A8F)
                  : Colors.grey.shade400),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: selected ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
