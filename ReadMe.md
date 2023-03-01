# Fstructure

---

##### This shell script is designed to help you set up your Flutter project structure quickly and easily.

## Installation

To use this script, follow these steps:
1- Clone this repository to your local machine.
2- Source the script by running the following command in your terminal:

```sh
source fstructure.sh
```

## Usage

To use the script, use the following command in your terminal:

```txt
Usage: fs [command] [arguments]

Commands:
  -i              Initialize the project
  -f [feature]    Create a new feature
  -fd [feature] [data-source] Create a new data source in a feature
  -fr [feature] [repository] Create a new repository in a feature
  -fm [feature] [model] Create a new model in a feature
  -fp [feature] [provider] Create a new provider in a feature
  -fs [feature] [screen] Create a new screen in a feature
  -fsw [feature] [screen] [widget] Create a new widget in a screen of a feature
  -sf             Show available features
  -gw [widget]    Create a new general widget
  -ns [screen]    Create a new normal screen

Examples:
  fs -i                     # Initializes the project
  fs -f authentication      # Creates a new feature named 'authentication'
  fs -fd authentication api # Creates a new data source named 'api' in the 'authentication' feature
  fs -sf                    # Lists all available features
  fs -gw button             # Creates a new general widget named 'button'
```

```txt
Usage: fsm -f FEATURE COMMANDS [OPTIONS]

A script to automate the creation of common files and directories in a Flutter project.

Commands:
  -ds NAMES    create a new data sources with the specified NAMES in the given FEATURE
  -r NAMES     create a new repositories with the specified NAMES in the given FEATURE
  -m NAMES    create a new models with the specified NAME in the given FEATURE
  -p NAMES     create a new providers with the specified NAMES in the given FEATURE
  -s NAMES     create a new screens with the specified NAMES in the given FEATURE

Options:
  -f FEATURE  specify the FEATURE to create the files/directories in

Examples:
  fsm -f auth -ds users login -m user      create a new data sources called 'users' and 'login' and new model called 'user' in the 'auth' feature
  fsm -f home -r products      create a new repository called 'products' in the 'home' feature
  fsm -f profile -m user       create a new model called 'user' in the 'profile' feature
```

## Purpose

I created this script to help me set up my Flutter project structure faster and more easily. It automates the process of creating directories and files and saves me a lot of time.

## Contributing

If you have any suggestions or improvements for this script, feel free to fork this repository and submit a pull request. I welcome any feedback that can help improve this script.
