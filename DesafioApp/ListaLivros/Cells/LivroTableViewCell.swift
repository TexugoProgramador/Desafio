//
//  LivroTableViewCell.swift
//  DesafioApp
//
//  Created by humberto Lima on 08/12/19.
//  Copyright © 2019 humberto Lima. All rights reserved.
//

import UIKit

class LivroTableViewCell: UITableViewCell {

    var idLivro = Int()
    
    @IBOutlet var fotoLivro: UIImageView!
    @IBOutlet var nomeLivro: UILabel!
    @IBOutlet var autorLivro: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
