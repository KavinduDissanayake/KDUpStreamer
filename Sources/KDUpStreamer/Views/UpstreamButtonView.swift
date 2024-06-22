import SwiftUI

public struct UpstreamButtonView<CustomButton: View>: View {
    @ObservedObject private var upstream: UpstreamButton.Upstream
    private let customButtonView: CustomButton?
    private let displaySections: DisplaySections
    
    public enum DisplaySections {
        case all
        case whatsNewOnly
        case descriptionOnly
        case onlyButton
    }
    
    // Initializer with custom button view
    public init(upstream: UpstreamButton.Upstream, customButtonView: CustomButton? = nil, displaySections: DisplaySections = .onlyButton) {
        self.upstream = upstream
        self.customButtonView = customButtonView
        self.displaySections = displaySections
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            if displaySections != .onlyButton {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 30) {
                        if displaySections == .all || displaySections == .whatsNewOnly {
                            component(header: "What's New?", text: upstream.data.releaseNotes)
                        }
                        if displaySections == .all || displaySections == .descriptionOnly {
                            component(header: "Description", text: upstream.data.description)
                        }
                    }
                }
                
                Spacer()
            }
            
            if let customButtonView = customButtonView {
                customButtonView
            } else {
                defaultButton
            }
        }
    }
    
    private var defaultButton: some View {
        Button {
            if let url = URL(string: upstream.data.trackViewUrl) {
                UIApplication.shared.open(url)
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 50)
                    .foregroundColor(.blue)
                
                Text("Update Now")
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
    
    private func component(header: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(header)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.primary)
            
            Text(text)
                .font(.body)
                .padding(12)
                .foregroundColor(.primary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
        }
    }
}
