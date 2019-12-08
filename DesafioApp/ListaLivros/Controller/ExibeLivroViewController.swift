//
//  ExibeLivroViewController.swift
//  DesafioApp
//
//  Created by humberto Lima on 08/12/19.
//  Copyright © 2019 humberto Lima. All rights reserved.
//

import UIKit
import Kingfisher

class ExibeLivroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tabelaLivros: UITableView!
    var indexLivroSelecionado = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelaLivros.delegate = self
        tabelaLivros.dataSource = self
        tabelaLivros.register(UINib(nibName: "LivroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @IBAction func voltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detalheLivro") {
            let vc = segue.destination as! DetalheLivroViewController
            vc.livroSelecionado = api.livrosRetornados.results?[indexLivroSelecionado] ?? ListaLivrosResults()
        }
    }
}

extension ExibeLivroViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (api.livrosRetornados.results?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelaLivros.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LivroTableViewCell
        
        let dadoTemp = api.livrosRetornados.results?[indexPath.row]
        
        cell.fotoLivro.kf.setImage(with: URL(string: dadoTemp?.artworkUrl100 ?? ""))
        cell.nomeLivro.text = dadoTemp?.trackCensoredName
        cell.autorLivro.text = dadoTemp?.artistName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexLivroSelecionado = indexPath.row
        performSegue(withIdentifier: "detalheLivro", sender: self)
    }
}
