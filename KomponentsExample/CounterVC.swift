//
//  CounterVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import Komponents

class CounterVC: UIViewController, Component {
    
    var reactEngine: KomponentsEngine?

    var state = 0
    
    override func loadView() { loadComponent() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Counter"
    }
    
    func render() -> Tree {
        return
            View([
                VerticalStack(layout: .center, [
                    Label("Counter : \(state)"),
                    Button("Tap me",
                           tap: { [weak self] in //be careful of the strong Ref ! (document this)
                            self?.updateState { $0 += 1 }
                        }, props: {
                            $0.text = "Lool"
                            $0.setTitleColor(.red, for:.normal)
                    })
                ])
            ])
    }
}
