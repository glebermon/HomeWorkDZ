import UIKit

// Придумал следующие классы для реализации дженерика:


// У нас есть сад с яблоками и грушами, которые мы собираем каждый день (шт)

class Garden {
    let apples: Int
    let pears: Int
    
    init(apples: Int, pears: Int) {
        self.apples = apples
        self.pears = pears
    }
    
    func sumFruit() -> String {
        var sum = 0
        var sumString = ""
        sum = apples + pears
        sumString = "Всего собарно фруктов \(sum) штук"
        return sumString
    }
}

// У нас есть ферма с говядиной, свининой и курицой, которых мы заготавливаем каждый день (кг)

class Farm {
    let beef: Double
    let pork: Double
    let hen: Double
    
    init(beef: Double, pork: Double, hen: Double) {
        self.beef = beef
        self.pork = pork
        self.hen = hen
    }
    
    func sumMeet() -> String {
        var sum = 0.0
        var sumString = ""
        sum = beef + pork + hen
        sumString = "Всего собрано мяса \(sum) килограмм"
        return sumString
    }
}

// СДЕЛАЮ ОЧЕРЕДЬ (QUEUE)

struct Queue1<T> {
    private var elements: [T] = []
    mutating func push(_ element: T) {
        elements.insert(element, at: 0)
    }
    mutating func pop() -> T? {
        return elements.removeLast()
    }
}

var queueGarden = Queue1<Garden>()
var queueFarm = Queue1<Farm>()

// Проверим как моя очередь работает

queueGarden.push(Garden(apples: 3, pears: 5))
queueGarden.push(Garden(apples: 5, pears: 8))
queueGarden.push(Garden(apples: 10, pears: 3))
queueGarden.push(Garden(apples: 12, pears: 11))
queueGarden.push(Garden(apples: 1, pears: 7))
queueGarden.push(Garden(apples: 4, pears: 9))

queueGarden.pop() // возвращает apples: 3, pears: 5


let closure: (Int, Int) -> Bool = { (itemOne: Int, itemTwo: Int) -> Bool in
    return itemOne == itemTwo
}
closure(2, 2) // true

// =============================================================================================

// ПРИМЕР ИЗ МЕТОДИЧКИ


// определяет четное число
let odd: (Int) -> Bool = { (element: Int) -> Bool in
    return element % 2 == 0
}
// определяет нечетное число
let even: (Int) -> Bool = { (element: Int) -> Bool in
    return element % 2 != 0
}
var array = [1,2,3,4,5,6,7,8,9,10]
// принимает два аргумента – массив и замыкание
func filter(array: [Int], predicate: (Int) -> Bool ) -> [Int] {
    var tmpArray = [Int]()               // создает временный массив
    for element in array {
        if predicate(element) {         // вызываем замыкание, чтобы проверить элемент
            tmpArray.append(element)
        }
    }
    return tmpArray                     // возвращаем отфильтрованный массив
}
filter(array: array, predicate: odd)   // [2, 4, 6, 8, 10]
filter(array: array, predicate: even) // [1, 3, 5, 7, 9]

// =============================================================================================

// КАК Я РЕАЛИЗОВАЛ ЗАМЫКАНИЯ

var nameArray = ["Max", "Petya ", "Vasya", "Sasha", "Max", "Dina", "Gena", "Vlad", "Max", "Vlad", "Max", "Vlad",]

let name: (String) -> Bool = { (element: String) -> Bool in
    return element == "Max"
}
let name1: (String) -> Bool = { (element: String) -> Bool in
    return element != "Max"
}

func allMax<T>(array: [T], predicate: (T) -> Bool ) -> [T] {
    var tempArray = [T]()
    for element in array {
        if predicate(element) {
            tempArray.append(element)
        }
    }
    return tempArray
}

// УБРАЛИ ВСЕХ МАКСОВ В ОДНУ КОМАНАТУ

let result = allMax(array: nameArray, predicate: { (element: String) -> Bool in
    return name(element)
})
result

// ВСЕ, КТО НЕ МАКС - В ДРУГОЙ КОМНАЕТ

let result1 = allMax(array: nameArray, predicate: { (element: String) -> Bool in
    return name1(element)
})
result1

nameArray.sorted() // без параметров просто сортирует по алфавиту наш класс

let nameResult = nameArray.sorted {$0 > $1} // по алфавиту в обратном порядке
nameResult

// =============================================================================================

var arrayNumbers = [1,2,3,4,5,6,7,8,9,10]
var prosto = arrayNumbers.filter{ $0 % 2 == 0 }  // [2, 4, 6, 8, 10]
arrayNumbers.filter{ $0 % 2 != 0 } // [1, 3, 5, 7, 9]

// =============================================================================================

// Сделаю subscript, который в случае обращения к не существующему индексу будет возвращать nill
// Сделаю его простым, чтобы мне было понятно, как он работает в структуре.

struct Car {
    var engine = "V8"
    var model = "Toyota camry"
    var weels = ["fLeft", "fRight", "rearLeft", "rearRight"] // передние колеса(левое и правое), задние колеса(левое и правое)
    
    var count: Int {
        return 2 + weels.count
    }
    
    subscript(index: Int) -> String? {
        get {
            switch(index) {
            case 0: return engine
            case 1: return model
            case 2..<(2+weels.count): return weels[index - 2]
            default: return nil
            }
        }
    }
}

var car = Car()
car.count

car[0]
car[1]
car[2]
car[3]
car[4]
car[5]
car[6] // ТАКОГО ИНДЕКЧСА НЕТ - ВОЗВРАЩАЕТ nil
