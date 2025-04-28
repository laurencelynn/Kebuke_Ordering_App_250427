//
//  DrinkDetail.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/26/25.
//
import UIKit

// MARK: - 飲料詳細資料 Struct
struct Drink {
    let name: String
    let imageName: String
    let briefIntroduction: String
    let longIntroduction: String
    let mediumPrice: Int
    let largePrice: Int
    let category: DrinkCategory
}

enum DrinkCategory: String, CaseIterable {
    case classic = "乎乾 好茶 Classic"
    case mix = "乎乾 手作 Mix tea"
    case whiteGround = "乎乾 冬瓜 White Ground"
    case milk = "乎乾 鮮奶 Milk tea"
    case caffeineFree = "乎乾 好眠 Caffeine Free"
}

// MARK: - for OrderDetailViewController 
struct OrderItem {
    let drink: Drink
    let size: String
    let sweetness: String
    let ice: String
}

// MARK: - 飲料資料分類

let drinksData: [Drink] = [
    
    // 乎乾 好茶 Classic
    Drink(
        name: "熟成紅茶",
        imageName: "熟成紅茶",
        briefIntroduction: "帶有濃穩果香的經典紅茶",
        longIntroduction: "木質帶熟果香調的風味，流露熟齡男子的沈穩氣息，低調而迷人。嚴選自斯里蘭卡產區之茶葉，帶有濃郁果香及醇厚桂圓香氣；與肉類料理一同品嚐，得以化解舌尖上所殘留的油膩感。",
        mediumPrice: 35,
        largePrice: 40,
        category: .classic
    ),
    Drink(
        name: "麗春紅茶",
        imageName: "麗春紅茶",
        briefIntroduction: "令人傾心淡雅的花香調紅茶",
        longIntroduction: "淡雅輕盈的花香調，可比嬌豔欲滴的罌粟紅花，散發名門閨秀的氣質，優雅而令人傾心。取自罕見的斯里蘭卡中高海拔產區茶葉，帶清爽孤傲的花香；搭配海鮮料理享用，為中和腥羶味的首選。",
        mediumPrice: 35,
        largePrice: 40,
        category: .classic
    ),
    Drink(
        name: "烏米紅茶",
        imageName: "烏米紅茶",
        briefIntroduction: "紅茶邂逅溫火慢焙帶有米香的烏龍",
        longIntroduction: "當紅茶邂逅帶有米香的烏龍，就像是舊友重逢，彼此分享生命中的美好時光。經過溫火慢焙，爆米花香逐漸醞釀，兩種茶品在交織中散發出輕甜與回甘。入口滑順，花香餘韻在喉間縈繞，創造出令人難以忘懷的味覺饗宴。",
        mediumPrice: 35,
        largePrice: 40,
        category: .classic
    ),
    Drink(
        name: "春芽綠茶",
        imageName: "春芽綠茶",
        briefIntroduction: "春滿四溢的青翠綠茶",
        longIntroduction: "縱身綠叢、提筆描繪的青山少年，在春滿四溢的山林中擁抱自然、探索枝芽於舌尖的渴望。萃取自台灣綠茶，蘊含繁茂枝葉所飽存的風土，初嚐甘甜圓潤與低苦澀，青翠欲滴即不絕於口。",
        mediumPrice: 35,
        largePrice: 40,
        category: .classic
    ),
    Drink(
        name: "胭脂紅茶",
        imageName: "胭脂紅茶",
        briefIntroduction: "絲絨般果香調與一抹蜜桃風味",
        longIntroduction: "恬淡的果香調與一抹蜜桃風味，伴隨玫瑰與茉莉花香的情蜜纏綿，好似唇抹胭脂的綺麗女子。清新的紅茶如髮簪鑲嵌的金絲紋理，將60年代華洋集於一身的氛圍，化為迷人的戀舊意識。",
        mediumPrice: 45,
        largePrice: 50,
        category: .classic
    ),


    // 乎乾 手作 Mix tea
    Drink(name: "熟檸紅茶",
                imageName: "熟檸紅茶",
                briefIntroduction: "經典熟成紅茶與100%台灣在地檸檬原汁",
                longIntroduction: "經典熟成紅茶融合100%檸檬原汁，嚴選台灣屏東四季檸檬，以高速離心技術精萃果汁，溫柔去除皮油的苦澀與辛辣，保留純粹的果香與酸甜，打造滑順不刮舌的檸檬紅茶。一口品嚐，清爽酸甜在舌尖綻放，尾韻則透出紅茶的細緻幽香，清新回甘，每一口都剛剛好。",
                mediumPrice: 45,
                largePrice: 55,
                category: .mix
               ),
    Drink(name: "春檸綠茶",
                imageName: "春檸綠茶",
                briefIntroduction: "春日清韻綠茶與100%台灣在地檸檬原汁",
                longIntroduction: "春芽綠茶邂逅100%台灣四季檸檬，以獨家高速離心技術精萃檸檬原汁，溫柔去除皮油的苦澀與辛辣，凝練出澄澈的酸甜果香。綠茶的青潤茶韻交織檸檬的明亮果香，入口清爽不刮舌，細膩回甘，每一口都是春日微風拂過舌尖的愜意。一杯春檸，品味時光的細膩，啜飲春天的剛剛好。",
                mediumPrice: 45,
                largePrice: 55,
                category: .mix
               ),
    Drink(name: "太妃熟成",
                imageName: "太妃熟成",
                briefIntroduction: "咖啡與茶的神秘比例搭配｜Extra Shot 特濃配方＋$10",
                longIntroduction: "咖啡與紅茶的巧妙融合，神秘特調比例帶來絲滑柔順的口感。熟成紅茶的濃郁茶香與獨家日本進口特製UCC咖啡的深邃風味交織，顛覆味蕾的感受。閉上雙眼，輕輕啜飲一口，仿佛置身於麥田小徑，咖啡的香氣隨風飄散，如同悠閒午後的愜意時光，令人留戀其中。全新推出「特濃配方」，讓咖啡紅茶的濃郁滋味再度升級。",
                mediumPrice: 50,
                largePrice: 55,
                category: .mix
               ),
    Drink(name: "金蜜熟成",
                imageName: "金蜜熟成",
                briefIntroduction: "舌尖上的蜂蜜尾韻與經典熟成的香氣",
                longIntroduction: "以熟成紅茶為基底，散發出木質帶熟果香調的風味，是經典不敗的榜上清單，本次加入觸發舌尖奧妙的沁甜蜂蜜，讓經典茶韻更增添層次風味。 ＊無糖僅蜂蜜甜，另有少蜜選項，正常甜與微糖會額外加糖液。",
                mediumPrice: 53,
                largePrice: 63,
                category: .mix
               ),
    Drink(name: "胭脂多多",
                imageName: "胭脂多多",
                briefIntroduction: "兒時記憶裡的多多碰上熟後的蜜桃風味",
                longIntroduction: "以蜜桃韻味為基底的胭脂紅茶，加入酸甜滋味恰如其分的養樂多，勾起甜而不膩的兒時回憶，伴隨著玫瑰與茉莉花香的恬淡，如同陶醉沈浸於純淨的音符之中，如初而美好。 ＊僅提供冷飲、常溫。",
                mediumPrice: 50,
                largePrice: 60,
                category: .mix
         ),
    

    // 乎乾 冬瓜 White Ground
    Drink(name: "雪花冷露",
                imageName: "雪花冷露",
                briefIntroduction: "古法熬煮而成清沁滑順冬瓜露",
                longIntroduction: "出於精煉的冬瓜，經歲月的火侯，成就獨有的韻味及香氣，彷彿古厝裡安然自得、望著懷舊時鐘的老奶奶，一會兒迎著藺草扇起的微風、配著收音機，享受溫煦的午後人生。",
                mediumPrice: 35,
                largePrice: 40,
                category: .whiteGround
               ),
    Drink(name: "熟成冷露",
                imageName: "熟成冷露",
                briefIntroduction: "經典紅茶與古法熬煮冬瓜露",
                longIntroduction: "冬瓜與紅茶的極致特調，慢火入味的冬瓜香氣將清沁滑順的紅茶帶入另一種層次。回憶起於雨煙橋下抽著煙斗、曾經年少的阿公，在舊識中迂迴的嫵媚，作為生活與樸實的調和劑。",
                mediumPrice: 40,
                largePrice: 45,
                category: .whiteGround
               ),
    
    Drink(name: "春芽冷露",
                imageName: "春芽冷露",
                briefIntroduction: "青翠綠茶與古法熬煮冬瓜露",
                longIntroduction: "春芽冷露是一股耐人尋味的質感，如同愛好茶酒和詩詞的阿伯。冬瓜陳年的尾韻，於茶葉清甜圓潤的餘韻下回甘，兩者所釋放的渾厚香氣，尋尋覓覓使人意猶未盡，適合與文學一同啜飲。",
                mediumPrice: 40,
                largePrice: 45,
                category: .whiteGround
               ),
    Drink(name: "胭脂冷露",
                imageName: "胭脂冷露",
                briefIntroduction: "蜜桃果香調紅茶與古法熬煮冬瓜露",
                longIntroduction: "蜜桃風味紅茶加入古法熬煮冬瓜，彷彿時光沉澱的優雅與嬌艷。冬瓜的微甜融入胭脂紅茶的果香層次，隨著玫瑰與蜜桃香氣蕩漾，好似舊時光裡步履輕盈的佳人，留下一抹嫵媚身影。入口是如畫的濃情，回甘則如詩的溫婉。",
                mediumPrice: 45,
                largePrice: 50,
                category: .whiteGround
               ),
    Drink(name: "檸檬冷露",
                imageName: "檸檬冷露",
                briefIntroduction: "古法熬煮冬瓜露與100%台灣在地檸檬原汁",
                longIntroduction: "冬瓜經歲月淬鍊，凝練出獨有的甘醇韻味，遇上100%台灣在地檸檬原汁，微酸輕盈勾勒出清爽層次。以獨家高速離心技術去除檸檬皮油的苦澀與辛辣，留下最純粹的果香。甘甜與酸爽交織，溫潤而透亮，彷彿舊時光裡的一抹清涼，細細品味每一口都是時光沉澱的講究。",
                mediumPrice: 50,
                largePrice: 60,
                category: .whiteGround
               ),

    // 乎乾 鮮奶 Milk tea
    Drink(name: "熟成歐蕾",
                imageName: "熟成歐蕾",
                briefIntroduction: "醇厚鮮奶交織經典紅茶的鮮奶茶",
                longIntroduction: "渲染漸變的茶色，猶如街頭嬉皮風趣的男子，口中恣意地哼著音階。濃郁的紅茶香，本是味覺記憶中的絕品，與溫順甘醇的鮮奶兩相平衡，為奶茶的底蘊更添一股味蕾衝擊，絲滑細膩使人覺醒。",
                mediumPrice: 55,
                largePrice: 65,
                category: .milk
               ),
    Drink(name: "冷露歐蕾",
                imageName: "冷露歐蕾",
                briefIntroduction: "古法熬煮的冬瓜露遇上醇厚鮮奶",
                longIntroduction: "冬瓜與濃醇鮮奶一絲一著、輕巧地流露於唇齒間，雅緻的氣味宛如裁縫女子手中的針線，絲絲入扣地編織交纏，飲啜之間伴隨期盼歸來的情感，一股熟悉的奶香與甜香。",
                mediumPrice: 55,
                largePrice: 65,
                category: .milk
               ),
    Drink(name: "胭脂歐蕾",
                imageName: "胭脂歐蕾",
                briefIntroduction: "絲絨般的蜜桃果香鮮奶茶",
                longIntroduction: "淡雅的蜜桃香氣紅茶，搭配濃郁鮮奶，如同一位迷人的綺麗佳人，將優雅與魅力完美結合。胭脂紅茶帶著柔美的蜜桃芳香，溫潤的鮮奶滲透其中。每一口都讓人沉醉，帶來如絲般的順滑口感與悠長餘韻。",
                mediumPrice: 59,
                largePrice: 69,
                category: .milk
               ),
    Drink(name: "白玉歐蕾",
                imageName: "白玉歐蕾",
                briefIntroduction: "醇厚鮮奶茶咀嚼著Q彈白透珍珠",
                longIntroduction: "台灣手搖飲不可或缺的經典—— 珍珠鮮奶茶。軟嫩嚼感的白玉珍珠，恰似摩登女子的珍珠首飾，以奢華感獨領風潮。與熟成歐蕾完美結合，口感厚實而層次豐富，是一場難以忘懷的味覺饗宴。",
                mediumPrice: 60,
                largePrice: 70,
                category: .milk
               ),

    // 乎乾 好眠 Caffeine Free
    Drink(name: "春梅冰茶",
                imageName: "春梅冰茶",
                briefIntroduction: "春梅與冬瓜相遇",
                longIntroduction: "當冬瓜遇上春梅，酸甜融合瞬間點亮整個口腔。以溫潤的冬瓜茶為基底，搭配風味鮮明的脆梅，展現出一抹令人驚喜的絕妙風味。每一口都仿佛在品味春天的清新與冬季的溫暖，口感層次如波浪般不斷延伸，酸甜交織讓人回味無窮，仿佛帶你走入一場復古的懷舊派對。",
                mediumPrice: 50,
                largePrice: 60,
                category: .caffeineFree
               ),
    Drink(name: "金蜜檸檬",
                imageName: "金蜜檸檬",
                briefIntroduction: "純正龍眼蜂蜜與100%台灣在地檸檬原汁",
                longIntroduction: "酸甜有度，剛剛好比例搭配，100%台灣四季檸檬遇上純正龍眼蜂蜜，輕輕一口，沁涼果香交織蜜韻甘醇，酸而不澀，甜而不膩。以獨家技術精萃檸檬原汁，溫柔去除皮油苦辛，保留最純粹的風味層次。蜂蜜檸檬，簡單卻歷久彌新，無論何時何地都讓人一喝再喝的經典選擇。",
                mediumPrice: 53,
                largePrice: 63,
                category: .caffeineFree
               )
    ]

