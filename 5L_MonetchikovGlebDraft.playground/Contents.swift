import UIKit

enum CarDoorState {
    case open, close
}
enum WindowsState {
    case open, close
}
enum Transmission {
    case manual, auto
}
enum CarHatchState {
    case open, close
}
enum EngineOnOff {
    case on, off
}
enum CarSuspension {
    case ressory, pnevmo
}
enum KindOfTruck {
    case opernPlatform, container, withBoards
}
enum CraneState {
    case raised, removed
}
enum Nitro {
    case on, off
}
enum Pnevmo {
    case hard, middle, low
}

protocol Car {                                                      // ПРОТОКОЛ ОБЩИХ СВОЙСТВ
    var model: String { get }
    var color: UIColor { get }
    var mp3: Bool { get }
    var transmission: Transmission { get }
    var trunkVolume: Double { get }
    var luggage: Double { get set }
    var year: Int { get set }
    var km: Double { get set }
    var doorState: CarDoorState { get set }
    var windowsState: WindowsState { get set }
    var engineStat: EngineOnOff { get set }
    var owner: String { get set }
    func freeSpace() -> Double
}

                                                                    // ПРОТОКОЛ СПОРТИВНОГО АВТОМОБИЛЯ
protocol SportCar {
    var nitro: Nitro { get set }
    var pnevmo: Pnevmo { get set } // жесткость пневмоподвески
    var safetyCage: Bool { get } // каркас безопасности
    var accelerationTo100: Double {get} // разгон до 100
}

protocol SimpleTruckCar {                                            // ПРОТОКОЛ СВОЙСТВ ГРУЗОВИКА
    var reducedGear: Bool { get } // есть ли пониженная передача
    var suspensionState: CarSuspension { get }
    var tipper: Bool { get } // самосвал или нет
}

protocol TruсkCraneCar {                                            // ПРОТОКОЛ СВОЙСТВ ГРУЗОВИКА С КРАНОМ
    var craneLength: Int { get } // наличие крана
    var closeOpenTruсk: KindOfTruck { get } // тип кузова: открытый багажник или контейнер
    var craneState: CraneState { get set }
    func raiseCrane()
    func removeCrane()
}

protocol Filling { // Наполенине багажника
    func putToLuggage(kg: Double)
}

protocol ConsolePrintable: CustomStringConvertible {
    func printDescription()
}

protocol Unloading {
    func unloading()
}

extension Car { // тут мне надо указать, что, если положили в багажник больше нужного объема - свободное пространство не отрицательное, а просто 0
    func freeSpace() -> Double {
        var intermediate = trunkVolume - luggage
        if intermediate < 0 {
            intermediate = 0
        } else {
            intermediate = trunkVolume - luggage
        }
        return intermediate
    }
    mutating func unloading() {
        luggage = 0
    }
    mutating func openWindows() {
        windowsState = .open
        print("Windows are opened" + "\n")
    }
    mutating func closeWindows() {
        windowsState = .close
        print("Windows are closed" + "\n")
    }
}

extension TruсkCraneCar {
   mutating func raiseCrane() {
        craneState = .raised
    }
    mutating func removeCrane() {
        craneState = .removed
    }
}

extension ConsolePrintable {
    func printDescription() {
        print(description)
    }
}

class TruсkCar: Car, SimpleTruckCar {
    // without crane
    var suspensionState: CarSuspension
    var closeOpenTruсk: KindOfTruck
    var reducedGear: Bool
    var tipper: Bool
    let model: String
    let color: UIColor
    let mp3: Bool
    let transmission: Transmission
    let trunkVolume: Double
    var luggage: Double
    var year: Int
    var km: Double
    var doorState: CarDoorState
    var windowsState: WindowsState
    var engineStat: EngineOnOff
    var owner: String = "" {
        willSet {
            print("Previous owner: \(owner)")
        }
        didSet {
            print("New owner: \(owner)" + "\n")
        }
    }
    
    init (model: String, year: Int, color: UIColor, mp3: Bool, transmission: Transmission, engineStat: EngineOnOff, closeOpenTruсk: KindOfTruck, reducedGear: Bool, tipper: Bool, suspensionState: CarSuspension, km: Double, doorState: CarDoorState, windowsState: WindowsState, trunkVolume: Double, luggage: Double, owner: String) {
        self.model = model
        self.year = year
        self.color = color
        self.mp3 = mp3
        self.transmission = transmission
        self.engineStat = engineStat
        self.km = km
        self.doorState = doorState
        self.trunkVolume = trunkVolume
        self.windowsState = windowsState
        self.luggage = luggage
        self.closeOpenTruсk = closeOpenTruсk
        self.reducedGear = reducedGear
        self.tipper = tipper
        self.suspensionState = suspensionState
        self.owner = owner
    }
}

class simpleSportCar: Car, SportCar {
    var model: String
    var color: UIColor
    var mp3: Bool
    var transmission: Transmission
    var trunkVolume: Double
    var luggage: Double
    var year: Int
    var km: Double
    var doorState: CarDoorState
    var windowsState: WindowsState
    var engineStat: EngineOnOff
    var owner: String
    var nitro: Nitro
    var pnevmo: Pnevmo
    var safetyCage: Bool
    var accelerationTo100: Double
    init (model: String, year: Int, color: UIColor, mp3: Bool, transmission: Transmission, engineStat: EngineOnOff, nitro: Nitro, pnevmo: Pnevmo, safetyCage: Bool, accelerationTo100: Double,  km: Double, doorState: CarDoorState, windowsState: WindowsState, trunkVolume: Double, luggage: Double, owner: String) {
        self.model = model
        self.year = year
        self.color = color
        self.mp3 = mp3
        self.transmission = transmission
        self.engineStat = engineStat
        self.km = km
        self.doorState = doorState
        self.trunkVolume = trunkVolume
        self.windowsState = windowsState
        self.luggage = luggage
        self.owner = owner
        self.accelerationTo100 = accelerationTo100
        self.nitro = nitro
        self.safetyCage = safetyCage
        self.pnevmo = pnevmo
    }
}

extension TruсkCar: Filling {
    func putToLuggage(kg: Double) {
        if kg <= trunkVolume {
            luggage = kg
        } else if (kg > trunkVolume) && (kg < (trunkVolume + 200)) {
            luggage = kg
            print("Едь помедленнее, у нас перевес на \(luggage - trunkVolume) килограмм" + "\n")
        } else {
            print("Не стоит ехать, коробку спалим - перевес сильно большой" + "\n")
        }
    }
}

extension TruсkCar: ConsolePrintable {
    var description: String {
        return String(describing: "Модель автомобиля: \(model), год выпуска: \(year), пробег: \(km) км, вместимость кузова: \(trunkVolume) кг, свободного места в кузове: \(freeSpace()) кг.")
    }
}

extension simpleSportCar: Filling {
    func putToLuggage(kg: Double) {
        if kg <= trunkVolume {
            luggage = kg
        } else {
            print("Много положид - дрифтить не сможем" + "\n")
        }
    }
}

extension simpleSportCar: ConsolePrintable {
    var description: String {
        return String(describing: "Модель автомобиля: \(model), Год выпуска: \(year), пробег: \(km) км, Разгон до 100: \(accelerationTo100), Жесткость пневмоподвески: \(pnevmo)")
    }
}

class TruckCarCrane: Car, SimpleTruckCar, TruсkCraneCar {
    var craneLength: Int
    var craneState: CraneState
    var suspensionState: CarSuspension
    var closeOpenTruсk: KindOfTruck
    var reducedGear: Bool
    var tipper: Bool
    let model: String
    let color: UIColor
    let mp3: Bool
    let transmission: Transmission
    let trunkVolume: Double
    var luggage: Double
    var year: Int
    var km: Double
    var doorState: CarDoorState
    var windowsState: WindowsState
    var engineStat: EngineOnOff
    var owner: String = "" {
        willSet {
            print("Previous owner: \(owner)")
        }
        didSet {
            print("New owner: \(owner)" + "\n")
        }
    }
    
    init (model: String, year: Int, color: UIColor, mp3: Bool, transmission: Transmission, engineStat: EngineOnOff, closeOpenTruсk: KindOfTruck, reducedGear: Bool, tipper: Bool, suspensionState: CarSuspension, craneLength: Int, craneState: CraneState, km: Double, doorState: CarDoorState, windowsState: WindowsState, trunkVolume: Double, luggage: Double, owner: String) {
        self.model = model
        self.year = year
        self.color = color
        self.mp3 = mp3
        self.transmission = transmission
        self.engineStat = engineStat
        self.km = km
        self.doorState = doorState
        self.trunkVolume = trunkVolume
        self.windowsState = windowsState
        self.luggage = luggage
        self.closeOpenTruсk = closeOpenTruсk
        self.reducedGear = reducedGear
        self.tipper = tipper
        self.suspensionState = suspensionState
        self.owner = owner
        self.craneLength = craneLength
        self.craneState = craneState
    }
    func raiseCrane() {
        craneState = .raised
        print("Кран поднят")
    }
    func removeCrane() {
        craneState = .removed
        print("Кран убран")
    }
} 

extension TruckCarCrane: Filling {
    func putToLuggage(kg: Double) {
        if kg <= trunkVolume {
            luggage = kg
        } else if (kg > trunkVolume) && (kg < (trunkVolume + 200)) {
            luggage = kg
            print("Едь помедленнее, у нас перевес на \(luggage - trunkVolume) килограмм" + "\n")
        } else {
            print("Не стоит ехать, коробку спалим - перевес сильно большой" + "\n")
        }
    }
}
extension TruckCarCrane: Unloading {
    func unloading() {
        luggage = 0
        print("Разгрузка завершена, кузов пуст")
    }
}

var truckCar1 = TruсkCar(model: "Bongo", year: 2000, color: .white, mp3: false, transmission: .manual, engineStat: .off, closeOpenTruсk: .container, reducedGear: true, tipper: false, suspensionState: .ressory, km: 100000, doorState: .open, windowsState: .close, trunkVolume: 3500, luggage: 3000, owner: "Max")

truckCar1.openWindows() // закроем окна

print("=================================================================\n")

truckCar1.putToLuggage(kg: 5000) // попробуем положить в кузов больше вместимости

print("=================================================================\n")

truckCar1.owner = "Gleb"


print("=================================================================\n")

print(truckCar1.description) // распечатаем через стандартный протокол


let sportCar1 = simpleSportCar(model: "NissanGTR", year: 2018, color: .black, mp3: false, transmission: .manual, engineStat: .off, nitro: .off, pnevmo: .hard, safetyCage: true, accelerationTo100: 3.2, km: 10000, doorState: .close, windowsState: .close, trunkVolume: 50, luggage: 0, owner: "Max")



// До конца не успел со всеми машинами поиграть. Но общий смысл понял. ДЗ немного переосмыслил. Сделал конструкторы из нескольких протоколов и ими расширял классы.
// На уроке меня не будет - работа. 












