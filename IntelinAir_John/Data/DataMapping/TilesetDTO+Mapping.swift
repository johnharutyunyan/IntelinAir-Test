//
//  TilesetDTO+Mapping.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/13/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import Foundation

struct TilesetDTO: Decodable {
    let path: String?
    let name: String?
    let exportGeotiffThumbnail: String?
}

extension TilesetDTO {
    
    func toDomain() -> Tileset {
        .init(path: path, name: name, exportGeotiffThumbnail: exportGeotiffThumbnail)
    }
}
