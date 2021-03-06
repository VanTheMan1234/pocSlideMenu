//
//  ContainerViewController.swift
//  pocSlideMenu
//
//  Created by Vanoshan  Ramdhani on 2020/04/01.
//  Copyright © 2020 Vanoshan  Ramdhani. All rights reserved.
//

import Foundation
import UIKit

class ContainerViewController: UIViewController {
    enum SlideOutState{
        case bothCollapsed
        case leftPanelExpanded
    }
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    
    var currentState: SlideOutState = .bothCollapsed{
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterView(shouldShowShadow)
        }
    }
    var leftViewController: SidePanelViewController?
    
    let centerPanelExpandedOffset: CGFloat = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
    }
    
    func configureController(){
         let centerViewController = CenterViewController()
         centerViewController.delegate = self
         centerNavigationController = UINavigationController(rootViewController: centerViewController)
        
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        centerNavigationController.didMove(toParent: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func showShadowForCenterView(_ shouldShowShadow: Bool){
        if shouldShowShadow{
            centerNavigationController.view.layer.shadowOpacity = 0.8
        }else{
             centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
}

// MARK: CenterViewController delegate

extension ContainerViewController: CenterViewControllerDelegate {
  func toggleLeftPanel() {
    let notAlreadyExpanded = (currentState != .leftPanelExpanded)

    if notAlreadyExpanded {
      addLeftPanelViewController()
    }

    animateLeftPanel(shouldExpand: notAlreadyExpanded)
  }
  
  func addLeftPanelViewController() {
    guard leftViewController == nil else { return }
//
//    if let vc = UIStoryboard.leftViewController() {
//      vc.animals = Animal.allCats()
//      addChildSidePanelController(vc)
//      leftViewController = vc
//    }
  }
  
  func animateLeftPanel(shouldExpand: Bool) {
    if shouldExpand {
      currentState = .leftPanelExpanded
      animateCenterPanelXPosition(
        targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { _ in
        self.currentState = .bothCollapsed
        self.leftViewController?.view.removeFromSuperview()
        self.leftViewController = nil
      }
    }
  }

  func collapseSidePanel() {
    switch currentState {
        
    case .leftPanelExpanded:
      toggleLeftPanel()
    default:
      break
    }
  }
  
  func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0,
                   options: .curveEaseInOut, animations: {
                     self.centerNavigationController.view.frame.origin.x = targetPosition
    }, completion: completion)
  }
  
  func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
    sidePanelController.delegate = centerViewController as! sidePanelViewControllerDelegate
    view.insertSubview(sidePanelController.view, at: 0)
    
    addChild(sidePanelController)
    sidePanelController.didMove(toParent: self)
  }
  
  func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
    if shouldShowShadow {
      centerNavigationController.view.layer.shadowOpacity = 0.8
    } else {
      centerNavigationController.view.layer.shadowOpacity = 0.0
    }
  }
}
extension ContainerViewController: UIGestureRecognizerDelegate {
  @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
    let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)

    switch recognizer.state {
    case .began:
      if currentState == .bothCollapsed {
        if gestureIsDraggingFromLeftToRight {
          addLeftPanelViewController()
        }
        showShadowForCenterView(true)
      }
      
    case .changed:
      if let rview = recognizer.view {
        rview.center.x = rview.center.x + recognizer.translation(in: view).x
        recognizer.setTranslation(CGPoint.zero, in: view)
      }
      
    case .ended:
      if let _ = leftViewController,
        let rview = recognizer.view {
        // animate the side panel open or closed based on whether the view
        // has moved more or less than halfway
        let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
        animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
      }
      
    default:
      break
    }
  }
}
