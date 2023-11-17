//
//  TabsModel.swift
//  SwiftUIWebView
//
//  Created by Delstun McCray on 11/16/23.
//

import Foundation
import SwiftUI

struct Tab: Identifiable {
    let id = UUID()
    let title: String
    let url: String
    let timeStamp: Date
    var screenshotImage: Image?
}
