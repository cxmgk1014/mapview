import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!//MapViewのアウトレット
    
    @IBOutlet var labelAltitude: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaultsを生成
        let ud = UserDefaults.standard
        
        //経緯度を読み込む
        let lat = ud.double(forKey: "LAT")
        let lon = ud.double(forKey: "LON")
        
        //CLLocationCoordinate2Dに変換
        let coordinate = CLLocationCoordinate2DMake(lat,lon)
        
        //表示範囲を読み込む
        let latDelta:CLLocationDegrees = ud.double(forKey: "LAT_DELTA")
        let lonDelta:CLLocationDegrees = ud.double(forKey: "LON_DELTA")
        
        //MKCoordinateSpanに変換
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta);
        
        //表示範囲と経緯度を地図に設定する
        mapView.region.span = span
        mapView.setCenter(coordinate, animated: false)
        mapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView,regionDidChangeAnimated animated: Bool) {
        
        //UserDefaultsを生成
        let ud = UserDefaults.standard
        
        //経緯度を保存する　LAT(LATITUDE)：緯度　LON(LONGITUDE)：経度
        ud.set(mapView.centerCoordinate.latitude, forKey: "LAT")
        ud.set(mapView.centerCoordinate.longitude, forKey: "LON")
        
        //表示範囲を保存する
        ud.set(mapView.region.span.latitudeDelta, forKey: "LAT_DELTA")
        ud.set(mapView.region.span.longitudeDelta, forKey: "LON_DELTA")
        
        ud.synchronize()
    }
}
