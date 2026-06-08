//
//  MapViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 04/06/2026.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController{
    
    static func build() -> UIViewController{
        let vc = MapViewController()
        let presenter = MapPresenter()
        
        vc.presenter = presenter
        presenter.view = vc
        
        return vc
    }
    
    var presenter: MapPresenterProtocol?
    
    // MARK: - Subviews
    private let map = MKMapView()
    private let segmentControl = UISegmentedControl(items: [ "Схема", "Гибрид", "Спутник"])
    private let location = CLLocationManager()
    
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        locationManagerDidChangeAuthorization(location)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        map.backgroundColor = .systemBackground
        map.delegate = self
        
        location.delegate = self
    }
    
    private func setupSubviews() {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.isRotateEnabled = false
        view.addSubview(map)
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(viewChanged), for: .valueChanged)
        view.addSubview(segmentControl)
    }
    
    //    MARK: - Conctraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            map.bottomAnchor.constraint(equalTo: segmentControl.topAnchor),
            
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    //    MARK: - Actions
    
    @objc private func viewChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            map.mapType = .standard
        case 1:
            map.mapType = .hybrid
        case 2:
            map.mapType = .satelliteFlyover
        default:
            break
        }
    }
    
    private func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

//    MARK: - Extensions

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotationPin = view.annotation as? AtmAnnotation else {return}
        let selectedAtm = annotationPin.atmData
        mapView.deselectAnnotation(annotationPin, animated: true)
        let infoVc = AtmInfoViewController(atm: selectedAtm)
        if let sheet = infoVc.sheetPresentationController{
            sheet.detents = [.medium()]
        }
        self.present(infoVc, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            map.showsUserLocation = true
            manager.startUpdatingLocation()
        case .denied, .restricted:
            map.showsUserLocation = false
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        let coordinate = loc.coordinate
        
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000)
        
        map.setRegion(region, animated: true)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Ошибка: \(error.localizedDescription)")
    }
}

extension MapViewController: MapViewProtocol{
    func showAtm(_ annotations: [AtmAnnotation]) {
        map.removeAnnotations(map.annotations)
        map.addAnnotations(annotations)
        if map.userLocation.location == nil {
            if let firstAtm = annotations.first{
                let region = MKCoordinateRegion(
                    center: firstAtm.coordinate,
                    latitudinalMeters: 1000,
                    longitudinalMeters: 1000)
                
                map.setRegion(region, animated: true)
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        self.alert(title: title, message: message)
    }
}
