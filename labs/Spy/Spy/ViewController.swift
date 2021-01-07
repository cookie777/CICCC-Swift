//
//  ViewController.swift
//  Spy
//
//  Created by Takayuki Yamaguchi on 2021-01-04.
//

import UIKit

class ViewController: UIViewController {
    
    
    let sv = UIScrollView()
    let img = UIImageView(image: UIImage(named: "largeImage"))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white


        sv.addSubview(img)
        

        view.addSubview(sv)
        sv.matchParent()
//        img.matchParent()

        img.anchors(
            topAnchor: sv.contentLayoutGuide.topAnchor,
            leadingAnchor: sv.contentLayoutGuide.leadingAnchor,
            trailingAnchor: sv.contentLayoutGuide.trailingAnchor,
            bottomAnchor: sv.contentLayoutGuide.bottomAnchor,
            padding: .zero
        )
        
        sv.contentInset = .init(top: 100,
                                left: 100,
                                bottom: 100,
                                right: 100)
        
        sv.minimumZoomScale = 0
        sv.maximumZoomScale = 1
//        sv.zoomScale = 0.3
        sv.delegate = self
    }
    
    
    

}


extension ViewController: UIScrollViewDelegate{
    override func viewWillAppear(_ animated: Bool) {
//        updateZoomfor()
        sv.zoomScale = 0.3
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return img
    }

    func updateZoomfor() {
        let widthScale = view.bounds.size.width / img.bounds.width
        let heightScale = view.bounds.size.height / img.bounds.height

        let scale = min(widthScale, heightScale)
        sv.minimumZoomScale = 0
        sv.zoomScale = scale
    }
}

