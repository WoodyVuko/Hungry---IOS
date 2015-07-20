//
//  MapController.swift
//  Hungry
//
//  Created by Goran Vukovic on 19.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    // 1
    func mapView(mapView: MKMapView,
        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? MapAnnotations {
                let identifier = "pin"
                var view: MKPinAnnotationView
                if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                    as? MKPinAnnotationView { // 2
                        dequeuedView.annotation = annotation
                        view = dequeuedView
                } else {
                    // 3
                    view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view.canShowCallout = true
                    view.calloutOffset = CGPoint(x: -5, y: 5)
                    //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIButtonType
                    // Add detail button to right callout
                    let calloutButton = UIButton(type: UIButtonType.System)
                    view.rightCalloutAccessoryView = calloutButton
                }
                
                
                
                return view
            }
            return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! MapAnnotations
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
    
}
