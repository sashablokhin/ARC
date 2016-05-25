//
//  main.swift
//  ARC
//
//  Created by Alexander Blokhin on 25.05.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import Foundation

var playground = true

/*
class Student {
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    deinit {
        print("goodbye teacher")
    }
}

var anotherTeacher: Teacher? // зона видимости до конца программы

if playground {
    
    var student = Student() // число ссылок на объект = 1
    var teacher = Teacher() // число ссылок на объект = 1
    
    anotherTeacher = teacher // число ссылок на объект Teacher = 2
    
    print("exit playground")
}

// выход из зоны видимости число ссылок на объект Student = 0, Teacher = 1 (не отрелизится)

print("end")
*/

/*
class Student {
    
    var teacher: Teacher?
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    var student: Student?
    
    deinit {
        print("goodbye teacher")
    }
}


if playground {
    
    var student = Student() // число ссылок на объект Student = 1
    var teacher = Teacher() // число ссылок на объект Teacher = 1
    
    teacher.student = student // число ссылок на объект Student = 2
    
    print("exit playground")
}

// выход из зоны видимости число ссылок на объект Student = 1, Teacher = 0, так как Teacher релизится то сильная ссылка на объект становится Student = 0 

// Объект будет жить пока на него есть хотя бы одна сильная ссылка

print("end")
*/

/*
class Student {
    var teacher: Teacher?
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    var student: Student?
    
    deinit {
        print("goodbye teacher")
    }
}


if playground {
    
    var teacher = Teacher() // число ссылок на объект Teacher = 1
    
    if playground {
        var student = Student() // число ссылок на объект Student = 1
    
        teacher.student = student // число ссылок на объект Student = 2
        student.teacher = teacher // число ссылок на объект Teacher = 2
    }
    
    // выход из зоны видимости Student = 1, Teacher = 2
    
    print("exit playground")
}

// выход из зоны видимости Teacher = 1, Student = 1 утечка памяти

print("end")
*/

/*
class Student {
    weak var teacher: Teacher? // weak всегда var и optional так как при релизе это свойство станет nil
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    var student: Student?
    
    deinit {
        print("goodbye teacher")
    }
}


if playground {
    
    var teacher = Teacher() // число ссылок на объект Teacher = 1
    
    if playground {
        var student = Student() // число ссылок на объект Student = 1
        
        teacher.student = student // число ссылок на объект Student = 2
        student.teacher = teacher // число ссылок на объект Teacher = 1,  т.к weak не увеличивает кол-во ссылок
    }
    
    // выход из зоны видимости Student = 1, Teacher = 1
    
    print("exit playground")
}

// выход из зоны видимости Teacher = 0, Student релизится

print("end")
*/

/*
class Student {
    unowned let teacher: Teacher // если Teacher не может быть nil то вместо weak используется unowned
    
    init(teacher: Teacher) {
        self.teacher = teacher
    }
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    var student: Student?
    
    deinit {
        print("goodbye teacher")
    }
}


if playground {
    
    var teacher = Teacher() // число ссылок на объект Teacher = 1
    
    if playground {
        var student = Student(teacher: teacher) // число ссылок на объект Student = 1, Teacher = 1 - т.к. unowned не увеличивает кол-во ссылок
        
        teacher.student = student // число ссылок на объект Student = 2
    }
    
    // выход из зоны видимости Student = 1, Teacher = 1
    
    print("exit playground")
}

// выход из зоны видимости Teacher = 0, Student релизится

print("end")
*/

/*
class Student {
    unowned let teacher: Teacher // если Teacher не может быть nil то вместо weak используется unowned
    
    init(teacher: Teacher) {
        self.teacher = teacher
    }
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    var student: Student!
    
    init() {
        // первую фазу инициализации student проходит как nil за счет указания !, иначе мы не сможем использовать self
        self.student = Student(teacher: self)
    }
    
    deinit {
        print("goodbye teacher")
    }
}


if playground {
    
    var teacher = Teacher() // число ссылок на объект Teacher = 1
    
    
    print("exit playground")
}

print("end")
*/

//================================================================

/*
var x = 10
var y = 20

var closure: () -> () = {
    print("\(x) \(y)") // захват ссылок value type
}

closure()

x = 30
y = 40

closure()
*/

/*
var x = 10
var y = 20

var closure: () -> () = { [x, y] in // capture list
    print("\(x) \(y)") // захват значений value type
}

closure()

x = 30
y = 40

closure()
*/

/*
var x = 10
var y = 20

var closure2: (Int) -> Int = { (a: Int) -> Int in
    print("\(x) \(y)") // захват ссылок value type
    return a
}

closure2(1)

x = 30
y = 40

closure2(1)
*/

/*
var x = 10
var y = 20

var closure2: (Int) -> Int = {[x, y] (a: Int) -> Int in
    print("\(x) \(y)") // захват значений value type
    return a
}

closure2(1)

x = 30
y = 40

closure2(1)
*/

/*
var x = 10
var y = 20

class Human {
    var name = "a"
}

var h = Human()

var closure2: (Int) -> Int = {[x, y, h] (a: Int) -> Int in
    print("\(x) \(y) \(h.name)") // захват значений value type
    return a
}

closure2(1)

x = 30
y = 40
h = Human()
h.name = "b"

closure2(1)
*/


// Все что передается в клоужер - захватывается

/*
class Student {
    unowned let teacher: Teacher // если Teacher не может быть nil то вместо weak используется unowned
    
    init(teacher: Teacher) {
        self.teacher = teacher
    }
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    var student: Student!
    
    init() {
        // первую фазу инициализации student проходит как nil за счет указания !, иначе мы не сможем использовать self
        self.student = Student(teacher: self)
    }
    
    deinit {
        print("goodbye teacher")
    }
}


var closure: (() -> ())?


if playground {
    
    var teacher = Teacher() // число ссылок на объект Teacher = 1
    
    closure = {
        //print(teacher) // захват объекта teacher сильной ссылкой, не отрелизится
    }
    
    closure = {
        [unowned teacher] in // не захватываем объект сильной ссылкой
        print(teacher)
    }
    
    print("exit playground")
}

print("end")
*/

/*
class Student {
    unowned let teacher: Teacher // если Teacher не может быть nil то вместо weak используется unowned
    
    init(teacher: Teacher) {
        self.teacher = teacher
    }
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    var student: Student!
    
    var test: (() -> ())?
    
    init() {
        self.student = Student(teacher: self)
    }
    
    deinit {
        print("goodbye teacher")
    }
}

if playground {
    
    var teacher = Teacher() // число ссылок на объект Teacher = 1
    
    teacher.test = {
        //print(teacher) // захват объекта teacher сильной ссылкой, не отрелизится
    }
    
    
    teacher.test = {
        [unowned teacher] in // не захватываем объект сильной ссылкой
        print(teacher)
    }
    
    print("exit playground")
}

print("end")
*/

/*
class Student {
    unowned let teacher: Teacher // если Teacher не может быть nil то вместо weak используется unowned
    
    init(teacher: Teacher) {
        self.teacher = teacher
    }
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    var student: Student!
    
    var test: (() -> ())?
    
    lazy var test2: (Bool) -> () = { [unowned self] (a: Bool) in // lazy - могут быть проинициализированы только после инициализации при первом обращении
        print(self) // self не захвачен пока не вызван lazy closure
    } // по умолчанию стоит в nil
    
    init() {
        self.student = Student(teacher: self)
    }
    
    deinit {
        print("goodbye teacher")
    }
}

if playground {
    
    var teacher = Teacher() // число ссылок на объект Teacher = 1
    
    teacher.test2(true) // не отрилизится так как self захвачен в test2, поэтому ставим unowned
    
    print("exit playground")
}

print("end")
*/

/*
    Итоги:
    
    1. Если два объекта ссылаются друг на друга, то главный объект должен держать подчиненных сильной ссылкой, а подчиненные ссылаются на главный объект по слабой ссылке. weak для опциональных и unowned для тех, что не могут быть nil
    2. Клоужеры захватывают все передаваемые объекты сильной ссылкой
    3. Массив и дикшинари держит объекты сильной ссылкой
*/

// Домашнее задание: папа - глава, мама - контролирует детей, дети - вызывают друг друга, могут спрашивать маму, папу. Все лежит в классе семья с методом печатать семью. у папы 3 клоужера, обращается к семье и просит распечатть семью, второй клоужер распечатай маму, 3 - распечатай всех детей. При выходе из зоны видимости все уничтожается


class Human {
    var name = ""
    
    func sayHello(from: Human) {
        print("Привет \(name) от \(from.name)!")
    }
    
    deinit {
        print("\(name) ушел")
    }
}

class Children {
    var kids: [Human]
    
    init(kids: [Human]) {
        self.kids = kids
    }
}


class Father: Human {
    var wife: Human?
    var children: Children?
    
    var familyClosure: (() -> ())?
    
    override init() {
        super.init()
        self.name = "Папа"
    }
}

class Mother: Human {
    weak var husband: Human?
    var children: Children?
    
    override init() {
        super.init()
        self.name = "Мама"
    }
}

class Child: Human {
    weak var father: Human?
    weak var mother: Human?
    weak var sibling: Children?
    
    init(name: String) {
        super.init()
        self.name = name
    }
    
    func printSibling() {
        for sib in sibling!.kids {
            print(sib.name)
        }
    }
}

class Family {
    var father: Human?
    var mother: Human?
    var children: Children?
    
    func printFamily() {
        print("\(father!.name)")
        printMother()
        printChildren()
    }
    
    func printMother() {
        print("\(mother!.name)")
    }
    
    func printChildren() {
        for child in children!.kids {
            print(child.name)
        }
    }
    
    deinit {
        print("Семья ушла")
    }
}


if playground {
    let family = Family() // Family = 1
    
    let father = Father() // Father = 1
    let mother = Mother() // Mother = 1
    
    let children = Children(kids: [Child(name: "Ребенок 1"), Child(name: "Ребенок 2")]) // Child 1, 1
    
    family.father = father // Father = 2
    family.mother = mother // Mother = 2
    family.children = children // children = 2
    
    father.wife = mother // Mother = 3
    father.children = children // children = 3
    
    mother.husband = father // Father = 3
    mother.children = children // children = 4
    
    for child in children.kids {
        if let kid = child as? Child {
            kid.father = father // Father = 5
            kid.mother = mother // Mother = 5
            kid.sibling = children // children = 5
        }
    }
    
    // - say hello
    
    father.wife?.sayHello(father)
    mother.husband?.sayHello(mother)
    
    for child in father.children!.kids {
        if let kid = child as? Child {
            kid.sayHello(father)
            kid.sayHello(mother)
            kid.mother?.sayHello(kid)
            kid.father?.sayHello(kid)
            
            for sibling in kid.sibling!.kids {
                if let sib = sibling as? Child {
                    if sib.name != kid.name {
                        sib.sayHello(kid)
                    }
                }
            }
        }
    }
    
    father.familyClosure = { [unowned family] in
        family.printFamily()
    }
    
    father.familyClosure!()
}

























