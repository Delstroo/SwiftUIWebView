//
//  WebView.swift
//  SwiftUIWebView
//
//  Created by Delstun McCray on 11/15/23.
//

import SwiftUI
import WebKit

struct HomeView: View {
    @StateObject var viewModel = WebViewModel()
    @State private var shouldLoadGoogle = false
    
    var body: some View {
        VStack {
            TextField("Search on Google", text: $viewModel.urlString, onCommit: viewModel.loadUrl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            WebView(webView: $viewModel.webView)
                .onAppear {
                    shouldLoadGoogle = true
                }
                .onChange(of: shouldLoadGoogle) { shouldLoad in
                    if shouldLoad {
                        viewModel.urlString = "https://www.google.com"
                        viewModel.loadUrl()
                        shouldLoadGoogle = false
                    }
                }
        }
    }
}

struct WebView: UIViewRepresentable {
    @Binding var webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView = webView
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}


#Preview {
    HomeView()
}
