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
        ZStack {
            
            RoundedRectangle(cornerRadius: 0)
                .frame(width: UIScreen.main.bounds.width, height: 45)
                .foregroundStyle(Color.background)
            
            HStack {
                Button(action: {
                    viewModel.goBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(viewModel.canGoBack ? .primary : .secondary)
                }
                .disabled(!viewModel.canGoBack)
                
                Spacer()

                Button(action: {
                    viewModel.goForward()
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(viewModel.canGoForward ? .primary : .secondary)
                }
                .disabled(!viewModel.canGoForward)
                
                Spacer()

                Button(action: {
                    // Handle settings button action
                }) {
                    Image(systemName: "gearshape")
                        .foregroundStyle(Color(uiColor: .label))
                }
                
                Spacer()
                
                Button(action: {
                    // Handle tabs button action
                }) {
                    Image(systemName: "square.on.square")
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
            .padding()
        }
    }
}

#Preview {
    ToolbarView(viewModel: WebViewModel())
        .preferredColorScheme(.dark)
}
