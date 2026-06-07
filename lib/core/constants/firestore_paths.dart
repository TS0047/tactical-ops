class FirestorePaths {
  FirestorePaths._();

  static String user(String uid) => 'users/$uid';
  static String tasks(String uid) => 'users/$uid/tasks';
  static String task(String uid, String taskId) => 'users/$uid/tasks/$taskId';
  static String reminders(String uid) => 'users/$uid/reminders';
  static String reminder(String uid, String id) => 'users/$uid/reminders/$id';
  static String dailyPlans(String uid) => 'users/$uid/daily_plans';
  static String dailyPlan(String uid, String dateKey) => 'users/$uid/daily_plans/$dateKey';
  static String debriefs(String uid) => 'users/$uid/debriefs';
  static String debrief(String uid, String dateKey) => 'users/$uid/debriefs/$dateKey';
  static String quotes(String uid) => 'users/$uid/quotes';
  static String quote(String uid, String quoteId) => 'users/$uid/quotes/$quoteId';
}
