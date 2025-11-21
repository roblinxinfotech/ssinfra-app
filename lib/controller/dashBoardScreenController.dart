import 'package:get/get.dart';
import 'package:ssinfra/view/formScreen.dart';
import 'package:ssinfra/view/homeScreen.dart';
import 'package:ssinfra/view/talukaScreen.dart';
import 'package:ssinfra/view/teamScreen.dart';
import 'package:ssinfra/view/villageScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/profileScreen.dart';

class DashBoardScreenController extends GetxController {
  RxList permissions = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPermissions();
  }

  RxInt selectedNavIndex = 0.obs;
  List pages = [
    () => HomeScreen(),
    () => TalukaScreen(),
    () => VillageScreen(),
    () => TeamScreen(),
    () => ProfileScreen(),
    // () => ELibraryScreen(),
    // () => VideoLibraryScreen(),
    // () => MaintenanceTaskScreen(),
    // () => TaskListScreen(),
    // () => EmployeesScreen(),
    // () => ReportScreen(),
    // () => TaskListScreen(),
    // () => PreventingMaintenanceScreen(),
    // () => OperatorUserListScreen(),
    // () => HomeScreens(),
    // () => MyPerformanceScreen(),
    // () => OperationalTaskGraphScreen(),
    // () => PreventiveTaskGraphScreen(),
    // () => BreakDownTaskGraphScreen(),
  ];

  Future<void> getPermissions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? permission = await prefs.getStringList("permissions");
    print(permission?.length);
    print("permission?.length");
    if (permission?.length != 0) {
      permissions.value = permission!;
    }
  }
}
