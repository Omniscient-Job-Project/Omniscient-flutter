import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../widgets/profile_image.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 임시로 사용할 기본 프로필 데이터
  final UserProfile profile = UserProfile(
    name: '홍길동',
    jobTitle: '소프트웨어 엔지니어',
    email: 'hong@example.com',
    phone: '010-1234-5678',
    age: 29,
    address: '서울특별시 강남구',
    certificates: ['정보처리기사', 'AWS 인증'],
    profileImages: ['https://via.placeholder.com/150'],
    status: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 관리'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 프로필 이미지와 기본 정보가 있는 섹션
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 프로필 이미지
                ProfileImage(
                  imageUrl: profile.profileImages.isNotEmpty
                      ? profile.profileImages[0]
                      : 'https://via.placeholder.com/150',
                  width: 150,
                  height: 150, onImageClick: () {  },
                ),
                SizedBox(width: 24),
                // 프로필 정보
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileSection('이름', profile.name),
                      _buildProfileSection('직책', profile.jobTitle),
                      _buildProfileSection('이메일', profile.email),
                      _buildProfileSection('전화번호', profile.phone),
                      _buildProfileSection('나이', '${profile.age}세'),
                      _buildProfileSection('주소', profile.address),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // 자격증 정보
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '자격증',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true, // ListView가 Column 안에서 작동하도록 설정
                  physics: NeverScrollableScrollPhysics(), // 스크롤은 부모에서 처리
                  itemCount: profile.certificates.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        profile.certificates[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
