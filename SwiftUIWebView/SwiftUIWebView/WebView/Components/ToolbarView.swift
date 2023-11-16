//
//  ToolbarView.swift
//  SwiftUIWebView
//
//  Created by Delstun McCray on 11/16/23.
//

import SwiftUI

struct ToolbarView: View {
    @ObservedObject var viewModel: WebViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.goBack()
            }) {
                Image(systemName: "chevron.left")
            }
            .disabled(!viewModel.canGoBack)
            
            Button(action: {
                viewModel.goForward()
            }) {
                Image(systemName: "chevron.right")
            }
            .disabled(!viewModel.canGoForward)
            
            Spacer()
            
            Button(action: {
                // Handle settings button action
            }) {
                Image(systemName: "gearshape")
            }
            
            Button(action: {
                // Handle tabs button action
            }) {
                Image(systemName: "square.on.square")
            }
        }
        .padding()
        .foregroundColor(.blue) // Customize button colors as needed
    }
}

#Preview {
    ToolbarView(viewModel: WebViewModel())
}
