//
//  ViewController.swift
//  MapBank
//
//  Created by Александр Молчан on 12.01.23.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var locationManager = CLLocationManager()
    private var markers: [GMSMarker] = []
    
    private var data = [AtmInfo]() {
        didSet {
            drawAtmFilials()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateMapView()
        getData()
    }
    
    private func configurateMapView() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        self.view.backgroundColor = .red
    }
    
    private func getData() {
        activityIndicator.startAnimating()
        FilialProvider().getAtmInfo { [weak self] result in
            guard let self else { return }
            self.data = result
            self.activityIndicator.stopAnimating()
        } failure: { errorString in
            print(errorString)
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func drawAtmFilials() {
        data.forEach { atm in
            guard let latitude = Double(atm.latitude),
                  let longitude = Double(atm.longitude) else { return }
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            if atm.atmError == "да" {
                marker.icon = GMSMarker.markerImage(with: UIColor.green)
            } else {
                marker.icon = GMSMarker.markerImage(with: UIColor.red)
            }
            marker.map = mapView
            marker.userData = atm
//            markers.append(marker)
        }
    }
    
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        guard let index = markers.firstIndex(of: marker) else { return true }
//        let filial = data[index]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let filialInfoVc = storyboard.instantiateViewController(withIdentifier: String(describing: FilialInfoController.self)) as? FilialInfoController else { return false }
        filialInfoVc.modalPresentationStyle = .pageSheet
        guard let sheet = filialInfoVc.sheetPresentationController else { return false }
        sheet.detents = [.medium()]
        
        guard let filial = marker.userData as? AtmInfo else { return false }
        filialInfoVc.filial = filial
        
        navigationController?.present(filialInfoVc, animated: true)
        return true
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locationManager.location?.coordinate else {
            locationManager.stopUpdatingLocation()
            return
        }
        cameraMove(to: location)
        locationManager.stopUpdatingLocation()
    }
    
    func cameraMove(to location: CLLocationCoordinate2D) {
            mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom: 8)
    }
    
}
