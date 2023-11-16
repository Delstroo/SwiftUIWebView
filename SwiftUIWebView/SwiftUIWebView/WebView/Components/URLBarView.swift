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
        ZStack {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .frame(width: UIScreen.main.bounds.width, height: 60)
                .foregroundColor(.background)
                .clipShape(
                    .rect(
                        topLeadingRadius: 20,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 20
                    )
                )
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    .foregroundColor(.background)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 20
                        )
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundStyle(.secondary)
                            .frame(width: UIScreen.main.bounds.width - 16, height: 35)
                            .overlay {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.secondary)
                                        .padding(.leading, 6)
                                    
                                    Divider()
                                        .frame(width: 2, height: 30)
                                        .foregroundStyle(.primary.opacity(0.45))
                                    
                                    TextField("Search on Google", text: $viewModel.urlString, onCommit: viewModel.loadUrl)
                                        .textFieldStyle(.plain)
                                        .clipShape(RoundedRectangle(cornerRadius: 0))
                                        .autocorrectionDisabled()
                                        .autocapitalization(.none)
                                        .foregroundStyle(.primary)
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
                
                Divider()
                    .foregroundStyle(.secondary)
                
                ToolbarView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    URLBarView(viewModel: WebViewModel(), shouldLoadGoogle: .constant(true))
        .preferredColorScheme(.dark)
}
