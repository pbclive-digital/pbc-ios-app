#  PBCLive - iOS Application
This is an iOS application build upon Swift/SwiftUI. This consumes REST-API to access data from
Google Firestore. PBC provides consumers to connect with Pittsburgh Buddhist Center.

### Technologies & Tools
* iOS -- v18.0
* Swift-Tool -- v6.2
* SwiftUI
* SPM

### New Development
In this application development, we are trying to follow trunk-base approach for branching. Therefore, if there is any new development or bug-fx or hot-fix available, our development branch will be `main` branch.

### Release Naming
Application is following a pattern to name the release versions & version-codes. Version name built with release year, major or feature drop version, minor or bug-fix.
Version-code built with release year, release month and even incremental code [2, 4, 6, 8, 10]
````
Version pattern : <release-year>.<major/feature-drop>.<minor/bug-fx>
Example              : 2024.1.0

Build Number pattern : <release-year><release-month><even-incremental-code>
Example              : 20240102
