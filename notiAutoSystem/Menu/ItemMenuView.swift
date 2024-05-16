//
//  ItemMenuView.swift
//  notiAutoSystem
//
//  Created by user208646 on 5/16/24.
//

import SwiftUI

struct ItemMenuView: View {
    var iconMenu : String
    var labelMenu: String
    var descriptionMenu: String
    
    var body: some View {
        HStack{
            Image(systemName: iconMenu)
                .resizable()
                .frame(width: 20, height: 20)
                .padding()
            
            VStack(alignment: .leading) {
                Text(labelMenu).font(.title)
                Text(descriptionMenu).font(.subheadline)
                
            }
            
            Spacer()
        }
    }
}

struct ItemMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ItemMenuView(iconMenu: "person.fill", labelMenu: "Clientes", descriptionMenu: "Listado de clientes y sus vehiculos")
    }
}
