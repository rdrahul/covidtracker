# GoCorona : The Covid Tracker
<img src="./assets/app.gif" 
alt="IMAGE ALT TEXT HERE" width="240" height="480" border="10" />

A Coronavirus Tracker Application Written in flutter and Python(Flask).

## Introduction
This is a fairly simple project i started for learing. It tells statistics about the COVID-19 Cases details country wise. 

## Installation
Clone the repo and run 
```sh 
flutter get
``` 
to get the exteranal dependencies.

For backend `cd` into the `backend` folder and install python virtual environemnt
```sh 
virtualenv flaskenv
```
```sh
pip install -r requirements.txt
```

## How to run

Launch the flutter app with 
```sh 
flutter run
```

Run on emulator or change the URL in config to IP address for api access.

Launch the backend with
```sh 
python app.py
```
