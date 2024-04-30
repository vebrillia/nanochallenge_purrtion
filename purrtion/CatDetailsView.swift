//
//  catDetails.swift
//  purrtion
//
//  Created by Vebrillia Santoso on 29/04/24.
//

import SwiftUI

struct CatHistoryEntry: Identifiable {
    var id = UUID()
    var cat: Cat
    var caloriesNeeded: Int
    var feedingFrequency: String
}

struct CatDetails: View {
    @State private var navigateToCollection = false
    var cat: Cat
    @State private var catHistory: [CatHistoryEntry] = []
    
    var body: some View {
        VStack {
            Text("Name: \(cat.name)")
            Text("Age: \(displayAge(catAge: cat.age))")
            Text("Weight: \(cat.weight) kg")
            Text("Calories Needed: \(calculateCalories(cat: cat))")
            Text("Feeding Frequency: \(feedingFrequency(cat: cat))")
        }
        Button(action: {
            navigateToCollection = true
            let historyEntry = CatHistoryEntry(cat: cat, caloriesNeeded: calculateCalories(cat: cat), feedingFrequency: feedingFrequency(cat: cat))
                    catHistory.append(historyEntry)
                }) {
                    Text("Add to History")
                }
                .navigationDestination(isPresented: $navigateToCollection) {
                    CatCollectionView(catHistory: catHistory)
                }
//                .navigationBarBackButtonHidden(true)
    }
    
    func displayAge(catAge: Int) -> String {
        if catAge < 12 {
            return "\(catAge) months"
        } else {
            return "\(catAge / 12) years"
        }
    }
    
    func calculateCalories(cat: Cat) -> Int {
        if cat.age <= 6 {
            return cat.weight * 30
        }  else if cat.age > 7 && cat.age <= 84{
            return cat.weight * 66
        } else if cat.age > 84{
            return cat.weight * 50
        }
        else {
            return 0
        }
    }
    
    func feedingFrequency(cat: Cat) -> String {
        if cat.age <= 6 {
            return "3-4 times a day"
        } else if cat.age > 7 && cat.age <= 84{
            return "2 times a day"
        } else if cat.age > 84{
            return "3-4 times a day"
        }
        else {
            return ""
        }
    }
}

struct CatDetails_Previews: PreviewProvider {
    static var previews: some View {
        CatDetails(cat: Cat(name: "Fluffy", age: 3, weight: 5))
    }
}
