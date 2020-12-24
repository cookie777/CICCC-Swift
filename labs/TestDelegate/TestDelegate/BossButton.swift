//
//  BossButton.swift
//  TestDelegate
//
//  Created by Takayuki Yamaguchi on 2020-12-23.
//

import UIKit

class BossButton: UIButton {

    weak var delegate: BossButtonDelegate?
    
    
    init() {
        super.init(frame: .init(x: 100, y: 100, width: 100, height: 100))
        self.setTitle("button", for: .normal)
        self.backgroundColor = .cyan
        self.addTarget(self, action: #selector(whenTheButtonIsPressed), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func whenTheButtonIsPressed(){
        if let delegate = delegate {
            delegate.additonalActionIfTheButtonPressed()
        }else{
            print("no delegate!, the boss work by himself...🤢")
        }
    }
    
}
