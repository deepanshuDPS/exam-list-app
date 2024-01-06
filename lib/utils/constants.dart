class Constants {
  static String baseURL =
      'https://skilled-officially-squirrel.ngrok-free.app/v1/'; // 'http://192.168.29.174:8080/'; //

  static Map<int, String> genders = {
    0: 'Others',
    1: 'Male',
    2: 'Female',
  };

  // Filters for the exams list
  static Map<int, String> examCategories = {
    0: 'All',
    1: 'All India',
    2: 'State',
    3: 'Railways',
    4: 'Police/Defence',
    5: 'Banks',
    6: 'Teaching',
  };

  static List examCatIndexPriority = [0, 1, 6, 2, 3, 4, 5];

  // Filters for the resources list
  static Map<int, String> resourcesCategories = {
    0: 'All',
    1: 'Books',
    2: 'Videos',
  };

  // Categories for the category list
  static Map<String, int> reservationCategories = {
    'General': 0,
    'OBC': 1,
    'SC': 2,
    'ST': 3,
    'EWS': 4,
  };

  static Map<String, int> educationalQualifications = {
    'High School (10th Pass)': 0,
    'Intermediate (12th Pass)': 1,
    'Diploma': 2,
    'Bachelor\'s Degree (UG)': 3,
    'Master\'s Degree (PG)': 4,
    'Ph.D.': 5,
  };

  static Map<String, int> additionalQualifications = {
    'None': -1,
    'JBT': 20,
    'D Ed': 21,
    'B Ed': 22,
  };

  static Map<String, int> disabilityCategories = {
    'None': -1,
    'OD-Orthopedic Disability': 20,
    'VI-Visual Impairment': 21,
    'HI-Hearing Impairment': 22,
    'LD-Learning Disability': 23,
    'MD-Multiple Disability': 24
  };

  static String userData = 'USER_DATA';
  static String fcmToken = 'FCM_TOKEN';
  static String isFcmTokenSent = 'IS_FCM_TOKEN_SENT';
  static String currentVersion = 'CURRENT_VERSION';
  static String subscriptions = 'SUBSCRIPTIONS';

  static String apiKey =
      '122a3a8234a618432663194ba6116194970c116f4014feac40d215f9cee62a17';

  static String somethingWentWrong = 'Something went wrong';
}
