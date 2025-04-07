import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._ctor();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._ctor();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

//-------------------------------------------------------------
  static void setFirstName({required String firstName}) {
    _prefs.setString("firstName", firstName);
  }

  static String getFirstName() {
    return _prefs.getString("firstName") ?? "";
  }

  static void setToken({required String token}) {
    _prefs.setString("token", token);
  }

  static String getToken() {
    return _prefs.getString("token") ?? "";
  }

  //-------------------------------------------------------------
  // static void setId({required String id}) {
  //   _prefs.setString("id", id);
  // }

  // static String getId() {
  //   return _prefs.getString("id") ?? "";
  // }

  //-------------------------------------------------------------
  static void setAadharNumber({required String aadharNumber}) {
    _prefs.setString("aadharNumber", aadharNumber);
  }

  static String getaadharNumber() {
    return _prefs.getString("aadharNumber") ?? "";
  }

  //-------------------------------------------------------------
  static void setPanNumber({required String panNumber}) {
    _prefs.setString("panNumber", panNumber);
  }

  static String getPanNumber() {
    return _prefs.getString("panNumber") ?? "";
  }

//-----------------------------------------------------------
  static void setLastName({required String lastName}) {
    _prefs.setString("lastName", lastName);
  }

  static String getLastName() {
    return _prefs.getString("lastName") ?? "";
  }

//------------------------------------------------------------
  static void setUserEmail({required String userEmail}) {
    _prefs.setString("useremail", userEmail);
  }

  static String getUserEmail() {
    return _prefs.getString("useremail") ?? "";
  }

//-------------------------------------------------------------
  static void setUserPhone({required String userPhone}) {
    _prefs.setString("userphone", userPhone);
  }

  static String getUserPhone() {
    return _prefs.getString("userphone") ?? "";
  }

//--------------------------------------------------------------
  static void setUserProfilePic({required String userPic}) {
    _prefs.setString("userpic", userPic);
  }

  static String getUserProfilePic() {
    return _prefs.getString("userpic") ?? "";
  }

//---------------------------------------------------------------
  static String getUserId() {
    if (_prefs.getString("user_new_id") == null) {
      return '';
    }
    return _prefs.getString("user_new_id").toString();
  }

  static void setNewUserId({required String userId}) {
    _prefs.setString("user_new_id", userId);
  }

//---------------------------------------------------------------
  static String getUsertempId() {
    if (_prefs.getString("User_temp_Id") == null) {
      return '';
    }
    return _prefs.getString("User_temp_Id").toString();
  }

  static void setUsertempId({required String usertempId}) {
    _prefs.setString("User_temp_Id", usertempId);
  }

//-------------------------------------------------------------------
  static void setUserDob({required String userDob}) {
    _prefs.setString("userdob", userDob);
  }

  static String getUserDob() {
    return _prefs.getString("userdob") ?? "";
  }

//-----------------------------------------------------------------
  static void setUserGender({required String userGender}) {
    _prefs.setString("userGender", userGender);
  }

  static String getUserGender() {
    return _prefs.getString("userGender") ?? "";
  }

//--------------------------------------------------------------------
  static void setUserGST({required String userGST}) {
    _prefs.setString("userGST", userGST);
  }

  static String getUserGST() {
    return _prefs.getString("userGST") ?? "";
  }

//-------------------------------------------------------------------
  static void setIsLoggedIn({required bool isLoggedIn}) {
    _prefs.setBool("isLoggedIn", isLoggedIn);
  }

  static bool getIsLoggedIn() {
    return _prefs.getBool("isLoggedIn") ?? false;
  }

//-------------------------------------------------------------------
  static void setisFirstTime({required bool isFirstTime}) {
    _prefs.setBool("isFirstTime", isFirstTime);
  }

  static bool getisFirstTime() {
    return _prefs.getBool("isFirstTime") ?? true;
  }

//-------------------------------------------------------------------
  static void setisAccountDeleted({required bool isAccountDeleted}) {
    _prefs.setBool("isAccountDeleted", isAccountDeleted);
  }

  static bool getisAccountDeleted() {
    return _prefs.getBool("isAccountDeleted") ?? false;
  }

//-------------------------------------------------------------------
  static void clearShareCache() {
    _prefs.clear();
  }
//-------------------------------------------------------------------

  static void setCommission({required String commission}) {
    _prefs.setString("commission", commission);
  }

  static String getCommission() {
    return _prefs.getString("commission") ?? "0";
  }

  //-------------------------------------------------------------------

  static void setTotalCommission({required String totalcommission}) {
    _prefs.setString("totalcommission", totalcommission);
  }

  static String getTotalCommission() {
    return _prefs.getString("totalcommission") ?? "0";
  }

//-----------------------------------------------------------------
  static void setAadhaar({required bool isAadhaar}) {
    _prefs.setBool("isAadhar", isAadhaar);
  }

  static bool getAadhaar() {
    return _prefs.getBool("isAadhar") ?? false;
  }

//----------------------------------------------------------------
  static void setPan({required bool isPan}) {
    _prefs.setBool("isPan", isPan);
  }

  static bool getPan() {
    return _prefs.getBool("isPan") ?? false;
  }

//----------------------------------------------------------------
  static void setAggrement({required bool isAggrement}) {
    _prefs.setBool("isAggrement", isAggrement);
  }

  static bool getAggrement() {
    return _prefs.getBool("isAggrement") ?? false;
  }

//---------------------------------------------------------------
  static void setVisiting({required bool isVisiting}) {
    _prefs.setBool("isVisiting", isVisiting);
  }

  static bool getVisiting() {
    return _prefs.getBool("isVisiting") ?? false;
  }

//---------------------------------------------------------------
  static void setCases({required int cases}) {
    _prefs.setInt("cases", cases);
  }

  static int getCases() {
    return _prefs.getInt("cases") ?? 0;
  }

//---------------------------------------------------------------
  static void setCustomerCount({required int customerCount}) {
    _prefs.setInt("customerCount", customerCount);
  }

  static int getcustomerCount() {
    return _prefs.getInt("customerCount") ?? 0;
  }
//---------------------------------------------------------------

  static void setUserCity({required String userCity}) {
    _prefs.setString("userCity", userCity);
  }

  static String getUserCity() {
    return _prefs.getString("userCity") ?? '';
  }
//---------------------------------------------------------------

  static void setReferalCode({required String referalCode}) {
    _prefs.setString("referalCode", referalCode);
  }

  static String getReferalCode() {
    return _prefs.getString("referalCode") ?? '';
  }

//---------------------------------------------------------------
  static void setUserState({required String userState}) {
    _prefs.setString("userState", userState);
  }

  static String getUserState() {
    return _prefs.getString("userState") ?? '';
  }
//---------------------------------------------------------------
}

enum UserPref {
  AuthToken,
}
