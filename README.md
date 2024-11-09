# QFlow (Organizer)

QFlow (Organizer App) is a Flutter-based application developed for event organizers at Tuwaiq Academy job fairs. This fully functional app enables organizers to create and manage events, track real-time attendance with QR scanning, and access detailed reports on interview statistics, in-demand majors, and participant ratings. It provides organizers with the insights they need to optimize event management and improve participant experience.

![App Clip](q_flow_organizer.gif)

- Video Explanation of app features:
   - https://drive.google.com/drive/folders/10IxiwgVqs9G982_pECdJxInAHEq2mm0H

## Table of Contents

- [App Overview](#app-overview)
- [Tools/Technologies](#toolstechnologies)
- [Features](#features)
- [Data Models](#data-models)
- [Design Philosophy](#design-philosophy)
- [Getting Started](#getting-started)
- [Future Enhancements](#future-enhancements)
- [Created By](#created-by)

## App Overview

### Tools/Technologies

1. **Dart/Flutter**
   - Programing Language and framework used to build the QFlow apps for both iOS and Android from a single codebase.

2. **Supabase**
   - Provide efficient backend management, handling database functions and user authentication.

3. **One Signal**
   - A push notification service that sends real-time notifications  about queue status and upcoming interviews.

4. **Figma**
   - A collaborative design platform for creating high-quality wireframes and prototypes.

5. **Github**
   - Enables efficient collaboration, allowing our team to manage code.

6. **Excel**
   - Manage/control invitations and attendance of Companies and Visitors.

### Features

1. **Authentication**
   - Only pre-configured emails can sign in.
   - Uses email OTP verification to ensure secure access without passwords.

2. **Home**
   - Allows organizers to create new events or select existing ones.
   - Allows organizers to create new events or select existing ones.
   
3. **Event Creation**
   - Organizers can enter details like event name, location, and dates.
   - Enables the upload of Excel files to invite specific visitors and companies to the event.

4. **Dashboard**
   - Provides QR code scanning for tracking visitor and company attendance in real time.
   - Displays comprehensive event analytics, including:
      - Attendance statistics and charts.
      - Interview counts and demand trends for skills and majors.
      - Reports on the most popular companies.
      - Company ratings overview to enhance visitor satisfaction.
      - Visitor ratings overview to improve candidate preparation for future events.

### Data Models

The app includes more than 11 data models that connect with database tables. The main ones are for:

- **Event:** Manages event details, location, dates, and attendance tracking.
- **Visitor and Company Profiles:** Stores profiles, including attendance and rating data.
- **Interview Statistics:** Tracks interview numbers, skills demand, and company popularity.
- **Rating Analytics:** Collects data on ratings for companies and visitors to provide actionable insights.

### Design Philosophy

- **Insightful Analytics:** Offers comprehensive dashboards with charts and reports to keep organizers informed on key metrics.
- **Efficient Event Management:** The Organizer App simplifies event setup, attendance tracking, and report generation.
- **User-Friendly UI:**  Organizers can easily access all features with an intuitive and well-organized layout.

### Functionality

The QFlow Organizer App gives event organizers the tools they need to manage job fairs effectively. Real-time attendance tracking, detailed reporting, and event management features provide organizers with a robust solution for overseeing all aspects of the job fair.

## Getting Started

### Prerequisites

- Flutter SDK
- A code editor (such as VS Code or Android Studio)

### Installation

1. Clone the repository:

```
   git clone https://github.com/amer266030/q_flow_org
```

3. Get the dependencies:

    
```
   flutter pub get
```

4. Run the app:
    
```
   flutter run
```

### Future Enhancements

* Interview Preparation Resources: Offer additional resources for interview preparation and follow-up.

## Created By

**Amer Alyusuf**
- [Portfolio](https://amer266030.github.io)
- [Resume](https://amer266030.github.io/assets/pdf/Amer_CV.pdf)
- [LinkedIn](https://www.linkedin.com/in/amer-alyusuf)

**Yara Albouq**
- [Portfolio](https://bind.link/@yaraalbouq)
- [Resume](https://drive.google.com/file/d/1H0d1yBl9JCLyyc3Uwz3582EW3uy3U3HE/view?usp=drivesdk)
- [LinkedIn](https://www.linkedin.com/in/yaraalbouq)

**Abdullah Alshammari**
- [Portfolio](https://bind.link/@abdullah-al-shammari)
- [Resume](https://www.dropbox.com/scl/fi/usjo2vcuarjhqaulu226e/Abdullah_Alshammari_CV.pdf?rlkey=k297kmstimne5g017fdm9bdkd&st=jwe6dwpc&dl=0)
- [LinkedIn](https://www.linkedin.com/in/abumukhlef)