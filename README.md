# Photo Gallery

A simple pics gallery Flutter project.

## Getting Started

Runnig with Visual Studio Code and f.e. Android emilator: Pixel 2 API 30 2. 
Also can be runned in a web browser.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/KirillNikitin/Photo-Gallery.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Run Android Studio and some Android emulator (Used and tested on Emulator Phone: Pixel 2 API 30 2).

**Step 4:**

Run the project (better with '--no-sound-null-safety'):

```
flutter run --no-sound-null-safety
```

- The app can be used by iPhone and Android users
- Provides access to images from https://placekitten.com/ (16 images total)
- Images can be viewed one at a time, with simple UI to get another image (Using package photo_view https://pub.dev/packages/photo_view )
- Users can delete particular cat images by click the "Not cute enough" button, so they do not show up again 
- Users can easily undo marking cat images as "not cute enough" for up to 5 seconds after making the action (click the same button. It is being displayed as 'Cancel' button during 5 seconds)
- Users can restore whole gallery by clicking 'Reset'. It restores all the pics of cats removed as "not cute enough" previously.

