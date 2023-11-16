//
//  UrlBarView.swift
//  SwiftUIWebView
//
//  Created by Delstun McCray on 11/16/23.
//

import SwiftUI

struct URLBarView: View {
    @ObservedObject var viewModel: WebViewModel
    @Binding var shouldLoadGoogle: Bool
    
    var body: some View {
        TextField("Search on Google", text: $viewModel.urlString, onCommit: viewModel.loadUrl)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onChange(of: shouldLoadGoogle) { shouldLoad in
                if shouldLoad {
                    viewModel.urlString = "https://www.google.com"
                    viewModel.loadUrl()
                    shouldLoadGoogle = false
                }
            }
    }
}

#Preview {
    URLBarView(viewModel: WebViewModel(), shouldLoadGoogle: .constant(true))
}
