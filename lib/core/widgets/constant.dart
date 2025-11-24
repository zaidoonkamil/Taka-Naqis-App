import '../ navigation/navigation.dart';
import '../../features/auth/view/login.dart';
import '../network/local/cache_helper.dart';

String token='';
int classId=1;
String className='';
String id='';
String adminOrUser='' ;
String phoneWoner='7736699924' ;
String logo='IMG_4796.PNG' ;
String nameApp='طكة ناقص - ارخص الاسعار' ;


void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    token='';
    adminOrUser='' ;
    id='' ;
    if (value)
    {
      CacheHelper.removeData(key: 'role',);
      CacheHelper.removeData(key: 'id',);
      navigateTo(context, const Login(),);
    }
  });
}
