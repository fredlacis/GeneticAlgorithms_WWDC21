//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  A source file which is part of the auxiliary module named "BookCore".
//  Provides the implementation of the "always-on" live view.
//

import SwiftUI
import PlaygroundSupport

public class Page2_LiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
        
    let swiftUiView = UIHostingController(rootView: Page2_SwiftUIView())
    
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
