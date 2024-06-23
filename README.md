# KDUpStreamer

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

A very simple and elegant update notifier for iOS apps using SwiftUI. `KDUpStreamer` helps you to display update information and guide users to the latest version of your app on the App Store.

## Requirements
* iOS 15+
* Xcode 12+
* Swift 5.5+

## Installation

### Swift Package Manager (SPM)

Add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/KavinduDissanayake/KDUpStreamer", from: "1.0.0")
]
```

Alternatively, you can add the package through Xcode:
1. Open your project in Xcode.
2. Go to `File` > `Swift Packages` > `Add Package Dependency...`
3. Enter the URL `https://github.com/KavinduDissanayake/KDUpStreamer` and follow the instructions.

## Usage

### Basic Usage with Default Button

To use `KDUpStreamer` with the default button, follow these steps:

1. **Import `KDUpStreamer`**:
    ```swift
    import SwiftUI
    import KDUpStreamer
    ```

2. **Create a StateObject for Upstream**:
    ```swift
    @StateObject private var upstream = UpstreamButton.Upstream(appId: "YOUR_APP_ID")
    ```

3. **Use `UpstreamButtonView` in your view**:
    ```swift
    var body: some View {
        NavigationView {
            VStack {
                Text("Using Default Button")
                    .font(.title)
                    .padding()

                // Using default button
                UpstreamButtonView(upstream: upstream, displaySections: .all)
                    .padding(.bottom)
            }
            .navigationTitle("Upstream Demo")
        }
    }
    ```

### Custom Button Usage

To customize the button used in `KDUpStreamer`, follow these steps:

1. **Define a Custom Button View**:
    ```swift
    struct CustomButtonView: View {
        private let action: () -> Void
        private let title: String
        
        public init(title: String, action: @escaping () -> Void) {
            self.title = title
            self.action = action
        }
        
        public var body: some View {
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 50)
                        .foregroundColor(.green)
                    
                    Text(title)
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
    }
    ```

2. **Use `UpstreamButtonView` with the Custom Button**:
    ```swift
    var body: some View {
        NavigationView {
            VStack {
                Text("Using Custom Button")
                    .font(.title)
                    .padding()
                
                // Using custom button
                UpstreamButtonView(
                    upstream: upstream,
                    customButtonView: CustomButtonView(title: "Custom Update") {
                        if let url = URL(string: upstream.data.trackViewUrl) {
                            UIApplication.shared.open(url)
                        }
                    },
                    displaySections: .all
                )
            }
            .navigationTitle("Upstream Demo")
        }
    }
    ```

### Showing Specific Sections

To display specific sections such as "What's New" or "Description" only, use the `displaySections` parameter:

```swift
// Show only "What's New"
UpstreamButtonView(upstream: upstream, displaySections: .whatsNewOnly)

// Show only "Description"
UpstreamButtonView(upstream: upstream, displaySections: .descriptionOnly)
```

## Example

Here is a full example using both default and custom buttons, and navigating to separate views to display "What's New", "Description", and version information:

```swift
import SwiftUI
import KDUpStreamer

struct ContentView: View {
    @StateObject private var upstream = UpstreamButton.Upstream(appId: "YOUR_APP_ID")
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: WhatsNewView(releaseNotes: upstream.data.releaseNotes)) {
                    Text("View What's New")
                        .font(.title2)
                        .padding()
                }
                
                NavigationLink(destination: DescriptionView(description: upstream.data.description)) {
                    Text("View Description")
                        .font(.title2)
                        .padding()
                }
                
                NavigationLink(destination: VersionInfoView(version: upstream.data.version, buildNumber: UIApplication.appVersion)) {
                    Text("View Version Info")
                        .font(.title2)
                        .padding()
                }
                
                Spacer().frame(height: 50)
                
                Text("Using Default Button")
                    .font(.title)
                    .padding()
                
                // Using default button
                UpstreamButtonView(upstream: upstream, displaySections: .all)
                    .padding(.bottom)
                
                Text("Using Custom Button")
                    .font(.title)
                    .padding()
                
                // Using custom button
                UpstreamButtonView(
                    upstream: upstream,
                    customButtonView: CustomButtonView(title: "Custom Update") {
                        if let url = URL(string: upstream.data.trackViewUrl) {
                            UIApplication.shared.open(url)
                        }
                    },
                    displaySections: .all
                )
            }
            .padding()
            .onAppear {
                print("What's New: \(upstream.data.releaseNotes)")
                print("Description: \(upstream.data.description)")
                print("New App Version: \(upstream.data.version)")
                print("Build Number: \(UIApplication.appVersion)")
                print("Is Update Available: \(upstream.isUpdateAvailable)")

            }
            .navigationTitle("Upstream Demo")
        }
    }
}

struct CustomButtonView: View {
    private let action: () -> Void
    private let title: String
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 50)
                    .foregroundColor(.green)
                
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
#### Cover image
<img align="center" src="https://github.com/KavinduDissanayake/KDUpStreamer/blob/main/Sources/KDUpStreamer/cover_image.png"> 

## License

Kavindu Dissanayake
