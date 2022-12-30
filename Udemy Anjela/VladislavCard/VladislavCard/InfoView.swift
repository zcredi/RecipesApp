//
//  InfoView.swift
//  VladislavCard
//
//  Created by Владислав on 30.12.2022.
//

import SwiftUI

struct InfoView: View {
    
    let text: String
    let imageName: String
    
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(height: 50)
            .overlay(HStack {
                Image(systemName: imageName)
                    .foregroundColor(.green)
                Text(text)
            })
            .padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "+375(25) 677 - 54 - 83", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
