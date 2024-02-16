# WaitForMe - Google Solution Challange 2024

![Banner](https://github.com/altair2503/WaitForMe/blob/main/readme/Banner.png)

---

USED TECHNOLOGIES
-----------------------
![Technologies](https://github.com/altair2503/WaitForMe/blob/main/readme/Technologies.png)

---

PREPARING FOR IMPORTING
-----------------------
#### To start importing a project, you need to:
[Flutter](https://docs.flutter.dev/get-started/install) version 3.19.0 [min] and more.

This is the official documentation of Flutter, **follow the instructions** in this article to install it.

IMPORTING
---------
Step-by-step instructions for importing the `WaitForMe` project.

#### 1. Download ZIP and unpacking
[Download our ZIP](https://github.com/altair2503/WaitForMe/archive/refs/heads/main.zip) archive and unpack it to the folder you want. You will see the following files and directories:

      android/                  for [android] part
      assets/                   project resources folder
      ios/                      for [ios] part       
      lib/                      project source folder
      linux/
      macos/                    for [macOS] part
      readme/                   resources for README.md
      test/
      web/                      for [web]
      windows/                  for [windowsOS]
      .gitignore
      .metadata
      README.md                 
      analysis_options.yaml     
      ↓ <files with all necessary dependencies>
      pubspec.lock
      pubspec.yaml
ㅤ  
You can also import our project using the `git clone` command. To do this, you need to go to the command prompt and specify the path to the folder where you will import the project.  

Next you will need to enter the following:
      
      git clone https://github.com/altair2503/WaitForMe.git

#### 2. The path in the command prompt
Specify the path to the folder where you unpacked the ZIP archive in the command prompt.
 ㅤ
#### 3. Installing libraries and modules
Since the project does not contain all the necessary dependencies, you will need to install them.

To do this, you need to enter the following command:

      flutter pub get
      

---

PROJECT START
-------------
After completing all the steps described in the instructions, connect your `mobile device` or `emulator`, and launch the project by typing the following command in the command prompt:

      flutter run
