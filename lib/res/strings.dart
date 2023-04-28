const List<String> passwordStrings = [
  "Empty Password",
  "Less than 8 characters",
  "Include uppercase,lowercase, number and symbols : @,!,%,#",
  "Passwords do not match"
];

List<Map<String, String>> onboardPages = [
  {
    'title': 'Manage your tasks',
    'description': 'You can easily manage all of your daily tasks in DoMe for free',
    'image': 'assets/onboard1.svg'
  },
  {
    'title': 'Create daily routine',
    'description': 'In Uptodo  you can create your personalized routine to stay productive',
    'image': 'assets/onboard2.svg'    },
  {
    'title': 'Orgonaize your tasks',
    'description': 'You can organize your daily tasks by adding your tasks into separate categories',
    'image': 'assets/onboard3.svg'
  },
];

const String emailString = "Invalid email";

RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

const indexImage = 'assets/home.svg';

const homeHeadings = ["Index", "Calendar", "Focus Mode", "Profile"];
