# **Tutoring Board - 과외 일정 관리**       
<img width="910" alt="스크린샷 2023-11-07 오후 9 23 31" src="https://github.com/ha-ny/TutoringSchedule/assets/130643750/c91e75c4-3a44-42b2-b38b-3ec5e7e09bf9">

### **앱 스토어**
[App Store에서 제공하는 튜터링보드 - 과외일정 관리 (apple.com)](https://apps.apple.com/kr/app/%ED%8A%9C%ED%84%B0%EB%A7%81%EB%B3%B4%EB%93%9C-%EA%B3%BC%EC%99%B8%EC%9D%BC%EC%A0%95-%EA%B4%80%EB%A6%AC/id6470282118)
<br>
### **소개**
학생 정보와 수업 일정 입력시 기간 동안의 일정을 캘린더로 확인할 수 있습니다.
<br>

### **앱 기능**
1. 캘린더: Monthly / Weekly 원하는 타입으로 그날의 일정을 확인할 수 있습니다. 
2. 수업 등록: 수업 정보(수업명, 수업 장소, 과외 기간, 수업 요일 및 시간, 학생)을 저장할 수 있습니다.
3. 수업 관리: 저장된 수업 리스트와, 수업 추가 및 수정, 삭제가 가능합니다
4. 학생 등록: 학생 정보(이름, 학생 연락처, 학부모 연락처, 주소, 메모)를 저장할 수 있습니다
5. 학생 관리: 저장된 학생 리스트와 학생 추가 및 수정, 삭제가 가능합니다

### **개발**
기간: 2023.09.27 ~ 2023.10.25<br>
최소 지원버전: iOS 15<br>
다국어 대응 O<br>

### **기술**
**Architecture :** `MVVM`   | **DB :** `Realm`<br>
**UI :** `UIKit` `CodeBaseUI` `SnapKit` `UITableView` `UISwipeGestureRecognizer` `UITabGestureRecognizer`<br>
**Etc** : `RxSwift` `FSCalendar` `TextFieldEffects` `Toast` `FireBase Crashlytics`, `FireBase Analytics`<br>
<br>

### **기능 구현**
- `MVVM Architecture` : 구조화로 코드의 가독성과 유지보수성 향상
- `Realm` 을 통해 앱 내부의 데이터를 효율적으로 관리
- `filter` 메서드로 조건에 맞춘 데이터 추출 및 필터링
- `FSCalendar` : 필요에 따라 달력의 스타일 변경
- Firebase `Crashlytics` ,`Analytics`로 앱의 안정성 모니터링 및 크래시 추적
- `SnapKit` 을 통한 `CodeBaseUI` 구현
- `TableView`, `scrollView`로 데이터 시각적 렌더링
<br>

### **트러블 슈팅**
**- UI 중첩 해결** <br>
<img width="164" alt="스크린샷 2023-11-04 오전 10 11 44" src="https://github.com/ha-ny/TutoringSchedule/assets/130643750/20068547-98ef-4116-b3fc-2effc5683b25"><br>
문제: 테스트 중 캘린더의 Label이 중첩되고 있는 것을 발견.<br>
해결: willDisplay 메서드 내에서 셀의 서브뷰 중, UILabel인 항목을 찾아 제거<br><br>
<img width="709" alt="스크린샷 2023-11-04 오전 10 12 22" src="https://github.com/ha-ny/TutoringSchedule/assets/130643750/59f066af-b7ac-45a3-a7f6-d9b2305c97ec">

**- 코드 재활용**<br>
문제: 각각의 Realm 테이블마다 별도의 RealmRepository 파일 생성 → 중복 코드 발생 및 코드의 유지보수, 확장의 어려움<br>
해결: Generic 타입 사용으로 여러 객체에 대한 동일 코드 재사용<br><br>
<img width="446" alt="스크린샷 2023-11-04 오전 10 12 55" src="https://github.com/ha-ny/TutoringSchedule/assets/130643750/f78b6f71-5fbe-4e5c-8e01-98ef23ebfaed">

**- 강한 순환 참조**<br>
해결: 메모리 누수의 가능성이 있어 [weak self] 를 통한 참조 타입을 캡처<br><br>
<img width="709" alt="스크린샷 2023-11-04 오전 10 13 09" src="https://github.com/ha-ny/TutoringSchedule/assets/130643750/7ce1cb5f-4836-4507-a26d-1cce7d97ab4b">

### **회고**
**- 목표 성과:**  
 출시 후 프로젝트 기획서를 살펴보니, 개발에 예상보다 많은 시간이 소요되었음을 알 수 있었습니다.<br>
 개발 일지를 꾸준히 작성하고 데일리 회고를 진행했지만, 목표했던 모든 기능을 완성하지 못한 점이 아쉽습니다.

**- 코드 개선:**  
 프로젝트 진행 중 꾸준히 멘토님에게 코드 리뷰를 요청하여 피드백을 받았습니다.<br>
 코드의 가독성과 유지보수성을 개선하기 위해 코드 리팩토링을 시도했고, 더 효율적인 코드를 작성하기 위해 노력했습니다.

**- 앞으로의 도전:**  
 출시 후 RXSwift를 도입하기 위해 코드를 수정하고 있습니다.<br>
 이를 통해 다음 업데이트에서는 더 발전된 코드와 기능을 준비할 수 있게 될 것입니다.<br>
<br>

### **작업일지**
| 일자   | 작업 내용                                                                                   | 일자   | 작업 내용                                                               |
|-------|------------------------------------------------------------------------------------------|-------|----------------------------------------------------------------------|
| 09.27 | • 프로젝트 기본 세팅 (1h → 15m) <br> • 다국어 지원 및 탭바 컨트롤러 추가 (1h → 38m) <br> • 메인 캘린더 생성 (3h → 4h) | 10.12 | • 수업등록 <br> 1. 데이터 생성 (2h → 2h) <br> 2. 삭제 - 데이터 일괄 삭제 (현재 날짜 이전 데이터는 지우지 않음) (1h → 1h30m) <br> • 코드 정리(3h → 2h 10m) |
| 09.28 | • 메인 캘린더 수정(3h →1h 40m) <br> • 검색 화면 완성(2h →2h 20m)                            | 10.15 | • 수업등록 <br> 1. 데이터 수정 (30m → 1h) <br> 2. 시작날짜 선택시 종료날짜 변경 (30m → 10m) <br> 3. 테스트 완료 - 완성! (10m → 10m) <br> • 캘린더 <br> 1. 상단 DatePicker 삭제 (10m → 5m) <br> 2. 캘린더 위 Label 디자인 변경 (20m → 45m) <br> 3. 날짜 선택시 tableView 데이터 reload (10m → 15m) |
| 10.01 | • 학생관리 화면 생성 (1h → 30m) <br> • 학생 등록 화면 생성 (1h → 1h 30m) <br> • realm 구조 잡기 (1h → 30m) <br> • 학생 등록 데이터 생성 (1h → 21m) | 10.16 | • 캘린더 <br> 1. 캘린더 Label 오류 수정 (30m → 30m) <br> 2. tableView data setting (30m → 20m) <br> 3. 오늘 날짜 선택시 tableView data 변경 (30m → 15m) |
| 10.03 | • 일정 등록 화면, 수업 등록 화면 디자인 합침 (2h→ 3h 30m) <br> • sheetPresentationController 사용 (1h → 1h 20m) | 10.18 | • 캘린더 <br> 1. 수업 저장시 캘린더 다시 그리기 Notification Center (30m → 30m) <br> 2. 캘린더 상단 pickerView - Label로 변경 (10m → 5m) <br> • realm <br> 1. 학생, 수업 table구조 변경 - 삭제 대신 isHidden true (30m → 10m) <br> 2. 검색 및 데이터 불러올때 isHidden check 로직 생성(30m → 20m) |
| 10.05 | • 코드 정리(1h → 2h 30m) <br> • 수업등록 디자인 변경(40m → 30m) <br> • 학생 목록 sheet 생성(30m → 30m) | 10.19 | • 수업등록 <br> 1. 요일 PickerView 휠 돌릴때 label에 보여주기 - 대충 돌리고 저장 버튼 누르면 기본값이 저장됨 (15m → 30m) <br> • MVC → MVVM 구조 변경 <br> 1. EditStudent 완성! (1h → 2h25m) |
| 10.06 | • pickerView loop 수정 (30m → 40m) <br> • 일정등록 화면 디자인 변경 - 시작날짜/종료날짜 추가 (30m → 1h) <br> • 요일 데이터 update 대응 (30m → 5m) <br> • 일정관리 리스트 완성 (30m → 45h) <br> • delegate → 저장 버튼 눌렀을 때만 tableView reload (30m → 15m) <br> • generic → RealmRepository (1h → 1h) <br> • realm table 완성 (1h → 1h 20m) | 10.21 | MVC → MVVM 구조 변경 <br> • StudentManagementView 완성 (1h → 1h) <br> • ClassManagementView 완성 (1h → 20m) <br> • CalendarViewr 완성 (1h → 40m) <br> • 코드 정리(1h → 55m) |
| 10.08 | • 학생 관리 / 일정 등록 리스트, 추가화면 - 뷰, 컨트롤러 구분 (1h → 1h30m) <br> • 학생관리 <br> 1. 리스트 삭제(realm)  (30m → 30m) <br> 2. 리스트 sort(realm) (30m → 15m) <br> 3. 추가 화면 - 필수 체크(Name), textField 포커스 변경 구현 (30m → 45m) | 10.22 | MVC → MVVM 구조 변경 <br> • EditClassView 완성 (1h → 1h) <br> • StudentListView 완성 (1h → 30h) <br> • DatePickHalfView 완성 (1h → 20h) <br> • 파일 정리 (30m → 20m) |
| 10.09 | • 학생 관리 <br> 1. 연락처 가져오기 - 권한 체크 <br> 2. 학생 관리 리스트 클릭 → 수정화면 구현 + realm Update | 10.23 | • Error Handleing 완성  (3h → 1h 50m) <br> • 다국어 처리 완성  (2h → 1h 30m) |
| 10.10 | • 학생 관리 테스트+데이터 완성 (2h → 2h) <br> • 개발 범위 줄이기 (30m → 15m) <br> • realm SchemaVersion 생성 | 10.25 | • 테스트 (2h → 7h) <br> 1. 수업 저장 후 캘린더, 리스트 reload <br> 2. 수업일정 - realm table 수정 <br> 3. 일정 삭제시 오류 → newTable에 값 새로 넣고 isHidden true <br> 4. 캘린더 리스트 select <br> • 앱 로고 제작 (20m → 1h) <br> • 앱 심사 제출 (1m → 2h) |
| 10.11 | • 학생 등록 <br> 1. Add/update 코드 합침 → EditView (1h → 1h 10m) <br> 2. 테스트 완료 - 완성! (10m → 15m) <br> • 수업 등록 <br> 1. Add/update 코드 합침 → EditView (1h → 30m) | 10.26 | 출시 완료 |

