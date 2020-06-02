## Time Sheet
Time Sheet is an iOS app built to do my work time sheet on.  The app allows you add jobs one at a time to a list, save each the job, and then export the job list in csv format via email.  You can then clear the list at the end of the week and start a fresh time sheet.

## Motivation
This app was built to basically solve the problem of me doing a paper time sheet at work.  I didn't want to keep filling out my time sheet on paper, so i built an app to do it on my phone.  So no more paper, and it makes my time sheet more accurate as i fill it in as soon as ive finished a job. 

## Build status
This is the first project of any kind I've actually finished that works! (YAY! :) ).  It's also is the first iOS app ive built, it is by no means a polished app, but it's fully tested and operational as it stands.  I have started to use it at work as of 1/06/2020.  

## Code style
As It's my first app I haven't followed any particular coding style, I have tried to documewnt my code well, and try to code to a consistent style.  I have tried to implement MVC on the project which is only half done, but i will be tidying it up further over the coming weeks.

## Screenshots
![](TimeSheetAppPreview.gif)

## Tech/framework used

<b>Built with</b>
Xcode Version 11.5 (11E608c)

## Features
Features of the App:

- Add jobs individually.
- Hours for each day are shown on the main page.
- Jobs are then added to a list in date order.
- App data is saved after each job is added.
- Can export all app data in CSV format via email
- Add email address to app and it will save to user defaults even when app is closed.
- Cleat Data button in settings will clear all time sheet data.

Not currently working:

- Days select button in settings dosent work.  Eventually you will be able to select which days you want to show to the main/days view controller.

## Installation
Must have Xcode Version 11.5 installed
App only works on iOS 13.4 and later.

## Tests
No tests currently.

## How to use?

- Open the App and it will load onto the main page.
- Your daily logged hours will show next to each day.
- Select the plus symbol by each day to add a job.
- Select a Job code via UI Picker.
- Job description box is the automatically populated with the Job Description.
- Add machine number (Y Number)
- Add hours to Hours box.  Hours must be a double e.g. 1.0, 1.2, 1.5, 2.5 (must be a decimal number).
- Click save to add the job to the current jobs list.
- Jobs are then saved in a list in date order.  Each job on a new line.
- Add email address to app via settings and it will save to user defaults even when app is closed.
- Time sheet data will save to user defaults even when app is closed.
- App data can be exported in CSV format via email by clicking the export button on main page.
- Clear Data button in settings will clear all time sheet data, ready to start a new week.

## Issues

As far as I am aware their aren't any known major issues.  I know the UI is a bit of a mess which I intend to sort over the coming months in a second version.  I need to add a notes text field to the addEditTasksViewController, just for extra information

## Contribute

Any contributions, advice of suggestions welcome.

## Credits
Credits: Matt Hollyhead

## License
A short snippet describing the license (MIT, Apache etc)

MIT © [Matt Hollyhead]()
