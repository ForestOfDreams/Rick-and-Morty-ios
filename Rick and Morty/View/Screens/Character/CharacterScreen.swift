//
//  CharacterScreen.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 24.05.2022.
//

import SwiftUI

struct CharacterScreen: View {
    var body: some View {
        ScrollView {
            CharacterImageView()
            CharacterTitleViews()
            CharacterInfoRow(
                title: "Status:",
                value: "Alive"
            )
            CharacterInfoRow(
                title: "Type:",
                value: "Alive"
            )
            CharacterInfoRow(
                title: "Gender",
                value: "Male"
            )
        }
        .padding(.horizontal, 16)
    }
}

struct CharacterScreen_Previews: PreviewProvider {
    static var previews: some View {
        CharacterScreen()
    }
}

struct CharacterImageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image("Character")
            .resizable()
            .frame(width: 300, height: 300)
            .cornerRadius(10)
            .if(colorScheme == .light) { view in
                view.overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.main), lineWidth: 1)
                }
            }
    }
}

struct CharacterTitleViews: View {
    var body: some View {
        HStack {
            Text("Pickle Rick")
                .fontWeight(.semibold)
                .font(.system(size: 34))
                .foregroundColor(Color(.main))
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "heart.circle.fill")
                    .resizable()
                    .frame(width: 48, height: 48)
            }
        }
    }
}

struct CharacterInfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(.secondary))
                .fontWeight(.semibold)
                .font(.system(size: 22))
            Text(value)
            Rectangle()
                .fill(Color(.main))
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .frame(height: 1)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}



extension View {

    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
