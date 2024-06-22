//
//  UpstreamButtonView.swift
//  KDUpStreamer
//
//  Created by KavinduDissanayake on 2024-06-22.
//  All rights reserved for KDmobileApps.
//

import SwiftUI

public struct UpstreamButtonView<CustomButton: View>: View {
    @ObservedObject private var upstream: UpstreamButton.Upstream
    private let customButtonView: CustomButton?
    
    public init(upstream: UpstreamButton.Upstream, customButtonView: CustomButton? = nil) {
        self.upstream = upstream
        self.customButtonView = customButtonView
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    component(header: "What's New?", text: upstream.data.releaseNotes)
                    
                    component(header: "Description", text: upstream.data.description)
                }
            }

            Spacer()
            
            if let customButtonView = customButtonView {
                customButtonView
            } else {
                defaultButton
            }
        }
        .padding(24)
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
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
                .foregroundColor(.white)
            
            Text(text)
                .font(.body)
                .padding(12)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}
