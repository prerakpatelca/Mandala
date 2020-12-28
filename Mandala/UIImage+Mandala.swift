//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Prerak Patel on 2020-12-05.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {
    // convenience Initializer
    convenience init(resource: ImageResource) {
        self.init(named: resource.rawValue)!
    }
}
