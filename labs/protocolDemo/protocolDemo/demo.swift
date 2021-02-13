//
//  demo.swift
//  protocolDemo
//
//  Created by Takayuki Yamaguchi on 2021-02-12.
//

import Foundation

protocol demoA {
  func methodA()
}

extension demoA{
  func methodA(){
      print("methodA")
  }
}
protocol demoB {
  func methodA()
}

extension demoB{
  func methodA(){
      print("methodA")
  }
}

struct demo: demoA {

}


