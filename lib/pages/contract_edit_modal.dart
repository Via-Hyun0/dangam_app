import 'package:flutter/material.dart';
import 'package:dangam_app/models/chat_message.dart';

class ContractEditModal extends StatefulWidget {
  final ContractData contractData;
  final Function(ContractData) onSave;
  final VoidCallback onCancel;

  const ContractEditModal({
    super.key,
    required this.contractData,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<ContractEditModal> createState() => _ContractEditModalState();
}

class _ContractEditModalState extends State<ContractEditModal> {
  late TextEditingController _jobTitleController;
  late TextEditingController _jobDescriptionController;
  late TextEditingController _hourlyRateController;
  late TextEditingController _estimatedHoursController;
  late TextEditingController _notesController;
  late DateTime _startDate;
  late DateTime _endDate;
  late List<String> _requirements;

  @override
  void initState() {
    super.initState();
    _jobTitleController = TextEditingController(text: widget.contractData.jobTitle);
    _jobDescriptionController = TextEditingController(text: widget.contractData.jobDescription);
    _hourlyRateController = TextEditingController(text: widget.contractData.hourlyRate.toStringAsFixed(0));
    _estimatedHoursController = TextEditingController(text: widget.contractData.estimatedHours.toString());
    _notesController = TextEditingController(text: widget.contractData.notes ?? '');
    _startDate = widget.contractData.startDate;
    _endDate = widget.contractData.endDate;
    _requirements = List.from(widget.contractData.requirements);
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _jobDescriptionController.dispose();
    _hourlyRateController.dispose();
    _estimatedHoursController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveContract() {
    if (_validateForm()) {
      final updatedContract = ContractData(
        jobTitle: _jobTitleController.text.trim(),
        jobDescription: _jobDescriptionController.text.trim(),
        hourlyRate: double.parse(_hourlyRateController.text),
        estimatedHours: int.parse(_estimatedHoursController.text),
        startDate: _startDate,
        endDate: _endDate,
        requirements: _requirements,
        status: ContractStatus.modified,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      
      widget.onSave(updatedContract);
      Navigator.of(context).pop();
    }
  }

  bool _validateForm() {
    if (_jobTitleController.text.trim().isEmpty) {
      _showError('작업명을 입력해주세요.');
      return false;
    }
    if (_jobDescriptionController.text.trim().isEmpty) {
      _showError('작업 설명을 입력해주세요.');
      return false;
    }
    if (_hourlyRateController.text.trim().isEmpty) {
      _showError('시급을 입력해주세요.');
      return false;
    }
    if (_estimatedHoursController.text.trim().isEmpty) {
      _showError('예상 시간을 입력해주세요.');
      return false;
    }
    
    final hourlyRate = double.tryParse(_hourlyRateController.text);
    if (hourlyRate == null || hourlyRate <= 0) {
      _showError('올바른 시급을 입력해주세요.');
      return false;
    }
    
    final estimatedHours = int.tryParse(_estimatedHoursController.text);
    if (estimatedHours == null || estimatedHours <= 0) {
      _showError('올바른 예상 시간을 입력해주세요.');
      return false;
    }
    
    if (_startDate.isAfter(_endDate)) {
      _showError('시작일은 종료일보다 이전이어야 합니다.');
      return false;
    }
    
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_startDate.isAfter(_endDate)) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _addRequirement() {
    showDialog(
      context: context,
      builder: (context) => _AddRequirementDialog(
        onAdd: (requirement) {
          setState(() {
            _requirements.add(requirement);
          });
        },
      ),
    );
  }

  void _removeRequirement(int index) {
    setState(() {
      _requirements.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 헤더
            Row(
              children: [
                Icon(
                  Icons.edit_outlined,
                  color: primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  '계약 수정',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF503123),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.onCancel,
                  icon: const Icon(Icons.close),
                  color: Colors.grey.shade600,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // 스크롤 가능한 폼
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 작업명
                    _FormField(
                      controller: _jobTitleController,
                      label: '작업명',
                      hintText: '작업명을 입력하세요',
                      icon: Icons.work_outline,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 작업 설명
                    _FormField(
                      controller: _jobDescriptionController,
                      label: '작업 설명',
                      hintText: '작업에 대한 자세한 설명을 입력하세요',
                      icon: Icons.description_outlined,
                      maxLines: 3,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 시급과 예상 시간
                    Row(
                      children: [
                        Expanded(
                          child: _FormField(
                            controller: _hourlyRateController,
                            label: '시급 (원)',
                            hintText: '15000',
                            icon: Icons.attach_money_outlined,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _FormField(
                            controller: _estimatedHoursController,
                            label: '예상 시간',
                            hintText: '8',
                            icon: Icons.schedule_outlined,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 작업 기간
                    Row(
                      children: [
                        Expanded(
                          child: _DateField(
                            label: '시작일',
                            date: _startDate,
                            onTap: () => _selectDate(context, true),
                            icon: Icons.calendar_today_outlined,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _DateField(
                            label: '종료일',
                            date: _endDate,
                            onTap: () => _selectDate(context, false),
                            icon: Icons.calendar_today_outlined,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 요구사항
                    _RequirementsField(
                      requirements: _requirements,
                      onAdd: _addRequirement,
                      onRemove: _removeRequirement,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 메모
                    _FormField(
                      controller: _notesController,
                      label: '메모 (선택사항)',
                      hintText: '추가 설명이나 특이사항을 입력하세요',
                      icon: Icons.note_outlined,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 액션 버튼
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey.shade600,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('취소'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveContract,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('수정 제안'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF503123),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(
              icon,
              color: primary,
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color.fromARGB(51, 199, 93, 49),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color.fromARGB(51, 199, 93, 49),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: primary,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;
  final IconData icon;

  const _DateField({
    required this.label,
    required this.date,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF503123),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color.fromARGB(51, 199, 93, 49),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  '${date.month}/${date.day}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF503123),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RequirementsField extends StatelessWidget {
  final List<String> requirements;
  final VoidCallback onAdd;
  final Function(int) onRemove;

  const _RequirementsField({
    required this.requirements,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '요구사항',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF503123),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: onAdd,
              icon: Icon(
                Icons.add,
                color: primary,
                size: 18,
              ),
              label: Text(
                '추가',
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (requirements.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color.fromARGB(51, 199, 93, 49),
                width: 1,
              ),
            ),
            child: Text(
              '요구사항이 없습니다. 추가 버튼을 눌러 요구사항을 추가하세요.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: requirements.asMap().entries.map((entry) {
              final index = entry.key;
              final requirement = entry.value;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(26, 199, 93, 49),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.fromARGB(77, 199, 93, 49),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      requirement,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => onRemove(index),
                      child: Icon(
                        Icons.close,
                        color: primary,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

class _AddRequirementDialog extends StatefulWidget {
  final Function(String) onAdd;

  const _AddRequirementDialog({required this.onAdd});

  @override
  State<_AddRequirementDialog> createState() => _AddRequirementDialogState();
}

class _AddRequirementDialogState extends State<_AddRequirementDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '요구사항 추가',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF503123),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '예: 경험 2년 이상',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              autofocus: true,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        widget.onAdd(_controller.text.trim());
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('추가'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
