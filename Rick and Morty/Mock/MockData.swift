//
//  MockData.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 06.05.2022.
//

import Foundation

struct MockData {
    let characterModel = CharacterViewController.Model(
        statusModel: .init(key: "Some", value: "Value"),
        name: "Rick",
        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
    )
    
    let suggests = SearchSuggestsViewController.Model(
        cells: [
            SearchSuggestsTableCell.Model(
                title: "Recents",
                collectionCellContent: [
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
                    ),
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")!
                    ),
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg")!
                    ),
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/30.jpeg")!
                    ),
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/20.jpeg")!
                    )
                ]
            ),
            SearchSuggestsTableCell.Model(
                title: "Recents",
                collectionCellContent: [
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
                    ),
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")!
                    ),
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg")!
                    ),
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/30.jpeg")!
                    ),
                    SearchSuggestsCollectionCell.Model(
                        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/20.jpeg")!
                    )
                ]
            )
        ]
    )
    
    let searchResults = SearchResultsViewController.Model(
        cells: [
            SearchResultTableCell.Model(
                name: "Rick",
                type: "Human",
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")!
            ),
            SearchResultTableCell.Model(
                name: "Bloom",
                type: "Human",
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/10.jpeg")!
            )
        ]
    )
    
    var searchModel: SearchViewController.Model {
        SearchViewController.Model (
            suggests: suggests,
            searchResults:searchResults
        )
    }
    
    let favoriteModel: FavoritesViewController.Model = FavoritesViewController.Model(
        cells: [
            FavoriteTableCell.Model(
                name: "Rick",
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/20.jpeg")!
            ),
            FavoriteTableCell.Model(
                name: "Morty",
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/30.jpeg")!
            )
        ]
    )
}
