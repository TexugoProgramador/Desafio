//
//  API.swift
//  DesafioApp
//
//  Created by humberto Lima on 08/12/19.
//  Copyright © 2019 humberto Lima. All rights reserved.
//

import Alamofire

class API {

    let prefixoServidor = "https://itunes.apple.com/search?term="
    
    
    var livrosRetornados = ListaLivros()
    
    
    func getLivros(nomeBuscar: String, onSuccess:@escaping(Bool) -> Void) {
        let url = prefixoServidor + "\(nomeBuscar)&entity=ibook"
        
        //print(url)
        //print(parametros)
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:nil).responseJSON {
            response in
            //print(response.response?.statusCode)
            if response.response?.statusCode == 200 {
                switch response.result {
                case .success( let JSON):
                    //print(JSON)
                    let jsonData = try? JSONSerialization.data(withJSONObject:JSON)
                    guard let temp = try? JSONDecoder().decode(ListaLivros.self, from: jsonData!) else { print("Erro decode"); onSuccess(false); return }
                    self.livrosRetornados = temp
                    //print(self.livrosRetornados)
                    onSuccess(true)
                case .failure( _):
                    onSuccess(false)
                }
            }else{
                onSuccess(false)
            }
        }
        
    }
}
