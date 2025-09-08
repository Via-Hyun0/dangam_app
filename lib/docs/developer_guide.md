# 단감 앱 개발자 가이드

## 📋 TODO::LUKA - Firebase 연결 작업 목록

### 1. Firebase 프로젝트 설정
- [ ] Firebase 콘솔에서 새 프로젝트 생성
- [ ] Android 앱 등록 (google-services.json 다운로드)
- [ ] iOS 앱 등록 (GoogleService-Info.plist 다운로드)
- [ ] Firebase SDK 의존성 추가 (pubspec.yaml)

### 2. Firebase 서비스 설정
- [ ] **Firebase Auth**: 사용자 인증 시스템
  - 이메일/비밀번호 로그인
  - 전화번호 인증 (선택사항)
  - 소셜 로그인 (Google, Apple)
- [ ] **Cloud Firestore**: 데이터베이스
  - 컬렉션 구조 설계
  - 보안 규칙 설정
  - 인덱스 설정
- [ ] **Firebase Storage**: 파일 저장소
  - 프로필 이미지 업로드
  - 작업 관련 이미지 저장
- [ ] **Cloud Functions**: 서버 로직 (선택사항)
  - 알림 발송
  - 작업 매칭 로직
  - 데이터 검증

### 3. 코드 수정 작업

#### 3.1 Firebase 초기화
```dart
// lib/firebase/firebase_config.dart
// 주석 해제하고 실제 Firebase 초기화 코드 작성
```

#### 3.2 Repository 구현체 교체
```dart
// lib/repositories/user_repository.dart
// MockUserRepository → FirebaseUserRepository로 교체

// lib/repositories/job_repository.dart  
// MockJobRepository → FirebaseJobRepository로 교체

// lib/repositories/notification_repository.dart
// MockNotificationRepository → FirebaseNotificationRepository로 교체
```

#### 3.3 의존성 추가
```yaml
# pubspec.yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  firebase_storage: ^11.5.6
  geoflutterfire2: ^2.3.14  # 위치 기반 검색용
```

### 4. 데이터베이스 구조

#### 4.1 Firestore 컬렉션
```
users/{userId}
├── 기본 프로필 정보
├── 통계 데이터
└── 설정 정보

jobs/{jobId}
├── 작업 정보
├── 위치 정보 (GeoPoint)
├── 상태 정보
└── 메타데이터

notifications/{notificationId}
├── 사용자 ID
├── 알림 내용
├── 읽음 상태
└── 타임스탬프

chats/{chatId}
├── 참여자 목록
├── 마지막 메시지
└── messages/{messageId}
    ├── 발신자
    ├── 내용
    └── 타임스탬프

contracts/{contractId}
├── 작업 ID
├── 근로자 ID
├── 고용주 ID
├── 계약 조건
└── 상태 정보
```

#### 4.2 보안 규칙 예시
```javascript
// Firestore 보안 규칙
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 사용자 데이터
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // 작업 데이터
    match /jobs/{jobId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        (resource == null || resource.data.createdBy == request.auth.uid);
    }
    
    // 알림 데이터
    match /notifications/{notificationId} {
      allow read, write: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
  }
}
```

### 5. 테스트 및 검증

#### 5.1 단위 테스트
- [ ] Repository 인터페이스 테스트
- [ ] 데이터 모델 테스트
- [ ] 서비스 레이어 테스트

#### 5.2 통합 테스트
- [ ] Firebase 연결 테스트
- [ ] 인증 플로우 테스트
- [ ] 데이터 동기화 테스트

#### 5.3 성능 테스트
- [ ] 대용량 데이터 처리
- [ ] 오프라인 모드 테스트
- [ ] 네트워크 지연 시뮬레이션

### 6. 배포 및 모니터링

#### 6.1 Firebase 콘솔 설정
- [ ] Analytics 설정
- [ ] Crashlytics 설정
- [ ] Performance Monitoring 설정

#### 6.2 앱 스토어 배포
- [ ] Android APK/AAB 빌드
- [ ] iOS IPA 빌드
- [ ] 스토어 등록 및 심사

## 🔧 현재 구현 상태

### ✅ 완료된 작업
- [x] 데이터 모델 정의 (UserProfile, Job, NotificationItem)
- [x] Repository 인터페이스 설계
- [x] 목업 Repository 구현
- [x] DataService 중앙 관리 클래스
- [x] Firebase 설정 파일 구조
- [x] 개발자 가이드 문서

### 🚧 진행 중인 작업
- [ ] 기존 페이지들을 새로운 데이터 구조로 업데이트

### ⏳ 대기 중인 작업
- [ ] Firebase 프로젝트 설정
- [ ] Firebase Repository 구현체 작성
- [ ] 실제 Firebase 연결 및 테스트

## 📝 개발 노트

### 아키텍처 패턴
- **Repository Pattern**: 데이터 접근 계층 분리
- **Service Layer**: 비즈니스 로직 중앙화
- **Dependency Injection**: 의존성 관리 (향후 추가 예정)

### 에러 핸들링
- 모든 Repository 메서드에 try-catch 적용
- 사용자 친화적인 에러 메시지
- 로깅 및 모니터링 준비

### 성능 최적화
- Firestore 쿼리 최적화
- 이미지 캐싱 전략
- 오프라인 데이터 동기화

## 🚀 다음 단계

1. **Firebase 프로젝트 생성 및 설정**
2. **Firebase Repository 구현체 작성**
3. **기존 페이지들 업데이트**
4. **테스트 및 검증**
5. **배포 준비**

---

**개발자**: LUKA  
**최종 업데이트**: 2024년 1월  
**버전**: 1.0.0
