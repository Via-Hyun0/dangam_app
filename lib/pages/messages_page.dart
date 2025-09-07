import 'package:flutter/material.dart';
import 'package:dangam_app/data/mock_messages.dart';
import 'package:dangam_app/pages/chat_detail_page.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';

/// 메시지 목록 페이지
/// 
/// 디자이너 가이드:
/// - 이 페이지는 모든 메시지/채팅 목록을 표시합니다
/// - 필터링과 검색 기능을 제공합니다
/// - 각 메시지 카드는 일관된 디자인을 사용합니다
class MessagesBody extends StatefulWidget {
  const MessagesBody({super.key});

  @override
  State<MessagesBody> createState() => _MessagesBodyState();
}

class _MessagesBodyState extends State<MessagesBody> {
  String _selectedFilter = 'all';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // 필터링된 채팅 목록
    List<Chat> filteredChats = mockChats.where((chat) {
      final matchesFilter = _selectedFilter == 'all' || 
          chat.type.toString().split('.').last == _selectedFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          chat.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          chat.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();

    return Column(
      children: [
        // Search and Filter Bar
        _SearchFilterBar(
          searchQuery: _searchQuery,
          selectedFilter: _selectedFilter,
          onSearchChanged: (value) => setState(() => _searchQuery = value),
          onFilterChanged: (value) => setState(() => _selectedFilter = value),
        ),
        
        // Messages List
        filteredChats.isEmpty
            ? _EmptyState()
            : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    final Chat chat = filteredChats[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: _ChatCard(chat: chat),
                    );
                  },
                ),
              ),
      ],
    );
  }
}

/// 검색 및 필터 바 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 메시지 검색과 필터링을 담당합니다
/// - 검색 입력 필드와 필터 칩을 포함합니다
class _SearchFilterBar extends StatelessWidget {
  final String searchQuery;
  final String selectedFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onFilterChanged;

  const _SearchFilterBar({
    required this.searchQuery,
    required this.selectedFilter,
    required this.onSearchChanged,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search Field
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: '메시지 검색...',
              hintStyle: AppTypography.bodyMedium.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.grey,
                size: AppSpacing.iconMedium,
              ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: AppColors.grey,
                        size: AppSpacing.iconMedium,
                      ),
                      onPressed: () => onSearchChanged(''),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: '전체',
                  isSelected: selectedFilter == 'all',
                  onTap: () => onFilterChanged('all'),
                ),
                const SizedBox(width: AppSpacing.md),
                _FilterChip(
                  label: '요청함',
                  isSelected: selectedFilter == 'requested',
                  onTap: () => onFilterChanged('requested'),
                ),
                const SizedBox(width: AppSpacing.md),
                _FilterChip(
                  label: '요청받음',
                  isSelected: selectedFilter == 'received',
                  onTap: () => onFilterChanged('received'),
                ),
                const SizedBox(width: AppSpacing.md),
                _FilterChip(
                  label: '계약중',
                  isSelected: selectedFilter == 'contract',
                  onTap: () => onFilterChanged('contract'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 필터 칩 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 필터 옵션을 칩 형태로 표시합니다
/// - 선택된 상태와 선택되지 않은 상태를 구분합니다
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, 
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.primaryLighter,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.primaryLightest,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? AppColors.white : AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 채팅 카드 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 개별 채팅을 카드 형태로 표시합니다
/// - 채팅의 모든 중요한 정보를 포함합니다
/// - 클릭 시 채팅 상세 페이지로 이동합니다
class _ChatCard extends StatelessWidget {
  final Chat chat;

  const _ChatCard({required this.chat});

  @override
  Widget build(BuildContext context) {
    final Color typeColor = chatTypeColor(chat.type);
    final Color statusColor = messageStatusColor(chat.status);
    
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatDetailPage(chat: chat),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(
              color: AppColors.primaryLighter,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  // Avatar and Info
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: AppSpacing.iconHuge,
                          height: AppSpacing.iconHuge,
                          decoration: BoxDecoration(
                            color: AppColors.successLight,
                            borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                          ),
                          child: Icon(
                            _getChatTypeIcon(chat.type),
                            color: typeColor,
                            size: AppSpacing.iconLarge,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat.title,
                                style: AppTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkAccent,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                chat.employerName,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Time
                  Text(
                    _formatTime(chat.lastMessageTime),
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // Type and Status Badges
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.successLight,
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Text(
                      chatTypeLabel(chat.type),
                      style: AppTypography.labelSmall.copyWith(
                        color: typeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: AppSpacing.md),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.successLight,
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Text(
                      messageStatusLabel(chat.status),
                      style: AppTypography.labelSmall.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Unread count
                  if (chat.unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSpacing.sm),
                      ),
                      child: Text(
                        '${chat.unreadCount}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: AppSpacing.sm),

              // Last Message
              Text(
                chat.lastMessage,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 빈 상태 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 메시지가 없을 때 표시됩니다
/// - 사용자에게 안내 메시지를 제공합니다
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppSpacing.iconHuge * 2,
              height: AppSpacing.iconHuge * 2,
              decoration: BoxDecoration(
                color: AppColors.primaryLighter,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: AppSpacing.iconHuge,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              '메시지가 없습니다',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.darkAccent,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '새로운 작업 요청이나 계약을 시작해보세요',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 채팅 타입에 따른 아이콘 반환 함수
IconData _getChatTypeIcon(ChatType type) {
  switch (type) {
    case ChatType.job:
      return Icons.work_outline;
    case ChatType.contract:
      return Icons.description_outlined;
    case ChatType.support:
      return Icons.support_agent;
    case ChatType.general:
      return Icons.chat_bubble_outline;
  }
}

/// 시간 포맷팅 함수
String _formatTime(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);
  
  if (difference.inDays > 0) {
    return '${difference.inDays}일 전';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}시간 전';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}분 전';
  } else {
    return '방금 전';
  }
}