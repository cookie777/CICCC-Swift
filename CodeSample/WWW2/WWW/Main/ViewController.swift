//
//  ViewController.swift
//  WWW
//
//  Created by Derrick Park on 2021-01-13.
//
//  Code Formatting : CMD + a (select all), Ctrl + i (format)

import UIKit

class ViewController: UIViewController {
  
  let imageView: UIImageView = {
    let iv = UIImageView(image: UIImage(systemName: "photo.on.rectangle"))
    iv.contentMode = .scaleAspectFit
    iv.widthAnchor.constraint(equalTo: iv.heightAnchor, multiplier: 4/3).isActive = true
    return iv
  }()
  
  let descriptionLabel: UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 0
    lb.text = ""
    return lb
  }()
  
  let copyrightLabel: UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 0
    lb.text = ""
    return lb
  }()
  
  let spinner = UIActivityIndicatorView(style: .large)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupUI()
    spinner.startAnimating()
    view.addSubview(spinner)
    spinner.centerXYin(view)
    // multithreading (concurrency)
    PhotoInfoAPI.shared.fetchPhotoInfo { (result) in
      // ------------- main queue ---------------
      DispatchQueue.main.async {
        switch result {
        case .success(let photoInfo):
          self.updateUI(with: photoInfo)
        case .failure(let error):
          self.updateUI(with: error)
        }
      }
      // -----------------------------------------
    }
  }
  
  fileprivate func setupUI() {
    title = ""
    let scrollView = UIScrollView()
    view.addSubview(scrollView)
    scrollView.matchParent(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    
    let vStackView = VerticalStackView(arrangedSubviews: [
      imageView, descriptionLabel, copyrightLabel
    ], spacing: 8, alignment: .center, distribution: .fill)
    scrollView.addSubview(vStackView)
    vStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
    
    let contentLayout = scrollView.contentLayoutGuide
    vStackView.anchors(topAnchor: contentLayout.topAnchor, leadingAnchor: contentLayout.leadingAnchor, trailingAnchor: contentLayout.trailingAnchor, bottomAnchor: contentLayout.bottomAnchor)
  }
  
  fileprivate func updateUI(with photoInfo: PhotoInfo) {
    // using photoInfo.url, fetch the image
    PhotoInfoAPI.shared.fetchImage(from: photoInfo.url) { (result) in
      // ------------- main queue ---------------
      DispatchQueue.main.async {
        switch result {
        case .success(let image):
          self.title = photoInfo.title
          self.imageView.image = image
          self.descriptionLabel.text = photoInfo.description
          self.copyrightLabel.text = photoInfo.copyright
        case .failure(let error):
          self.updateUI(with: error)
        }
        self.spinner.stopAnimating()
      }
      // -----------------------------------------
    }
  }
  
  fileprivate func updateUI(with error: Error) {
    title = "Error Fetching Photo"
    imageView.image = UIImage(systemName: "exclamationmark.octagon")
    descriptionLabel.text = error.localizedDescription
    copyrightLabel.text = ""
  }
}

