//
//  CenterViewController.swift
//  pocSlideMenu
//
//  Created by Vanoshan  Ramdhani on 2020/04/01.
//  Copyright © 2020 Vanoshan  Ramdhani. All rights reserved.
//

import Foundation
import UIKit

class CenterViewController: UIViewController {
    
    var delegate: CenterViewControllerDelegate?
      
      // MARK: -  Init
      
      override func viewDidLoad() {
          super.viewDidLoad()
          configureNavigationBar()
          view.backgroundColor = .white
      }
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "SideMenu"
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    @objc func handleMenuToggle(){
        delegate?.toggleLeftPanel()
        print("toggle")
        
    }
    //MARK: -Selectors
    
    @objc func buttonAction(sender: UIButton!) {

        delegate?.toggleLeftPanel()
    }
}

protocol CenterViewControllerDelegate {
    func toggleLeftPanel()
    func collapseSidePanel()
}
