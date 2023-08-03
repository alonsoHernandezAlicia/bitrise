//
//  UIImageViewExtension.swift
//  iOSAvanzadoOpenBank

//  Created by Ismael Sabri Pérez on 26/7/23.
//

import UIKit


// Estamos dentro del image view (dentro del contenedor de la imagen)
extension UIImageView {
    
    
    func setImage(url: URL?) {
        guard let unwrappedURL = url else { return }
        downloadWithUrlSession(url: unwrappedURL) { [weak self] downloadedImage in
            // Asignamos a la imagen del contenedor en el que estamos (UIImage view) la imagen descargada
            DispatchQueue.main.async {
                self?.image = downloadedImage
            }
        }
    }
    
    private func downloadWithUrlSession(url: URL, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
                completion(image)
        }.resume()

    }
    
}


