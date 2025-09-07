import 'package:flutter/material.dart';
import 'package:dangam_app/data/mock_messages.dart';
import 'package:dangam_app/pages/chat_detail_page.dart';

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
    final Color primary = Theme.of(context).colorScheme.primary;
    
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
        // 상단 검색 및 필터 바
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(26, primary.red, primary.green, primary.blue),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // 검색 바
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: '대화 검색...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: primary,
                    size: 22,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Color.fromARGB(51, primary.red, primary.green, primary.blue),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Color.fromARGB(51, primary.red, primary.green, primary.blue),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: primary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 필터 칩
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: '전체',
                      isSelected: _selectedFilter == 'all',
                      onTap: () => setState(() => _selectedFilter = 'all'),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: '작업',
                      isSelected: _selectedFilter == 'job',
                      onTap: () => setState(() => _selectedFilter = 'job'),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: '지원사업',
                      isSelected: _selectedFilter == 'support',
                      onTap: () => setState(() => _selectedFilter = 'support'),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: '일반',
                      isSelected: _selectedFilter == 'general',
                      onTap: () => setState(() => _selectedFilter = 'general'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 채팅 목록
        Expanded(
          child: filteredChats.isEmpty
              ? _EmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    final chat = filteredChats[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: _ChatCard(chat: chat),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _ChatCard extends StatelessWidget {
  final Chat chat;
  const _ChatCard({required this.chat});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color typeColor = chatTypeColor(chat.type);
    final Color statusColor = messageStatusColor(chat.status);
    
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatDetailPage(chat: chat),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color.fromARGB(26, primary.red, primary.green, primary.blue),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(10, 0, 0, 0),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더 (상태 아이콘, 제목, 시간)
              Row(
                children: [
                  // 상태 아이콘
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(26, statusColor.red, statusColor.green, statusColor.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      messageStatusIcon(chat.status),
                      color: statusColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // 제목과 시간
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF503123),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chat.employerName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFFa48e7b),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 시간
                  Text(
                    _formatTime(chat.lastMessageTime),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 메시지 내용과 상태
              Row(
                children: [
                  // 타입 칩
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(26, typeColor.red, typeColor.green, typeColor.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      chatTypeLabel(chat.type),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: typeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 8),
                  
                  // 상태 칩
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(26, statusColor.red, statusColor.green, statusColor.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      messageStatusLabel(chat.status),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // 읽지 않은 메시지 수
                  if (chat.unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        chat.unreadCount.toString(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // 마지막 메시지
              Text(
                chat.lastMessage,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
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
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primary : Color.fromARGB(26, primary.red, primary.green, primary.blue),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primary : Color.fromARGB(77, primary.red, primary.green, primary.blue),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isSelected ? Colors.white : primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB(26, primary.red, primary.green, primary.blue),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              color: primary,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '메시지가 없습니다',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '새로운 대화를 시작해보세요',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFa48e7b),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
