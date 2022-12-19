//
//  Pattern.swift
//  DesignPatternsApp
//
//  Created by Yevhen Biiak on 19.12.2022.
//

import UIKit

struct Pattern {
    let image: UIImage
    let title: String
}

extension Pattern {
    
    static var creationalPatterns: [Pattern] {
        [Pattern(image: UIImage(named: "singleton")!, title: "Singleton"),
         Pattern(image: UIImage(named: "prototype")!, title: "Prototype")]
    }
    
    static var structuralPatterns: [Pattern] {
        [Pattern(image: UIImage(named: "adapter")!,   title: "Adapter"),
         Pattern(image: UIImage(named: "decorator")!, title: "Decorator"),
         Pattern(image: UIImage(named: "proxy")!,     title: "Proxy"),
         Pattern(image: UIImage(named: "facade")!,    title: "Facade"),
         Pattern(image: UIImage(named: "composite")!, title: "Composite") ]
    }
    
    static var behavioralPatterns: [Pattern] {
        [Pattern(image: UIImage(named: "command")!,  title: "Command"),
         Pattern(image: UIImage(named: "memento")!,  title: "Memento"),
         Pattern(image: UIImage(named: "observer")!, title: "Observer"),
         Pattern(image: UIImage(named: "template")!, title: "Template method"),
         Pattern(image: UIImage(named: "state")!,    title: "State"),
         Pattern(image: UIImage(named: "mediator")!, title: "Mediator"),
         Pattern(image: UIImage(named: "strategy")!, title: "Strategy"),
         Pattern(image: UIImage(named: "iterator")!, title: "Iterator"),
         Pattern(image: UIImage(named: "visitor")!,  title: "Visitor"),
         Pattern(image: UIImage(named: "chain")!,    title: "Responder chain") ]
    }
    
    static var allPatterns: [Pattern] {
        Pattern.creationalPatterns + Pattern.structuralPatterns + Pattern.behavioralPatterns
    }
}
