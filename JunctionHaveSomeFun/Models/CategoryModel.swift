//
//  CategoryModel.swift
//  JunctionHaveSomeFun
//
//  Created by taehun on 8/11/24.
//

import Foundation

struct CategoryModel {
    
    var food: Food
    var retail: Retail
    var service: Service
    var entertainment: Entertainment
    var education: Education
    var accommodation: Accommodation
}

struct Food {
    var bp = SubCategory(name: "Bar/Pub", time: "22", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 1000.0, maxLighting: 0.0, minNoise: 65.0, maxNoise: 0.0)
    var dinner = SubCategory(name: "Diner", time: "12", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 0.0, maxLighting: 0.0, minNoise: 41.0, maxNoise: 59.0)
    var restaurant = SubCategory(name: "Restaurant", time: "19", minPopulation: 20.0, maxPopulation: 45.0, minLighting: 0.0, maxLighting: 0.0, minNoise: 30.0, maxNoise: 40.0)
}

struct SubCategory {
    var name: String
    var time: String
    
    var minPopulation: Double
    var maxPopulation: Double

    var minLighting: Double
    var maxLighting: Double

    var minNoise: Double
    var maxNoise: Double
    
    init(name: String, time: String, minPopulation: Double, maxPopulation: Double, minLighting: Double, maxLighting: Double, minNoise: Double, maxNoise: Double) {
        self.name = name
        self.time = time
        self.minPopulation = minPopulation
        self.maxPopulation = maxPopulation
        self.minLighting = minLighting
        self.maxLighting = maxLighting
        self.minNoise = minNoise
        self.maxNoise = maxNoise
    }
}

struct Retail {
    var clothingAndAccessories = SubCategory(name: "Clothing & Accessories", time: "19", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 1000.0, maxLighting: 0.0, minNoise: 41.0, maxNoise: 59.0)
    var convenienceStore = SubCategory(name: "Convenience Store", time: "00", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 1000.0, maxLighting: 0.0, minNoise: 65.0, maxNoise: 0.0)
    var maintenanceService = SubCategory(name: "Maintenance Service", time: "12", minPopulation: 20.0, maxPopulation: 45.0, minLighting: 0.0, maxLighting: 0.0, minNoise: 65.0, maxNoise: 0.0)
}

struct Service {
    var hospital = SubCategory(name: "Hospital", time: "10", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 0.0, maxLighting: 0.0, minNoise: 41.0, maxNoise: 59.0)
    var beautySalon = SubCategory(name: "Beauty Salon", time: "14", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 0.0, maxLighting: 0.0, minNoise: 41.0, maxNoise: 59.0)
    var internetCafe = SubCategory(name: "Internet Cafe", time: "00", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 0.0, maxLighting: 0.0, minNoise: 65.0, maxNoise: 0.0)
}

struct Entertainment {
    var general = SubCategory(name: "Entertainment", time: "22", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 1000.0, maxLighting: 0.0, minNoise: 65.0, maxNoise: 0.0)
}

struct Education {
    var academicAcademy = SubCategory(name: "Academic Academy", time: "21", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 1000.0, maxLighting: 0.0, minNoise: 30.0, maxNoise: 40.0)
    var artsAndSportsAcademy = SubCategory(name: "Arts & Sports Academy", time: "18", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 1000.0, maxLighting: 0.0, minNoise: 41.0, maxNoise: 59.0)
}

struct Accommodation {
    var motel = SubCategory(name: "Motel", time: "00", minPopulation: 46.0, maxPopulation: 0.0, minLighting: 1000.0, maxLighting: 0.0, minNoise: 41.0, maxNoise: 59.0)
    var pension = SubCategory(name: "Pension", time: "16", minPopulation: 0.0, maxPopulation: 19.0, minLighting: 0.0, maxLighting: 0.0, minNoise: 30.0, maxNoise: 40.0)
}
