import 'package:flutter/material.dart';

class ReviewsPage extends StatefulWidget {
  final double rating;

  const ReviewsPage({
    super.key,
    required this.rating,
  });

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    // 모의 리뷰 데이터
    final List<Map<String, dynamic>> reviews = [
      {
        'employer': '김농장',
        'job': '포도 수확 작업',
        'rating': 5.0,
        'comment': '정말 성실하고 꼼꼼하게 작업해주셨습니다. 다음에도 꼭 부탁드리고 싶어요!',
        'date': '2024-01-15',
        'response': '감사합니다! 좋은 평가 주셔서 기뻐요.',
      },
      {
        'employer': '이농장',
        'job': '딸기 정리 작업',
        'rating': 4.8,
        'comment': '시간을 잘 지키시고 작업도 깔끔하게 해주셨어요. 추천합니다.',
        'date': '2024-01-20',
        'response': null,
      },
      {
        'employer': '박농장',
        'job': '토마토 심기',
        'rating': 5.0,
        'comment': '경험이 풍부하시고 농사에 대한 지식이 많으시네요. 훌륭한 작업이었습니다.',
        'date': '2024-01-25',
        'response': '도움이 되었다니 다행입니다. 감사합니다!',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF503123),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFfdfdfd),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
        children: [
          // 평점 요약
          _buildRatingSummary(context, primary),
          
          const SizedBox(height: 24),
          
          // 리뷰 목록
          _buildReviewsList(context, reviews, primary),
        ],
        ),
      ),
    );
  }

  Widget _buildRatingSummary(BuildContext context, Color primary) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary.withOpacity(0.1),
            primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // 평점
          Row(
            children: [
              Text(
                widget.rating.toString(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF503123),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < widget.rating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 24,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${reviews.length}개의 리뷰',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFa48e7b),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // 평점 분포
          _buildRatingDistribution(context),
        ],
      ),
    );
  }

  Widget _buildRatingDistribution(BuildContext context) {
    final Map<int, int> ratingCounts = {
      5: 8,
      4: 2,
      3: 1,
      2: 0,
      1: 0,
    };
    
    return Column(
      children: [
        for (int rating = 5; rating >= 1; rating--) ...[
          Row(
            children: [
              Text(
                '$rating',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF503123),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LinearProgressIndicator(
                  value: ratingCounts[rating]! / 11,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  borderRadius: BorderRadius.circular(4),
                  minHeight: 8,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${ratingCounts[rating]}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF503123),
                ),
              ),
            ],
          ),
          if (rating > 1) const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _buildReviewsList(BuildContext context, List<Map<String, dynamic>> reviews, Color primary) {
    return Column(
      children: reviews.map((review) => _buildReviewCard(context, review, primary)).toList(),
    );
  }

  Widget _buildReviewCard(BuildContext context, Map<String, dynamic> review, Color primary) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['employer'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF503123),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review['job'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFa48e7b),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // 평점
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < review['rating'].floor() ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                  const SizedBox(width: 8),
                  Text(
                    review['rating'].toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF503123),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 리뷰 내용
          Text(
            review['comment'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF503123),
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // 날짜
          Text(
            review['date'],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          // 답글
          if (review['response'] != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.reply_outlined,
                    color: primary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      review['response'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF503123),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
