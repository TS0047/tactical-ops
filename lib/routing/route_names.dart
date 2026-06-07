class Routes {
  Routes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const tasks = '/tasks';
  static const newTask = '/tasks/new';
  static const taskDetail = '/tasks/:id';
  static const editTask = '/tasks/:id/edit';
  static const briefing = '/briefing';
  static const pastBriefing = '/briefing/:date';
  static const debrief = '/debrief';
  static const debriefSummary = '/debrief/:date';
  static const matrix = '/matrix';
  static const opsLog = '/ops-log';
  static const reminders = '/reminders';
  static const newReminder = '/reminders/new';
  static const settings = '/settings';
}
