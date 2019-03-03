//
//  UIImageExtension.swift
//  Surya_Solution_test
//
//  Created by Mraj singh on 28/02/19.
//  Copyright © 2019 Mraj singh. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    
    //Downloading image from from link
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    print("Image not available")
                    return
            }
            DispatchQueue.main.async() {
                print(image)
                self.image = image
            }
            }.resume()
    }
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode)
    }
}
