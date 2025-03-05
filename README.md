ToDo App UI Tests (Robot Framework + Appium)
Project Overview
This project contains automated UI tests for the ToDo Android application using Robot Framework and Appium. The tests verify core functionalities like adding tasks, deleting tasks, handling empty inputs, and switching between light and dark modes.

⚙ Prerequisites
Before running the tests, ensure you have the following installed on your system:

1️ Required Software:
Python 3 (Ensure it's added to your system path)
Robot Framework
Appium Server
Node.js & NPM (Required for Appium)
Android SDK & Emulator
2️ Install Required Python Libraries:
Run the following command in your terminal to install dependencies:


pip install -r requirements.txt
(Ensure requirements.txt includes robotframework, AppiumLibrary, etc.)

 How to Run the Tests
1️ Start Appium Server:
Before running tests, open a new terminal and start Appium:



appium
2️ Connect an Android Emulator or Physical Device:
Ensure an Android emulator is running or a real device is connected:


adb devices
(This should list your device as ‘device’)

3️ Run Tests Using Robot Framework:
Navigate to the project folder and execute:

robot test.robot


📝 Test Cases Covered
Test Case	Expected Result
Open To-Do App	The app launches successfully
Add a New Task	A new task is added to the list
Cancel Adding a Task	No task is added when canceled
Adding a Task Without a Title	An error message is shown
Delete Added Task	The task is removed successfully
Switch Theme Mode	The app switches between light and dark mode
