//
//  ListaLivroViewController.swift
//  DesafioApp
//
//  Created by humberto Lima on 08/12/19.
//  Copyright © 2019 humberto Lima. All rights reserved.
//

import UIKit

class ListaLivroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var meusLivros = [ListaLivrosResults]()
    var indexLivroSelecionado = Int()
    
    @IBOutlet var botaoBusca: UIButton!
    @IBOutlet var campoBusca: UITextField!
    @IBOutlet var labelMensagem: UILabel!
    @IBOutlet var tabelaLivros: UITableView!
    @IBOutlet var carregando: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelaLivros.delegate = self
        tabelaLivros.dataSource = self
        tabelaLivros.register(UINib(nibName: "LivroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        meusLivros = dados.retornaLivros()
        if meusLivros.count >= 1 && verificaLivro(livroRecebido: meusLivros[0]) {
            self.tabelaLivros.alpha = 1
            self.labelMensagem.alpha = 0
            self.tabelaLivros.reloadData()
        }else{
            self.tabelaLivros.alpha = 0
            self.labelMensagem.alpha = 1
            self.labelMensagem.text = "Nenhum livro encontrado"
        }
    }
    
    func alerta(title: String, mensagem:String){
        let alert = UIAlertController(title: title, message: mensagem, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
        
    func carregandoDados() {
        botaoBusca.alpha = 0
        carregando.alpha = 1
        carregando.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func carregouDados() {
        botaoBusca.alpha = 1
        carregando.alpha = 0
        carregando.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    func verificaLivro(livroRecebido: ListaLivrosResults) -> Bool {
        if livroRecebido.trackId != nil {
            return true
        }else{
            return false
        }
    }
    
    @IBAction func buscaLivros(_ sender: UIButton) {
        
        if campoBusca.text != "" {
            self.carregandoDados()
            self.campoBusca.resignFirstResponder()
            api.getLivros(nomeBuscar: (campoBusca.text ?? "")) { (ret) in
                self.carregouDados()
                if ret {
                    self.performSegue(withIdentifier: "exibeLivros", sender: self)
                }else{
                    self.alerta(title: "Aviso", mensagem: "Ocorreu um erro ao consultar dados.")
                }
            }
        }else{
            alerta(title: "Aviso", mensagem: "Digite um termo para fazer a busca de livros.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detalheLivro") {
            let vc = segue.destination as! DetalheLivroViewController
            vc.livroSelecionado = meusLivros[indexLivroSelecionado]
        }
    }
}


extension ListaLivroViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meusLivros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelaLivros.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LivroTableViewCell
        
        let dadoTemp = meusLivros[indexPath.row]
        
        cell.fotoLivro.kf.setImage(with: URL(string: dadoTemp.artworkUrl100 ?? ""))
        cell.nomeLivro.text = dadoTemp.trackCensoredName
        cell.autorLivro.text = dadoTemp.artistName
        
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
