//
//  Candidates.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 30/04/2020.
//  Copyright © 2020 Vladimir Bulakhov. All rights reserved.
//

import Foundation

struct Candidate {
    
    var name: String
    var party: String
    var description: String
    var image: String
    var shortName: String
    var votes: Int
    var index: Int
    
    static func fillArray() -> [Candidate] {
        var arrayOfCandidates = [Candidate]()
        arrayOfCandidates.append(Candidate(name: "Владимир Владимирович Путин", party: "Самовыдвижение", description: "Действующий президент Российской Федерации", image: "путин", shortName: "В.В. Путин", votes: 0, index: 0))
        arrayOfCandidates.append(Candidate(name: "Бабурин Сергей Николаевич", party: "Российский общенародный союз", description: "Главный научный сотрудник ИСПИ РАН, лидер РОС", image: "бабурин", shortName: "С.Н. Бабурин", votes: 0, index: 1))
        arrayOfCandidates.append(Candidate(name: "Грудинин Павел Николаевич", party: "КПРФ", description: "Директор ЗАО «Совхоз имени Ленина», председатель Совета депутатов городского поселения Видное", image: "грудинин", shortName: "П.Н. Грудинин", votes: 0, index: 2))
        arrayOfCandidates.append(Candidate(name: "Жириновский Владимир Вольфович", party: "ЛДПР", description: "Председатель ЛДПР, руководитель фракции ЛДПР в Госдуме РФ", image: "жириновский", shortName: "В.В. Жириновский", votes: 0, index: 3))
        arrayOfCandidates.append(Candidate(name: "Собчак Ксения Анатольевна", party: "Гражданская инициатива", description: "Журналист, ведущая телеканала «Дождь»", image: "собчак", shortName: "К.А. Собчак", votes: 0, index: 4))
        arrayOfCandidates.append(Candidate(name: "Сурайкин Максим Александрович", party: "Коммунисты России", description: "Председатель ЦК партии «Коммунисты России»", image: "сурайкин", shortName: "М.А. Сурайкин", votes: 0, index: 5))
        arrayOfCandidates.append(Candidate(name: "Титов Борис Юрьевич", party: "Партия Роста", description: "Уполномоченный по защите прав предпринимателей в России, председатель «Партии Роста»", image: "титов", shortName: "Б.Ю. Титов", votes: 0, index: 6))
        arrayOfCandidates.append(Candidate(name: "Явлинский Григорий Алексеевич", party: "Яблоко", description: "Председатель Федерального Политического комитета партии «Яблоко»", image: "явлинский", shortName: "Г.А. Явлинский", votes: 0, index: 7))
        return arrayOfCandidates
    }
    
}
