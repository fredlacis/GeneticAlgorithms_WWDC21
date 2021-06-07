//
//  Page3_WaitingLiveViewController.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 16/04/21.
//

import SwiftUI
import PlaygroundSupport

public class Page3_WaitingLiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
        
    let swiftUiView = UIHostingController(rootView: Page3_WaitingSwiftUIView())
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        Config.setUpFonts()
        
        addChild(swiftUiView)
        self.view.addSubview(swiftUiView.view)
        setUpConstraints()
    }
    
    fileprivate func setUpConstraints() {
        swiftUiView.view.backgroundColor = UIColor(hex: "#1F3944")!
        swiftUiView.view.translatesAutoresizingMaskIntoConstraints = false
        swiftUiView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        swiftUiView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        swiftUiView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        swiftUiView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}
