//
//  S.swift
//  fintech
//
//  Created by Diogo on 31/07/2025.
//

import Foundation
import UIKit

class SplashViewController : UIViewController{
    
   
    let contentView: SplashView;
    
    init(contentView: SplashView){
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
