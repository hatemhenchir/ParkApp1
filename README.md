# Parking App

This is a parking management app developed using Flutter and Firebase. The app has two roles: visitor and parking owner. Visitors can view the location of parking spaces on the map and check their availability. They can also reserve a parking spot and pay online using the Stripe API. Parking owners can add new parking spaces, manage available spots, and view reservations.

## Features

- Visitors can view available parking spaces on the map
- Visitors can reserve and pay for parking spots using the Stripe API
- Parking owners can add new parking spaces
- Parking owners can manage available spots and view reservations

## Getting Started

To get started with the app, you'll need to follow these steps:

1. Clone this repository to your local machine.
2. Run `flutter pub get` to install all dependencies.
3. Set up a Firebase project and add the necessary configuration files to the app. Follow the instructions [here](https://firebase.flutter.dev/docs/overview/#initializing-flutterfire) to get started.
4. Set up the Google Maps API and add the necessary configuration files to the app. Follow the instructions [here](https://pub.dev/packages/google_maps_flutter).
5. Set up the Stripe API and add the necessary configuration files to the app. Follow the instructions [here](https://stripe.com/docs/payments/accept-a-payment?platform=flutter).

## Usage

To use the app, follow these steps:

1. Open the app on your device or emulator.
2. If you're a visitor, you'll see a map with available parking spots marked. Tap on a spot to view more information and make a reservation.
3. If you're a parking owner, you'll see a dashboard with options to add new parking spaces, manage available spots, and view reservations.

