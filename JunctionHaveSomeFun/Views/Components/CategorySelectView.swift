//
//  CategorySelectView.swift
//  JunctionHaveSomeFun
//
//  Created by taehun on 8/11/24.
//

import SwiftUI

// 1. 카테고리 초기화
class CategoryStore: ObservableObject {
    @Published var selectedSubCategory: SubCategory?
    
    let food = Food()
    let retail = Retail()
    let service = Service()
    let entertainment = Entertainment()
    let education = Education()
    let accommodation = Accommodation()
    
    // 2. selectSubCategory 함수
    func selectSubCategory(mainCategory: String, subCategoryName: String) {
        switch mainCategory {
        case "Food":
            switch subCategoryName {
            case "Bar/Pub": selectedSubCategory = food.bp
            case "Diner": selectedSubCategory = food.dinner
            case "Restaurant": selectedSubCategory = food.restaurant
            default: break
            }
        case "Retail":
            switch subCategoryName {
            case "Clothing & Accessories": selectedSubCategory = retail.clothingAndAccessories
            case "Convenience Store": selectedSubCategory = retail.convenienceStore
            case "Maintenance Service": selectedSubCategory = retail.maintenanceService
            default: break
            }
        case "Service":
            switch subCategoryName {
            case "Hospital": selectedSubCategory = service.hospital
            case "Beauty Salon": selectedSubCategory = service.beautySalon
            case "Internet Cafe": selectedSubCategory = service.internetCafe
            default: break
            }
        case "Entertainment":
            selectedSubCategory = entertainment.general
        case "Education":
            switch subCategoryName {
            case "Academic Academy": selectedSubCategory = education.academicAcademy
            case "Arts & Sports Academy": selectedSubCategory = education.artsAndSportsAcademy
            default: break
            }
        case "Accommodation":
            switch subCategoryName {
            case "Motel": selectedSubCategory = accommodation.motel
            case "Pension": selectedSubCategory = accommodation.pension
            default: break
            }
        default: break
        }
    }
}

struct CategorySelectionView: View {
    @StateObject private var categoryStore = CategoryStore()
    @State private var selectedCategory: String?
    @Binding var industry: SubCategory?
    let categories: [String: [String]] = [
        "Food": ["Bar/Pub", "Diner", "Restaurant"],
        "Retail": ["Clothing & Accessories", "Convenience Store", "Maintenance Service"],
        "Service": ["Hospital", "Beauty Salon", "Internet Cafe"],
        "Entertainment": ["General"],
        "Education": ["Academic Academy", "Arts & Sports Academy"],
        "Accommodation": ["Motel", "Pension"]
    ]
    
    var body: some View {
        HStack(alignment:. top, spacing: 0) {
        
        VStack(spacing: 0) {
            Text("Main Category")
                .font(.headline)
                .padding(.bottom, 10)
            ForEach(Array(categories.keys.sorted()), id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    print(category)
                }) {
                    Text(category)
                        .font(Font.custom("Apple SD Gothic Neo", size: 16))
                        .foregroundColor(selectedCategory == category ? .blue : .primary)
                }
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                .background(.white)
                .overlay(
                    Rectangle()
                        .inset(by: 0.25)
                        .stroke(Color(red: 0.7, green: 0.7, blue: 0.7), lineWidth: 0.5)
                        .frame(maxWidth: 200, minHeight: 44, alignment: .center)

                )
            }
        }
        
            Image(systemName: "chevron.right")
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal, 20)
            
            VStack(spacing: 0) {
                Text("Subcategory")
                    .font(.headline)
                    .padding(.bottom, 10)
                if let selectedCategory = selectedCategory,
                   let subcategories = categories[selectedCategory] {
                    ForEach(subcategories, id: \.self) { subcategory in
                        
                        Button(action: {
//                            industry = categories[subcategory]
                            
                        }) {
                            Text(subcategory)
                                .font(Font.custom("Apple SD Gothic Neo", size: 16))
                                .foregroundStyle(.manInBlack)
                        }
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                        .background(.white)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.25)
                                .stroke(Color(red: 0.7, green: 0.7, blue: 0.7), lineWidth: 0.5)
                                .frame(maxWidth: 200, minHeight: 44, alignment: .center)

                        )
                    }
                }
            }
        }
        .frame(width: 454, height: 302, alignment: .top)
    }
}

#Preview {
    CategorySelectionView()
}
