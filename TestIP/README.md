# IPTest
## Overview
IPTest is an iOS app developed using SwiftUI, designed to provide users with information based on IP addresses. This application is optimized for iPhones running iOS 15 and above, focusing on portrait mode. It features a clean and user-friendly interface, asynchronous data fetching, error handling, map integration, and a seamless user experience.

## Table of Contents

#### User Interface (UI)
#### Data Retrieval
#### Error Handling
#### Location Services and Map Integration
#### User Experience (UX)

## User Interface (UI)
The app utilizes SwiftUI for building the user interface.
Designed with a clean and user-friendly interface optimized for iPhone devices in portrait mode. 

Includes a search bar at the top for users to input the IP address.
Three buttons:

"Get Info": Sends a request to https://ipinfo.io/{userInput}/geo.

"Find me": Sends a request to https://api.ipify.org/?format=json. After a response, sends a request to https://ipinfo.io/{userIP}/geo using the obtained IP.

"Reset": Clears all data.

Input field is validated with regex: "\b(?:\d{1,3}.){3}\d{1,3}\b".

Input validation:
Field is gray at the beginning.
Turns red if the field is not valid.
Turns green if the field is valid.

Displays search results in a scrollable list below the search.
## Data Retrieval
Connects to backend servers to retrieve user information based on the entered IP address.

Uses URLSession with async/await for asynchronous data fetching.

Displays loading indicators while fetching data.

Displays relevant user information such as country, region, location, etc.
## Error Handling
Implements error handling for cases such as invalid user IP, network errors, or server issues.
Displays appropriate error messages to guide users in case of any issues.
## Location Services and Map Integration
Creates a new screen for displaying a map.

Opens the map on a new screen upon selecting a user.

Puts a pin on the map with the location of the selected user.