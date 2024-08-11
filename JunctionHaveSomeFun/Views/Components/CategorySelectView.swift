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
                .padding(EdgeInsets(top: 12.5, leading: 72, bottom: 12.5, trailing: 72))
            ForEach(Array(categories.keys.sorted()), id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    print(category)
                }) {
                    Text(category)
                        .font(Font.custom("Apple SD Gothic Neo", size: 16))
                        .foregroundColor(selectedCategory == category ? .blue : .primary)
                        .padding(EdgeInsets(top: 12.5, leading: 72, bottom: 12.5, trailing: 72))
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                .background(.white)
                .overlay(
                    Rectangle()
                        .inset(by: 0.25)
                    
                        .stroke(Color(red: 0.7, green: 0.7, blue: 0.7), lineWidth: 0.5)
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
                            categoryStore.selectSubCategory(mainCategory: selectedCategory, subCategoryName: subcategory)
                            
                        }) {
                            Text(subcategory)
                                .font(Font.custom("Apple SD Gothic Neo", size: 16))
                                .padding(EdgeInsets(top: 12.5, leading: 72, bottom: 12.5, trailing: 72))
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                        .background(.white)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.25)
                            
                                .stroke(Color(red: 0.7, green: 0.7, blue: 0.7), lineWidth: 0.5)
                        )
                    }
                }
            }
            
            
            
            
            
            //        HStack(alignment: .top, spacing: 0) {
            //            // Main Category List
            //            VStack(alignment: .leading, spacing: 0) {
            //                Text("Main Category")
            //                    .font(.headline)
            //                    .padding(.bottom, 10)
            //
            //                    VStack(alignment: .leading, spacing: 5) {
            //                        ForEach(Array(categories.keys.sorted()), id: \.self) { category in
            //                            Button(action: {
            //                                selectedCategory = category
            //                            }) {
            //                                Text(category)
            //                                    .font(.custom("Apple SD Gothic Neo", size: 16))
            //                                    .foregroundColor(selectedCategory == category ? .blue : .primary)
            //                                    .padding(.vertical, 8)
            //                                    .frame(maxWidth: .infinity, alignment: .leading)
            //                            }
            //                            .buttonStyle(PlainButtonStyle())
            //                        }
            //                }
            //            }
            //            .frame(width: 250)
            //
            //            Image(systemName: "chevron.right")
            //                .frame(width: 30, height: 30)
            //
            //            // Subcategory List
            //            VStack(alignment: .leading, spacing: 0) {
            //                Text("Subcategory")
            //                    .font(.headline)
            //                    .padding(.bottom, 10)
            //
            //                    VStack(alignment: .leading, spacing: 5) {
            //                        if let selectedCategory = selectedCategory,
            //                           let subcategories = categories[selectedCategory] {
            //                            ForEach(subcategories, id: \.self) { subcategory in
            //                                Button(action: {
            //                                    categoryStore.selectSubCategory(mainCategory: selectedCategory, subCategoryName: subcategory)
            //                                }) {
            //                                    Text(subcategory)
            //                                        .font(.custom("Apple SD Gothic Neo", size: 16))
            //                                        .foregroundColor(.primary)
            //                                        .padding(.vertical, 8)
            //                                        .frame(maxWidth: .infinity, alignment: .leading)
            //                                }
            //                                .buttonStyle(PlainButtonStyle())
            //                            }
            //                        } else {
            //                            Text("Please select a main category")
            //                                .font(.custom("Apple SD Gothic Neo", size: 16))
            //                                .foregroundColor(.gray)
            //                                .padding(.vertical, 8)
            //                        }
            //                    }
            //            }
            //            .frame(width: 250)
            //        }
            //        .padding(EdgeInsets(top: 30, leading: 22, bottom: 30, trailing: 22))
            //        .background(Color.lightGray)
            //        .navigationTitle("Categories")
            //        .frame(height: 300)
        }
        
    }
}

#Preview {
    CategorySelectionView()
}
