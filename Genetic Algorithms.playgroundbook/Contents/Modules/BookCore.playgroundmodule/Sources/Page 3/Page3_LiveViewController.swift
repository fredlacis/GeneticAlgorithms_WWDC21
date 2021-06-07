//
//  Page3_LiveViewController.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 16/04/21.
//

import SwiftUI
import PlaygroundSupport

public class Page3_LiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    var swiftUiView: UIHostingController<Page3_SwiftUIView>// = UIHostingController(rootView: Page3_SwiftUIView())
        
//    var popSize = 500
//    var genNum = 50
//    var execSpeed = 0.1
    public init(view: Page3_SwiftUIView) {
        self.swiftUiView = UIHostingController(rootView: view)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
