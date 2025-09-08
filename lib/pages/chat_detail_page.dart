import 'package:flutter/material.dart';
import 'package:dangam_app/data/mock_messages.dart';
import 'package:dangam_app/models/chat_message.dart';
import 'package:dangam_app/pages/contract_edit_modal.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

class ChatDetailPage extends StatefulWidget {
  final Chat chat;

  const ChatDetailPage({
    super.key,
    required this.chat,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    // 실제 앱에서는 API에서 메시지를 가져옴
    _messages = _generateMockMessages();
  }

  List<ChatMessage> _generateMockMessages() {
    return [
      // 초기 인사 메시지
      ChatMessage(
        id: 'm1',
        content: '안녕하세요! ${widget.chat.jobTitle} 작업에 관심을 가져주셔서 감사합니다.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isFromUser: false,
        type: MessageType.text,
      ),

      // 사용자 응답
      ChatMessage(
        id: 'm2',
        content: '안녕하세요! 언제부터 시작 가능한지 궁금합니다.',
        timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
        isFromUser: true,
        type: MessageType.text,
      ),

      // 계약 제안
      ChatMessage(
        id: 'm3',
        content: '계약 조건을 제안드립니다.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isFromUser: false,
        type: MessageType.contract,
        contractData: ContractData(
          jobTitle: widget.chat.jobTitle,
          jobDescription:
              '${widget.chat.jobTitle} 작업을 진행합니다. 경험이 있는 분을 찾고 있습니다.',
          hourlyRate: 15000.0,
          estimatedHours: 8,
          startDate: DateTime.now().add(const Duration(days: 2)),
          endDate: DateTime.now().add(const Duration(days: 5)),
          requirements: const ['경험 2년 이상', '안전교육 이수', '신체 건강'],
          status: ContractStatus.proposed,
          notes: '날씨가 좋을 때 진행 예정입니다.',
        ),
      ),

      // 사용자 질문
      ChatMessage(
        id: 'm4',
        content: '급여는 언제 지급되나요?',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
        isFromUser: true,
        type: MessageType.text,
      ),

      // 답변
      ChatMessage(
        id: 'm5',
        content: '작업 완료 후 3일 이내에 지급됩니다. 계약서에 명시되어 있습니다.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
        isFromUser: false,
        type: MessageType.text,
      ),

      // 최근 메시지
      ChatMessage(
        id: 'm6',
        content: widget.chat.lastMessage,
        timestamp: widget.chat.lastMessageTime,
        isFromUser: false,
        type: MessageType.text,
      ),
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final message = ChatMessage(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      content: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isFromUser: true,
      type: MessageType.text,
    );

    setState(() {
      _messages.add(message);
    });

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleContractAction(ContractStatus action) {
    if (action == ContractStatus.modified) {
      // 수정 모달 표시
      _showContractEditModal();
    } else {
      // 다른 액션 처리
      final message = ChatMessage(
        id: 'm${DateTime.now().millisecondsSinceEpoch}',
        content: _getContractActionMessage(action),
        timestamp: DateTime.now(),
        isFromUser: true,
        type: MessageType.contract,
        contractData: _messages.last.contractData?.copyWith(status: action),
      );

      setState(() {
        _messages.add(message);
      });

      _scrollToBottom();
    }
  }

  void _showContractEditModal() {
    final lastContractMessage = _messages.lastWhere(
      (msg) => msg.type == MessageType.contract,
      orElse: () => _messages.first,
    );

    if (lastContractMessage.contractData != null) {
      showDialog(
        context: context,
        builder: (context) => ContractEditModal(
          contractData: lastContractMessage.contractData!,
          onSave: (updatedContract) {
            final message = ChatMessage(
              id: 'm${DateTime.now().millisecondsSinceEpoch}',
              content: '계약 조건을 수정 제안합니다.',
              timestamp: DateTime.now(),
              isFromUser: true,
              type: MessageType.contract,
              contractData: updatedContract,
            );

            setState(() {
              _messages.add(message);
            });

            _scrollToBottom();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  String _getContractActionMessage(ContractStatus action) {
    switch (action) {
      case ContractStatus.accepted:
        return '계약 조건에 동의합니다.';
      case ContractStatus.rejected:
        return '계약 조건을 거절합니다.';
      case ContractStatus.modified:
        return '계약 조건을 수정 제안합니다.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chat.title,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            Text(
              widget.chat.employerName,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // 메뉴 표시
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 메시지 목록
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(
                  message: message,
                  onContractAction: _handleContractAction,
                );
              },
            ),
          ),

          // 메시지 입력
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusCircular),
                        borderSide: BorderSide(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusCircular),
                        borderSide: BorderSide(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusCircular),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusCircular),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: AppColors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final Function(ContractStatus) onContractAction;

  const _MessageBubble({
    required this.message,
    required this.onContractAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: message.isFromUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isFromUser) ...[
            // 상대방 아바타
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primaryLighter,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                AppIcons.userOutline,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],

          // 메시지 내용
          Flexible(
            child: Column(
              crossAxisAlignment: message.isFromUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (message.type == MessageType.contract)
                  _ContractCard(
                    contractData: message.contractData!,
                    onAction: onContractAction,
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: message.isFromUser
                          ? AppColors.primary
                          : AppColors.white,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusLarge)
                              .copyWith(
                        bottomLeft: message.isFromUser
                            ? const Radius.circular(AppSpacing.radiusLarge)
                            : const Radius.circular(AppSpacing.radiusSmall),
                        bottomRight: message.isFromUser
                            ? const Radius.circular(AppSpacing.radiusSmall)
                            : const Radius.circular(AppSpacing.radiusLarge),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.content,
                      style: AppTypography.bodyMedium.copyWith(
                        color: message.isFromUser
                            ? AppColors.white
                            : AppColors.darkAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                const SizedBox(height: 4),

                // 시간
                Text(
                  _formatTime(message.timestamp),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          if (message.isFromUser) ...[
            const SizedBox(width: AppSpacing.xs),
            // 사용자 아바타
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                AppIcons.user,
                color: AppColors.white,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${time.month}/${time.day}';
    }
  }
}

class _ContractCard extends StatelessWidget {
  final ContractData contractData;
  final Function(ContractStatus) onAction;

  const _ContractCard({
    required this.contractData,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = contractStatusColor(contractData.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더
          Row(
            children: [
              Icon(
                contractStatusIcon(contractData.status),
                color: statusColor,
                size: AppSpacing.iconLarge,
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                contractStatusLabel(contractData.status),
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: statusColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // 작업 정보
          _ContractInfoItem(
            icon: AppIcons.workOutline,
            label: '작업명',
            value: contractData.jobTitle,
          ),

          _ContractInfoItem(
            icon: Icons.description_outlined,
            label: '작업 설명',
            value: contractData.jobDescription,
          ),

          _ContractInfoItem(
            icon: Icons.attach_money_outlined,
            label: '시급',
            value: '${contractData.hourlyRate.toStringAsFixed(0)}원',
          ),

          _ContractInfoItem(
            icon: AppIcons.schedule,
            label: '예상 시간',
            value: '${contractData.estimatedHours}시간',
          ),

          _ContractInfoItem(
            icon: Icons.calendar_today_outlined,
            label: '작업 기간',
            value:
                '${_formatDate(contractData.startDate)} ~ ${_formatDate(contractData.endDate)}',
          ),

          // 요구사항
          if (contractData.requirements.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              '요구사항',
              style: AppTypography.titleSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.darkAccent,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: contractData.requirements
                  .map((req) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLighter,
                          borderRadius: BorderRadius.circular(AppSpacing.md),
                        ),
                        child: Text(
                          req,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],

          // 메모
          if (contractData.notes != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              '메모',
              style: AppTypography.titleSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.darkAccent,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              contractData.notes!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],

          // 액션 버튼
          if (contractData.status == ContractStatus.proposed) ...[
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onAction(ContractStatus.accepted),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                      ),
                    ),
                    child: const Text('수락'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onAction(ContractStatus.rejected),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                      ),
                    ),
                    child: const Text('거절'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onAction(ContractStatus.modified),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                      ),
                    ),
                    child: const Text('수정'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }
}

class _ContractInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContractInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.secondary,
            size: AppSpacing.iconSmall,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '$label: ',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.darkAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ContractData 확장 메서드
extension ContractDataExtension on ContractData {
  ContractData copyWith({
    String? jobTitle,
    String? jobDescription,
    double? hourlyRate,
    int? estimatedHours,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? requirements,
    ContractStatus? status,
    String? notes,
  }) {
    return ContractData(
      jobTitle: jobTitle ?? this.jobTitle,
      jobDescription: jobDescription ?? this.jobDescription,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      requirements: requirements ?? this.requirements,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
