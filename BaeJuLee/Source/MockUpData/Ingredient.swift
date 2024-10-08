//
//  IngredientMockUpData.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/22/24.
//

import UIKit

struct Ingredient: Hashable {
    let ingredientName: String
    let ingredientImage: UIImage?

    func hash(into hasher: inout Hasher) {
        hasher.combine(ingredientName)
    }

    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.ingredientName == rhs.ingredientName
    }
}

let vegetable: [Ingredient] = [
    Ingredient(ingredientName: "당근", ingredientImage: UIImage(named: "Carrot")),
    Ingredient(ingredientName: "오이", ingredientImage: UIImage(named: "Cucumber")),
    Ingredient(ingredientName: "마늘", ingredientImage: UIImage(named: "Garlic")),
    Ingredient(ingredientName: "상추", ingredientImage: UIImage(named: "Lettuce")),
    Ingredient(ingredientName: "양파", ingredientImage: UIImage(named: "Onion")),
    Ingredient(ingredientName: "파프리카", ingredientImage: UIImage(named: "Paprika")),
    Ingredient(ingredientName: "감자", ingredientImage: UIImage(named: "Potato")),
    Ingredient(ingredientName: "호박", ingredientImage: UIImage(named: "Pumpkin")),
    Ingredient(ingredientName: "무", ingredientImage: UIImage(named: "Radish")),
    Ingredient(ingredientName: "시금치", ingredientImage: UIImage(named: "Spinach")),
    Ingredient(ingredientName: "고구마", ingredientImage: UIImage(named: "SweetPotato")),
    Ingredient(ingredientName: "토마토", ingredientImage: UIImage(named: "Tomato")),
    Ingredient(ingredientName: "바질", ingredientImage: UIImage(named: "Basil")),
    Ingredient(ingredientName: "양송이버섯", ingredientImage: UIImage(named: "ButtonMushroom")),
    Ingredient(ingredientName: "양배추", ingredientImage: UIImage(named: "Cabbage")),
    Ingredient(ingredientName: "가지", ingredientImage: UIImage(named: "EggPlant")),
    Ingredient(ingredientName: "팽이버섯", ingredientImage: UIImage(named: "EnokiMushroom")),
    Ingredient(ingredientName: "생강", ingredientImage: UIImage(named: "Ginger")),
    Ingredient(ingredientName: "대파", ingredientImage: UIImage(named: "GreenOnion")),
    Ingredient(ingredientName: "새송이버섯", ingredientImage: UIImage(named: "KingOysterMushroom")),
    Ingredient(ingredientName: "쑥", ingredientImage: UIImage(named: "Mugwort")),
    Ingredient(ingredientName: "깻잎", ingredientImage: UIImage(named: "PerillaLeaf")),
    Ingredient(ingredientName: "표고버섯", ingredientImage: UIImage(named: "ShiitakeMushroom")),
    Ingredient(ingredientName: "두부", ingredientImage: UIImage(named: "Tofu"))
]

let snack: [Ingredient] = [
    Ingredient(ingredientName: "초콜릿", ingredientImage: UIImage(named: "Chocolate")),
    Ingredient(ingredientName: "피넛버터", ingredientImage: UIImage(named: "PeanutButter")),
    Ingredient(ingredientName: "마시멜로", ingredientImage: UIImage(named: "Marshmallow"))
]

let seafood: [Ingredient] = [
    Ingredient(ingredientName: "게", ingredientImage: UIImage(named: "Crab")),
    Ingredient(ingredientName: "랍스터", ingredientImage: UIImage(named: "Lobster")),
    Ingredient(ingredientName: "고등어", ingredientImage: UIImage(named: "Mackerel")),
    Ingredient(ingredientName: "연어", ingredientImage: UIImage(named: "Salmon")),
    Ingredient(ingredientName: "새우", ingredientImage: UIImage(named: "Shirimp")),
    Ingredient(ingredientName: "오징어", ingredientImage: UIImage(named: "Squid")),
    Ingredient(ingredientName: "도미", ingredientImage: UIImage(named: "Domi")),
    Ingredient(ingredientName: "김", ingredientImage: UIImage(named: "DriedSeaweed")),
    Ingredient(ingredientName: "장어", ingredientImage: UIImage(named: "Eel")),
    Ingredient(ingredientName: "생선", ingredientImage: UIImage(named: "Fish")),
    Ingredient(ingredientName: "가자미", ingredientImage: UIImage(named: "Gajami")),
    Ingredient(ingredientName: "꽁치", ingredientImage: UIImage(named: "Kkongchi_galchi")),
    Ingredient(ingredientName: "갈치", ingredientImage: UIImage(named: "Kkongchi_galchi")),
    Ingredient(ingredientName: "홍합", ingredientImage: UIImage(named: "Mussel")),
    Ingredient(ingredientName: "문어", ingredientImage: UIImage(named: "Octopus")),
    Ingredient(ingredientName: "삼치", ingredientImage: UIImage(named: "Samchi")),
    Ingredient(ingredientName: "뿔소라", ingredientImage: UIImage(named: "SeaShell")),
    Ingredient(ingredientName: "미역", ingredientImage: UIImage(named: "Seaweed")),
    Ingredient(ingredientName: "바지락", ingredientImage: UIImage(named: "Shellfish")),
    Ingredient(ingredientName: "꼬막", ingredientImage: UIImage(named: "Shellfish")),
    Ingredient(ingredientName: "숭어", ingredientImage: UIImage(named: "SungUh")),
    Ingredient(ingredientName: "가리비", ingredientImage: UIImage(named: "Scallop")),
    Ingredient(ingredientName: "굴", ingredientImage: UIImage(named: "Oyster"))
]

let sauce: [Ingredient] = [
    Ingredient(ingredientName: "고추장", ingredientImage: UIImage(named: "ChiliPepperPaste")),
    Ingredient(ingredientName: "올리브유", ingredientImage: UIImage(named: "OliveOil")),
    Ingredient(ingredientName: "소금", ingredientImage: UIImage(named: "Salt")),
    Ingredient(ingredientName: "간장", ingredientImage: UIImage(named: "SoySauce")),
    Ingredient(ingredientName: "참기름", ingredientImage: UIImage(named: "SesameOil")),
    Ingredient(ingredientName: "바베큐 소스", ingredientImage: UIImage(named: "BBQSauce")),
    Ingredient(ingredientName: "칠리 소스", ingredientImage: UIImage(named: "ChilliSauce")),
    Ingredient(ingredientName: "크림 소스", ingredientImage: UIImage(named: "CreamSauce")),
    Ingredient(ingredientName: "카레 가루", ingredientImage: UIImage(named: "CurryPaste")),
    Ingredient(ingredientName: "꿀", ingredientImage: UIImage(named: "Honey")),
    Ingredient(ingredientName: "핫소스", ingredientImage: UIImage(named: "HotSauce")),
    Ingredient(ingredientName: "케찹", ingredientImage: UIImage(named: "Ketchup")),
    Ingredient(ingredientName: "마요네즈", ingredientImage: UIImage(named: "Mayonnaise")),
    Ingredient(ingredientName: "머스타드", ingredientImage: UIImage(named: "Mustard")),
    Ingredient(ingredientName: "굴소스", ingredientImage: UIImage(named: "OysterSauce")),
    Ingredient(ingredientName: "후추", ingredientImage: UIImage(named: "Pepper")),
    Ingredient(ingredientName: "고춧가루", ingredientImage: UIImage(named: "PepperSpice")),
    Ingredient(ingredientName: "식용유", ingredientImage: UIImage(named: "Oil")),
    Ingredient(ingredientName: "로제 소스", ingredientImage: UIImage(named: "RoseSauce")),
    Ingredient(ingredientName: "오리엔탈 드레싱", ingredientImage: UIImage(named: "SaladSauce")),
    Ingredient(ingredientName: "유자 드레싱", ingredientImage: UIImage(named: "SaladSauce")),
    Ingredient(ingredientName: "발사믹 드레싱", ingredientImage: UIImage(named: "SaladSauce")),
    Ingredient(ingredientName: "사우전 아일랜드 드레싱", ingredientImage: UIImage(named: "SaladSauce")),
    Ingredient(ingredientName: "된장", ingredientImage: UIImage(named: "SoybeanPaste")),
    Ingredient(ingredientName: "설탕", ingredientImage: UIImage(named: "Sugar")),
    Ingredient(ingredientName: "데리야끼", ingredientImage: UIImage(named: "Teriyaki")),
    Ingredient(ingredientName: "토마토 소스", ingredientImage: UIImage(named: "TomatoSauce")),
    Ingredient(ingredientName: "식초", ingredientImage: UIImage(named: "Vinegar")),
    Ingredient(ingredientName: "와사비", ingredientImage: UIImage(named: "Wasabi")),
    Ingredient(ingredientName: "홀토마토", ingredientImage: UIImage(named: "WholeTomato"))
]

let rice: [Ingredient] = [
    Ingredient(ingredientName: "쌀", ingredientImage: UIImage(named: "Rice")),
    Ingredient(ingredientName: "현미", ingredientImage: UIImage(named: "BrownRice")),
    Ingredient(ingredientName: "오트밀", ingredientImage: UIImage(named: "Oatmeal"))
]

let noodle: [Ingredient] = [
    Ingredient(ingredientName: "파스타면", ingredientImage: UIImage(named: "SpaghettiNoodle")),
    Ingredient(ingredientName: "당면", ingredientImage: UIImage(named: "GlassNoodle")),
    Ingredient(ingredientName: "메밀면", ingredientImage: UIImage(named: "BuckwheatNoodles")),
    Ingredient(ingredientName: "페투치네", ingredientImage: UIImage(named: "Fettuccine")),
    Ingredient(ingredientName: "칼국수면", ingredientImage: UIImage(named: "KalNoodle")),
    Ingredient(ingredientName: "라자냐", ingredientImage: UIImage(named: "Lasagna")),
    Ingredient(ingredientName: "마카로니", ingredientImage: UIImage(named: "Macaroni")),
    Ingredient(ingredientName: "소면", ingredientImage: UIImage(named: "PlainNoodles")),
    Ingredient(ingredientName: "떡볶이 떡", ingredientImage: UIImage(named: "Tteok")),
    Ingredient(ingredientName: "우동 사리", ingredientImage: UIImage(named: "UdonNoodle"))
]

let dairyProduct: [Ingredient] = [
    Ingredient(ingredientName: "버터", ingredientImage: UIImage(named: "Butter")),
    Ingredient(ingredientName: "체다치즈", ingredientImage: UIImage(named: "CheddarCheese")),
    Ingredient(ingredientName: "우유", ingredientImage: UIImage(named: "Milk")),
    Ingredient(ingredientName: "생크림", ingredientImage: UIImage(named: "WhippingCream")),
    Ingredient(ingredientName: "요거트", ingredientImage: UIImage(named: "Yogurt")),
    Ingredient(ingredientName: "크림 치즈", ingredientImage: UIImage(named: "CreamCheese")),
    Ingredient(ingredientName: "그릭 요거트", ingredientImage: UIImage(named: "GreekYogurt")),
    Ingredient(ingredientName: "모짜렐라 치즈", ingredientImage: UIImage(named: "Mozzarella"))
]

let meat: [Ingredient] = [
    Ingredient(ingredientName: "닭가슴살", ingredientImage: UIImage(named: "ChickenBreast")),
    Ingredient(ingredientName: "닭고기", ingredientImage: UIImage(named: "Chicken")),
    Ingredient(ingredientName: "계란", ingredientImage: UIImage(named: "Egg")),
    Ingredient(ingredientName: "삼겹살", ingredientImage: UIImage(named: "PorkBelly")),
    Ingredient(ingredientName: "돼지갈비살", ingredientImage: UIImage(named: "PorkRibs")),
    Ingredient(ingredientName: "소등심", ingredientImage: UIImage(named: "Sirloin")),
    Ingredient(ingredientName: "소안심", ingredientImage: UIImage(named: "Tenderloin")),
    Ingredient(ingredientName: "베이컨", ingredientImage: UIImage(named: "Bacon")),
    Ingredient(ingredientName: "양고기", ingredientImage: UIImage(named: "Lamb")),
    Ingredient(ingredientName: "소세지", ingredientImage: UIImage(named: "Sausage")),
    Ingredient(ingredientName: "우삼겹", ingredientImage: UIImage(named: "BeefBrisket")),
    Ingredient(ingredientName: "대패삼겹살", ingredientImage: UIImage(named: "PorkBelly")),
    Ingredient(ingredientName: "오리고기", ingredientImage: UIImage(named: "Chicken")),
]

let kimchi_deli: [Ingredient] = [
    Ingredient(ingredientName: "배추김치", ingredientImage: UIImage(named: "CabbageKimchi")),
    Ingredient(ingredientName: "깍두기", ingredientImage: UIImage(named: "RadishKimchi")),
    Ingredient(ingredientName: "떡갈비", ingredientImage: UIImage(named: "Tteokgalbi"))
]

let fruits: [Ingredient] = [
    Ingredient(ingredientName: "사과", ingredientImage: UIImage(named: "Apple")),
    Ingredient(ingredientName: "바나나", ingredientImage: UIImage(named: "Banana")),
    Ingredient(ingredientName: "블루베리", ingredientImage: UIImage(named: "BlueBerry")),
    Ingredient(ingredientName: "복숭아", ingredientImage: UIImage(named: "Peach")),
    Ingredient(ingredientName: "아보카도", ingredientImage: UIImage(named: "Avocado")),
    Ingredient(ingredientName: "자몽", ingredientImage: UIImage(named: "GrapeFruits")),
    Ingredient(ingredientName: "레몬", ingredientImage: UIImage(named: "Lemon")),
    Ingredient(ingredientName: "귤", ingredientImage: UIImage(named: "Mandarin")),
    Ingredient(ingredientName: "망고", ingredientImage: UIImage(named: "Mango")),
    Ingredient(ingredientName: "오렌지", ingredientImage: UIImage(named: "Orange")),
    Ingredient(ingredientName: "파인애플", ingredientImage: UIImage(named: "PineApple")),
    Ingredient(ingredientName: "딸기", ingredientImage: UIImage(named: "Strawberry"))
]

let etc: [Ingredient] = [
    Ingredient(ingredientName: "감자 전분", ingredientImage: UIImage(named: "UniversalPowder")),
    Ingredient(ingredientName: "튀김 가루", ingredientImage: UIImage(named: "UniversalPowder")),
    Ingredient(ingredientName: "아몬드", ingredientImage: UIImage(named: "Almond")),
    Ingredient(ingredientName: "어묵", ingredientImage: UIImage(named: "FishCake")),
    Ingredient(ingredientName: "밀가루", ingredientImage: UIImage(named: "Flour")),
    Ingredient(ingredientName: "레드 와인", ingredientImage: UIImage(named: "RedWine")),
    Ingredient(ingredientName: "화이트 와인", ingredientImage: UIImage(named: "WhiteWine")),
]

let convenienceFood: [Ingredient] = [
    Ingredient(ingredientName: "냉동만두", ingredientImage: UIImage(named: "FrozenDumplings")),
    Ingredient(ingredientName: "라면", ingredientImage: UIImage(named: "Ramen")),
    Ingredient(ingredientName: "컵라면", ingredientImage: UIImage(named: "CupNoodle")),
    Ingredient(ingredientName: "즉석 카레", ingredientImage: UIImage(named: "InstantCurry")),
    Ingredient(ingredientName: "샐러드", ingredientImage: UIImage(named: "Salad")),
    Ingredient(ingredientName: "냉동 돈까스", ingredientImage: UIImage(named: "Tonkatsu"))
]

let can: [Ingredient] = [
    Ingredient(ingredientName: "옥수수 통조림", ingredientImage: UIImage(named: "CornCan")),
    Ingredient(ingredientName: "스팸", ingredientImage: UIImage(named: "Spam")),
    Ingredient(ingredientName: "참치 통조림", ingredientImage: UIImage(named: "Tuna")),
    Ingredient(ingredientName: "꽁치 통조림", ingredientImage: UIImage(named: "FishCan")),
    Ingredient(ingredientName: "골뱅이 통조림", ingredientImage: UIImage(named: "WhelkCan")),
    Ingredient(ingredientName: "황도 통조림", ingredientImage: UIImage(named: "hwangdo")),
    Ingredient(ingredientName: "올리브 통조림", ingredientImage: UIImage(named: "OliveCan")),
]

let bread: [Ingredient] = [
    Ingredient(ingredientName: "베이글", ingredientImage: UIImage(named: "Bagle")),
    Ingredient(ingredientName: "식빵", ingredientImage: UIImage(named: "SandwichBread")),
    Ingredient(ingredientName: "치아바타", ingredientImage: UIImage(named: "Ciabatta")),
    Ingredient(ingredientName: "또띠아", ingredientImage: UIImage(named: "Tortilla"))
]
