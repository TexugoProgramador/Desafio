//
//  ManipulaDados.swift
//  DesafioApp
//
//  Created by humberto Lima on 08/12/19.
//  Copyright © 2019 humberto Lima. All rights reserved.
//

import UIKit
import CoreData

class ManipulaDados: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func salvaLivro(livroSalvar: ListaLivrosResults, onSuccess:@escaping(Bool, String) -> Void){
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "LivrosSalvos", in: managedContext)!
        let livroInserir = NSManagedObject(entity: entity,  insertInto: managedContext)
        
        livroInserir.setValue(livroSalvar.artistName ?? "", forKey: "artistName")
        livroInserir.setValue(livroSalvar.artistViewUrl ?? "", forKey: "artistViewUrl")
        livroInserir.setValue(livroSalvar.artworkUrl60 ?? "", forKey: "artworkUrl60")
        livroInserir.setValue(livroSalvar.artworkUrl100 ?? "", forKey: "artworkUrl100")
        livroInserir.setValue(livroSalvar.currency ?? "", forKey: "currency")
        livroInserir.setValue(livroSalvar.description ?? "", forKey: "descriptionName")
        livroInserir.setValue(livroSalvar.formattedPrice ?? "", forKey: "formattedPrice")
        livroInserir.setValue(livroSalvar.trackCensoredName ?? "", forKey: "trackCensoredName")
        livroInserir.setValue(livroSalvar.trackId ?? "", forKey: "trackId")
        
        do {
            try managedContext.save()
            onSuccess(true, "Livro Salvo")
        } catch let error as NSError {
            print("Não foi possível salvar erro. \(error), \(error.userInfo)")
            onSuccess(false, "Erro ao salvar dados")
        }
    }
    
    func clearEntities(entity:String) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try managedContext.execute(request)
        } catch {
            return
        }
    }
    
    func retornaLivros() -> [ListaLivrosResults] {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return [ListaLivrosResults()]
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LivrosSalvos")
        
        do {
            let listaLivros = try managedContext.fetch(fetchRequest)
            
            var arrayRetornar = [ListaLivrosResults()]
            if listaLivros.count > 0 {
                for dadoTemp in listaLivros {
                    let livroTemp = ListaLivrosResults(artistName: (dadoTemp.value(forKey: "artistName") as? String ?? ""), artistViewUrl: (dadoTemp.value(forKey: "artistViewUrl") as? String ?? ""), artworkUrl100: (dadoTemp.value(forKey: "artworkUrl100") as? String ?? ""), artworkUrl60: (dadoTemp.value(forKey: "artworkUrl60") as? String ?? ""), currency: (dadoTemp.value(forKey: "currency") as? String ?? ""), description: (dadoTemp.value(forKey: "descriptionName") as? String ?? ""), formattedPrice: (dadoTemp.value(forKey: "formattedPrice") as? String ?? ""), trackCensoredName: (dadoTemp.value(forKey: "trackCensoredName") as? String ?? ""), trackId: (dadoTemp.value(forKey: "trackId") as? Int ?? 0))
                    arrayRetornar.append(livroTemp)
                    //print(arrayRetornar)
                }
                arrayRetornar.remove(at: 0)
                return arrayRetornar
            }else{
                return [ListaLivrosResults()]
            }
            
        } catch let error as NSError {
            print("Dados não encontrados \(error), \(error.userInfo)")
            return [ListaLivrosResults()]
        }
    }
}
