import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice1/const/value/colors.dart';
import 'package:practice1/const/value/gaps.dart';
import 'package:practice1/const/value/text_style.dart';
import 'package:practice1/ui/route/route_setting/route_account.dart';
import 'package:practice1/ui/route/route_terms.dart';

class RouteSetting extends StatefulWidget {
  const RouteSetting({super.key,});

  @override
  State<RouteSetting> createState() => _RouteSettingState();
}

class _RouteSettingState extends State<RouteSetting> {
  final ValueNotifier<bool> vnCheckBoxTerm1 = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정', style: TS.s18w600(colorBlack)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Gaps.v16,
              GestureDetector(onTap: (){Navigator.of(context).push(
                MaterialPageRoute(
                builder: (_) => RouteAccount(),
                ),
              );}, child: SettingBox(text: '계정 관리')),
              SettingBox(text: '알림 설정'),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (_) => RouteTerms(title: '(필수) 이용약관 동의', vnCheckBoxTerm: vnCheckBoxTerm1)
                    ),
                  );
                },
                child: SettingBox(text: '이용 약관'),
              ),
              SettingBox(text: '개인정보 보호정책'),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingBox extends StatelessWidget {
  final String text;

  const SettingBox({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: Colors.transparent,
      child: Row(
        children: [
          Text(text, style: TS.s16w500(colorBlack)),
          Spacer(),
          SvgPicture.asset('assets/icon/right_arrow.svg'),
        ],
      ),
    );
  }
}
