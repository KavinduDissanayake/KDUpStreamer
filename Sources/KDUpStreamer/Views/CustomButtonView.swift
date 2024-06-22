//
//  CustomButtonView.swift
//  KDUpStreamer
//
//  Created by KavinduDissanayake on 2024-06-22.
//  All rights reserved for KDmobileApps.
//

import SwiftUI

public struct CustomButtonView: View {
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
