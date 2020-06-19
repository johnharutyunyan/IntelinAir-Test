//
//  FlightMapViewController.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/14/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import UIKit
import Mapbox

class FlightMapViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MGLMapView!
    
    
    // MARK: - Members
    internal var viewModel: FlightMapViewModel!
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure a map view centered on Washington, D.C.
        mapView.styleURL = MGLStyle.lightStyleURL
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: -87.7122189, longitude: 40.3430229), zoomLevel: 2, animated: false)

        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    // MARK: - Private functions
    private func drawShapeCollection(data: Data) throws {
        
        guard let style = self.mapView.style else { return }

        // Use [MGLShape shapeWithData:encoding:error:] to create a MGLShapeCollectionFeature from GeoJSON data.
        guard let feature = try? MGLShape(data: data,
                                          encoding: String.Encoding.utf8.rawValue) as? MGLShapeCollectionFeature else {
            fatalError("Could not cast to specified MGLShapeCollectionFeature")
        }
        
        let source = MGLShapeSource(identifier: "transit", shape: feature, options: nil)
        style.addSource(source)

        if let coordinates = viewModel.coordinates {
            
            var locationCoordinates = [CLLocationCoordinate2D]()
            
            locationCoordinates = coordinates.map { coordinate -> CLLocationCoordinate2D in
                return CLLocationCoordinate2D(latitude: coordinate.first ?? 0, longitude: coordinate.last ?? 0)
            }
            
            let polygon = MGLPolygon(coordinates: &locationCoordinates, count: UInt(locationCoordinates.count))
            let multyPoligon = MGLMultiPolygon(polygons: [polygon])
            
            self.mapView.addAnnotation(multyPoligon)
        }

        // Create station style layer.
        let circleLayer = MGLCircleStyleLayer(identifier: "stations", source: source)

        // Use a predicate to filter out non-points.
        circleLayer.predicate = NSPredicate(format: "TYPE = 'Station'")
        circleLayer.circleColor = NSExpression(forConstantValue: UIColor.red)
        circleLayer.circleRadius = NSExpression(forConstantValue: 6)
        circleLayer.circleStrokeWidth = NSExpression(forConstantValue: 2)
        circleLayer.circleStrokeColor = NSExpression(forConstantValue: UIColor.black)

        // Create line style layer.
        let lineLayer = MGLLineStyleLayer(identifier: "rail-line", source: source)

        // Use a predicate to filter out the stations.
        lineLayer.lineColor = NSExpression(forConstantValue: UIColor.red)
        lineLayer.lineWidth = NSExpression(forConstantValue: 2)
        
        style.addLayer(lineLayer)
        style.addLayer(circleLayer)
    }
}


// MARK: - MGLMapViewDelegate
extension FlightMapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        if let tileSetPath = viewModel.tileSetPath {
            let source = MGLRasterTileSource(identifier: "Tileset",
                                             tileURLTemplates: [tileSetPath],
                                             options: [.minimumZoomLevel: 2,
                                                       .maximumZoomLevel: 21,
                                                       .tileSize: 256
            ])

            style.addSource(source)

            // Create a raster layer from the MGLRasterTileSource.
            let rasterLayer = MGLRasterStyleLayer(identifier: "Tileset", source: source)
            style.addLayer(rasterLayer)
        }
        
        
        // Draw Geometry
        DispatchQueue.main.async {
            if let data = self.viewModel.geometry?.data(using: .utf8) {
                try? self.drawShapeCollection(data: data)
            }
        }
    }
}
