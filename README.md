# WaitForMe - Google Solution Challange 2024

![Banner](https://github.com/altair2503/WaitForMe/blob/main/readme/Banner.png)
> WaitForMe is an application dedicated to bring people with disabilities and public transport drivers closer together. Our platform effectively addresses the challenges encountered by people with disabilities at bus stops, eradicating issues such as indifference, prolonged wait times, and unnecessary stress. By ensuring accessibility for all within urban mobility, WaitForMe is  driving positive change and making the world better for everyone.

---

UN'S SUSTAINABLE DEVELOPMENT GOALS & TARGETS
------------------
Our app connects people with disabilities and bus drivers, crucial for breaking down barriers to PwDs daily life. In doing so, we're not just addressing the specific needs of a PwD, but we're actively contributing to the implementation of two key United Nations Sustainable Development Goals:

### SDG 10: Reduced Inequalities (Target 10.2)
![SDG10](https://github.com/altair2503/WaitForMe/blob/main/readme/SDG10.png)
> WaitForMe directly addresses the social inclusion and mobility needs of people with disabilities, aligning perfectly with *Target 10.2* (Empower and promote the social, economic and political inclusion of all, irrespective of age, sex, disability, race, ethnicity, origin, religion or economic or other status).

### SDG 11: Sustainable Cities and Communities (Target 11.2)
![SDG11](https://github.com/altair2503/WaitForMe/blob/main/readme/SDG11.png)
> WaitForMe directly addresses the social inclusion and mobility needs of people with disabilities, aligning perfectly with *Target 11.2* (Provide access to safe, affordable, accessible and sustainable transport systems for all).

---

PROJECT DEMO VIDEO
------------------
![Demo Video](https://github.com/altair2503/WaitForMe/blob/main/readme/VideoCover.png)

---

USED TECHNOLOGIES
-----------------
#### To create our project, we used technologies such as
* Flutter — Firebase — Google Cloud — Dart — Google Maps
  
![Technologies](https://github.com/altair2503/WaitForMe/blob/main/readme/Technologies.png)

---

PROJECT ARCHITECTURE
------------------
![Architecture](https://github.com/altair2503/WaitForMe/blob/main/readme/ProjectArchitecture.png)

---

PROJECT FEATURES
----------------
### 1. PWD Part
| Main Screen  | Overview  | Overview  |
| :-----------: | :-----------: | ------------- |
| ![Main Screen](https://github.com/altair2503/WaitForMe/blob/main/readme/PwdMainPage.png)  | ![Overview](https://github.com/altair2503/WaitForMe/blob/main/readme/PwdUI.gif)  | **PWD** part consists of 4 screens. All processes are accompanied by a `Voice Assistant`. <br/><br/> 1. **Main Screen:** Select the number of buses you need and click `Notify`. <br/> 2. **Notifying Page:** Drivers are notified here. <br/> 3. **Waiting Page:** Here you are waiting for the driver, after entering the bus, press `"I'm in bus"`. <br/> 4. **City Selection Page:** Here you can choose a city. <br/><br/> **[Note]** <br/> In the process of notifying and waiting for drivers, you can opt out by clicking `Cancel`.  |

### 2. Driver Part
| Main Screen  | Bus Changing  | Overview  |
| :-----------: | :-----------: | ------------- |
| ![Main Screen](https://github.com/altair2503/WaitForMe/blob/main/readme/DriverMainPage.png)  | ![Overview](https://github.com/altair2503/WaitForMe/blob/main/readme/DriverUI.gif)  | **Driver** part consists of 2 screens. Processes are accompanied by a `Voice Assistant`. <br/><br/> 1. **Main Screen:** Сan see those waiting on the map. The distance to the nearest is displayed. <br/> 2. **Profile Page:** Here the driver can change the number of his bus, or finish the shift.  |

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

---

DEVELOPED BY
--------------------

| [Kapparova Aknur](https://github.com/aknurkappar)  | [Amen Azat](https://github.com/azikkw)  | [Kazieva Dina](https://github.com/KDindin)  | [Kabdrakhmanov Altair](https://github.com/altair2503)  |
| :-----------: | :-----------: | :-----------: | :-----------: |
| Front-End Developer  | Front-End Developer  | Back-End Developer  | Back-End Developer  |
| ![Aknur Photo](https://github.com/altair2503/WaitForMe/blob/main/readme/AknurPhoto.jpg)  | ![Azat Photo](https://github.com/altair2503/WaitForMe/blob/main/readme/AzatPhoto.jpg)  | ![Altair Photo](https://github.com/altair2503/WaitForMe/blob/main/readme/Dina.jpg)  | ![Altair Photo](https://github.com/altair2503/WaitForMe/blob/main/readme/AltairPhoto.jpg)  |
| [Aknur Linkedin](https://www.linkedin.com/in/aknurkapparova/)  | [Azat Linkedin](https://www.linkedin.com/in/azikkw/)  | [Dina Linkedin](https://www.linkedin.com/in/dina-kaziyeva-3565622b5/)  | [Altair Linkedin](https://www.linkedin.com/in/kabdrakhmanov/)  |
