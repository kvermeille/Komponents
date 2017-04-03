//
//  DefaultNodes.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation
import UIKit

struct View: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UIView) -> ())?
    var styleBlock: ((UIView) -> ())?
    var children = [Node]()
    
    init(style:((UIView)->())? = nil, layout:((UIView)->())? = nil , _ children:[Node]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}

struct Text: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UILabel) -> ())?
    var styleBlock: ((UILabel) -> ())?
    var children = [Node]()
    var wording = ""
    
    init(_ wording: String = "", style:((UILabel)->())? = nil, layout:((UILabel)->())? = nil , children:[Node] = [Node]() ) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
        self.wording = wording
    }
}

class Field: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UITextField) -> ())?
    var styleBlock: ((UITextField) -> ())?
    var children = [Node]()
    var placeholder = ""
    var wording = ""
    var isFocused = true
    
    var textChangedCallback:((String) -> Void)?
    
    
    
    var registerTextChanged: ((UITextField) -> ())?
    
    init(_ placeholder: String = "", wording:String = "", textChanged: ((String) -> Void)? = nil, style:((UITextField)->())? = nil, layout:((UITextField)->())? = nil , children:[Node] = [Node]() ) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
        self.placeholder = placeholder
        self.wording = wording
        
        
        textChangedCallback = textChanged
        
        
        registerTextChanged = { tf in
            tf.addTarget(self, action: #selector(self.textDidChange(tf:)), for: .editingChanged)
        }
    }
    
    @objc func textDidChange(tf:UITextField) {
        if let t = tf.text {
            wording = t
            textChangedCallback?(t)
        }
    }
}


struct VerticalStack: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UIStackView) -> ())?
    var styleBlock: ((UIStackView) -> ())?
    var children = [Node]()
    
    init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , children:[Node] = [Node]() ) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
    
    init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , _ children: [Node]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}

struct HorizontalStack: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UIStackView) -> ())?
    var styleBlock: ((UIStackView) -> ())?
    var children = [Node]()
    
    init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , children:[Node] = [Node]() ) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
    
    init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , _ children: [Node]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}


class Button: Node {
    
    var tapCallback:(() -> Void)?
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UIButton) -> ())?
    var styleBlock: ((UIButton) -> ())?
    var children = [Node]()
    var wording = ""
    var image:UIImage?
    
    var registerTap: ((UIButton) -> ())?
    
    
    init(_ wording: String = "", image: UIImage? = nil, tap: (() -> Void)? = nil, style:((UIButton)->())? = nil, layout:((UIButton)->())? = nil) {
        self.image = image
        self.wording = wording
        self.layoutBlock = layout
        self.styleBlock = style
        
        
        tapCallback = tap
        registerTap = { b in
            b.addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
        }
    }
    
    @objc func didTap() {
        tapCallback?()
    }
}