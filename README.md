# Graduator

Graduator is an iOS application developed with SwiftUI that helps users manage their academic `units`, `subjects`, and grades. Users can add and delete `subjects`, edit the weight and name of `subjects` and `units`, and input grades. The app displays weighted averages and explains the conditions for graduating from the Clermont Auvergne Tech Institute's mobile development BSc in 2023.

<img src="./docs/home.png" height="700" style="margin:20px" alt="view from the home page">
<img src="./docs/unit.png" height="700" style="margin:20px" alt="view from a unit page">
  
## Features

Beyond those basic features, some details need to be specified here.

### Persistence

The data is set to be persisted, unless you're using XCode's previewer canvas. 

The local persistence solution has been tested manually on the iOS Simulator.

Upon first launching the app, it is set up to load a stub.

### Weighted average

A weighted average means that a `subject` or `unit`'s weight plays a part in calculating the average. Users can observe that increasing the weight of a `subject`, for instance, will make the average of the parent `unit` tend more towards that `subject`'s grade.

<img src="./docs/weight_1.png" height="700" style="margin:20px" alt="before changing a subject's weight">
<img src="./docs/weight_2.png" height="700" style="margin:20px" alt="after changing a subject's weight">

### Deleting a `Subject`

In the app, users can delete a `subject` by swiping it off the list, right-to-left.

<img src="./docs/delete_1.png" height="700" style="margin:20px" alt="deleting a subject">
<img src="./docs/delete_2.png" height="700" style="margin:20px" alt="subject deleted">

Note that when a `subject` is deleted, it is permanently removed from the system. If a user is in the process of editing and deletes a `subject`, the deletion occurs immediately upon swiping, not when they save (click 'OK'). If the user chooses to cancel their edits (click *'Annuler'*), all other unsaved changes will be discarded, but the deletion of the `subject` remains.

### Changing a grade

Before a user changes a grade, they first need to activate the `lock.open` toggle.

<img src="./docs/grade_1.png" height="700" style="margin:20px" alt="changing a grade">

After a grade was changed, in order to save the change and to see it reflected in the `unit`'s weighted average, users need to use the (`lock.open` previously) `checkmark` toggle.

<img src="./docs/grade_2.png" height="700" style="margin:20px" alt="grade changed">

### Creating a `Subject`

Finally, users can create  a `subject` when in edit mode. After clicking on *'Modifier'*, look for a `+` in the top navigation bar.

<img src="./docs/delete_2.png" height="700" style="margin:20px" alt="subject deleted">
<img src="./docs/create_1.png" height="700" style="margin:20px" alt="creating a subject">
<img src="./docs/create_2.png" height="700" style="margin:20px" alt="subject created">
 

## Architecture

Graduator is based on the MVVM (Model-View-ViewModel) architectural pattern. The below UML class diagram details
the structure of the models, viewmodels, and views for `UnitsManager`, `Unit`, and `Subject`. Notice how,
to circumvent [this issue](https://codefirst.iut.uca.fr/documentation/mchSamples_Apple/docusaurus/iOS_MVVM_guide/docs/viewModels/changeNotifications/problematic/),
we insert an entire hierarchy of VMs in certain views, so that they can update all those VMs when a detail gets edited. It's dirty, and it's staying that way for the foreseeable future.

```mermaid
classDiagram

    class MainView
    class UnitView
    class SubjectViewCell

    class UnitsManagerVM {
        -original: UnitsManager
        +model: UnitsManager.Data
        +isEdited: Bool
        +isAllEditable: Bool
        +updateUnit(unitVM: UnitVM): Void
        +TotalAverage: Double?
        +ProfessionalAverage: Double?
    }
    class UnitVM {
        -original: Unit
        +model: Unit.Data
        +isEdited: Bool
        +onEditing()
        +onEdited(isCancelled: Bool)
        +updateSubject(subjectVM: SubjectVM)
        +updateAllSubjects()
        +deleteSubject(subjectVM: SubjectVM)
        +addSubject(subject: Subject)
        +Average: Double?
    }
    class SubjectVM {
        -original: Subject
        +model: Subject.Data
        +isEdited: Bool
        +onEditing(): Void
        +onEdited(isCancelled: Bool): Void
    }
    
    class UnitsManager {
        +getTotalAverage(): Double?
        +getProfessionalAverage(): Double?
        +getAverage(units: Unit[]): Double?
        +data: Data
        +update(from: Data): Void
    }
    class Unit {
        +name: String
        +weight: Int
        +isProfessional: Bool
        +code: Int
        +subjects: Subject[]
        +getAverage(): Double?
        +data: Data
        +update(from: Data): Void
    }
    class Subject {
        +name: String
        +weight: Int
        +grade: Double?
        +gradeIsValid(grade: Double?): Bool
        +data: Data
        +update(from: Data): Void
    }

    MainView --> UnitsManagerVM
    UnitView --> UnitVM
    UnitView --> UnitsManagerVM
    SubjectViewCell --> SubjectVM
    SubjectViewCell --> UnitVM
    SubjectViewCell --> UnitsManagerVM

    UnitsManagerVM --> "*" UnitVM
    UnitsManagerVM --> UnitsManager
    UnitVM --> "*" SubjectVM
    UnitVM --> Unit
    SubjectVM --> Subject
```



It might be useful to note that, just like `UnitVM`s aggregate `SubjectVM`s, `Unit`s aggregate
`Subject`s, but these relationship between `Model` entities were removed from the diagram above for clarity.
The same is true with the `View`-related classes.

Here is the diagram with those relationships depicted, and the local persistence solution added.




```mermaid
classDiagram

    class MainView
    class UnitView
    class SubjectViewCell

    class UnitsManagerVM {
        -original: UnitsManager
        +load()
        +model: UnitsManager.Data
        +isEdited: Bool
        +isAllEditable: Bool
        +updateUnit(unitVM: UnitVM)
        +TotalAverage: Double?
        +ProfessionalAverage: Double?
    }
    class UnitVM {
        -original: Unit
        +model: Unit.Data
        +isEdited: Bool
        +onEditing()
        +onEdited(isCancelled: Bool)
        +updateSubject(subjectVM: SubjectVM)
        +updateAllSubjects()
        +deleteSubject(subjectVM: SubjectVM)
        +addSubject(subject: Subject)
        +Average: Double?
    }
    class SubjectVM {
        -original: Subject
        +model: Subject.Data
        +isEdited: Bool
        +onEditing()
        +onEdited(isCancelled: Bool)
    }


    class UnitsManager {
        -store: UnitsStore
        +save()
        +load()
        +getTotalAverage(): Double?
        +getProfessionalAverage(): Double?
        +getAverage(units: Unit[]): Double?
        +data: Data
        +update(from: Data)
    }
    class Unit {
        +name: String
        +weight: Int
        +isProfessional: Bool
        +code: Int
        +getAverage(): Double?
        +data: Data
        +update(from: Data)
    }
    class Subject {
        +name: String
        +weight: Int
        +grade: Double?
        +gradeIsValid(grade: Double?): Bool
        +data: Data
        +update(from: Data)
    }
    
    class UnitsStore {
        +load<T: Codable>(defaultValue: T[])
        +save<T: Codable>(elements: T[])
    }

    MainView --> "*" UnitView
    MainView --> UnitsManagerVM
    UnitView --> "*" SubjectViewCell
    UnitView --> UnitVM
    UnitView --> UnitsManagerVM
    SubjectViewCell --> SubjectVM
    SubjectViewCell --> UnitVM
    SubjectViewCell --> UnitsManagerVM

    UnitsManagerVM --> "*" UnitVM
    UnitsManagerVM --> UnitsManager
    UnitVM --> "*" SubjectVM
    UnitVM --> Unit
    SubjectVM --> Subject

    UnitsManager --> "*" Unit
    UnitsManager --> UnitsStore
    UnitsManager --> Stub
    Stub --> "*" Unit
    Unit --> "*" Subject
```
