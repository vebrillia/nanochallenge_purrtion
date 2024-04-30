//
//  catCollectionView.swift
//  purrtion
//
//  Created by Vebrillia Santoso on 30/04/24.
//

import SwiftUI

struct CatCollectionView: View {
    var catHistory: [CatHistoryEntry]
    
    
    var body: some View {
            List(catHistory) { historyEntry in
                VStack(alignment: .leading) {
                    Text("Name: \(historyEntry.cat.name)")
                    Text("Age: \(historyEntry.cat.age)")
                    Text("Weight: \(historyEntry.cat.weight) kg")
                    Text("Calories Needed: \(historyEntry.caloriesNeeded)")
                    Text("Feeding Frequency: \(historyEntry.feedingFrequency)")
                }
            }
            .navigationBarTitle("Your Cats", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    
    
}



//#Preview {
//    catCollectionView()
//}
