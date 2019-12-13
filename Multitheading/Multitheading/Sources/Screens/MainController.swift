//
//  MainController.swift
//  Multitheading
//
//  Created by ilya on 10/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit

class MainController: UIViewController {
        
    @IBOutlet weak var factTextView: UITextView!
    @IBOutlet weak var factTypeDatePicker: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        
    let domain = "https://numbersapi.p.rapidapi.com/random"
    let header = [
        "x-rapidapi-host": "numbersapi.p.rapidapi.com",
        "x-rapidapi-key": "5f5ad2ede0mshfb45ee1d6d4a1f9p19dad8jsn65b1203a88b5"
    ]
    var fact = "/date?max=20&fragment=true&min=10&json=true"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        factTypeDatePicker.dataSource = self
        factTypeDatePicker.delegate = self
    }
      
    @IBAction func getData(_ sender: UIButton) {
        factTextView.text = ""
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let url = URL(string: domain + fact)!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let factNumber = json["number"] as? Int else { return }
            guard let factText = json["text"] as? String else { return }
            var withYear = ""
            if let year = json["year"] as? Int {
                withYear = "in " + String(year) + " year"
            }
            DispatchQueue.main.async {
                self.factTextView.text = String(factNumber) + ": " + factText + " " + withYear
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }.resume()
    }
}

extension MainController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FactType.allCases.count
    }
}

extension MainController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FactType.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fact = FactType.allCases[row].idFact + "?max=20&fragment=true&min=10&json=true"
    }
}
