import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/models/user_profile.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/avatar_picker_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Временные данные в будущем будут загружаться из БД
  late UserProfile _userProfile;
  File? _selectedAvatar;

  @override
  void initState() {
    super.initState();
    // Инициализация с тестовыми данными
    _userProfile = UserProfile(
      id: '1',
      name: 'Виталий Казанцев',
      position: 'Head Master Hookah (senior)',
      workplace: 'Timeless 1',
      expirienceYears: 1,
      expirienceMonths: 5,
    );
  }

  void _handleAvatarSelected(File imageFile) {
    setState(() {
      _selectedAvatar = imageFile;
      _userProfile = _userProfile.copyWidth(avatarPath: imageFile.path);
    });
    print('Аватар выбран: ${imageFile.path}');
    // Здесь будет логика загрузки на сервер
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131419),
      appBar: AppBarWidget(),
      bottomNavigationBar: BottomNavbar(selected: 2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              AvatarPickerWidget(
                onImageSelected: _handleAvatarSelected,
                initialImagePath: _userProfile.avatarPath,
                initialImageUrl: _userProfile.avatarUrl,
              ),
              SizedBox(height: 24),
              // Имя пользователя
              Text(
                _userProfile.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),

              // Должность
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color(0xFFD07B59),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    _userProfile.position,
                    style: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              const PopupMenuDivider(height: 1),
              SizedBox(height: 24),

              //Карточка с опытом
              _buildInfoCart(
                iconPath: 'AppMaterial/bookExpIcon.png',
                label: 'Опыт',
                value: _userProfile.formattedExpirience,
              ),

              // Карточка с местом
              _buildInfoCart(
                iconPath: 'AppMaterial/geoIcon.png',
                label: 'Гео',
                value: _userProfile.workplace,
                isLocation: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCart({
    required String iconPath,
    required String label,
    required String value,
    bool isLocation = false
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFF131419),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: Image.asset(
              iconPath,
              color: Color(0xFF4B4B4D),
              width: 24,
              height: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (isLocation)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF313237),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          if (isLocation == false)
            Container(
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}