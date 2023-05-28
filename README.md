# Graduator

Graduator is an iOS application developed with SwiftUI that helps users manage their academic `units`, `subjects`, and grades. Users can add and delete `subjects`, edit the weight and name of `subjects` and `units`, and input grades. The app displays weighted averages and explains the conditions for graduating from the Clermont Auvergne Tech Institute's mobile development BSc in 2023.

<img src="./docs/home.png" height="700" style="margin:20px" alt="view from the home page">
<img src="./docs/unit.png" height="700" style="margin:20px" alt="view from a unit page">
  
## Features

Beyond those basic features, some details need to be specified here.

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

<img src="./docs/create_1.png" height="700" style="margin:20px" alt="creating a subject">
<img src="./docs/create_2.png" height="700" style="margin:20px" alt="subject created">
 

## Architecture

Graduator is based on the MVVM (Model-View-ViewModel) architectural pattern. The below UML class diagram details the structure of the models, viewmodels, and views for `UnitsManager`, `Unit`, and `Subject`.

```mermaid
classDiagram
    class Unit {
        +name: String
        +weight: Int
        +isProfessional: Bool
        +code: Int
        +subjects: [Subject]
        +getAverage(): Double?
        +data: Data
        +update(from: Data): Void
    }

    class UnitVM {
        -original: Unit
        +model: Unit.Data
        +isEdited: Bool
        +SubjectsVM: [SubjectVM]
        +onEditing(): Void
        +onEdited(isCancelled: Bool): Void
        +updateSubject(subjectVM: SubjectVM): Void
        +updateAllSubjects(): Void
        +deleteSubject(subjectVM: SubjectVM): Void
        +addSubject(subject: Subject): Void
        +Average: Double?
    }

    class UnitView {
        -unitVM: UnitVM
        -unitsManagerVM: UnitsManagerVM
        +delete(at: IndexSet): Void
    }

    class Subject {
        +name: String
        +weight: Int
        +grade: Double?
        +gradeIsValid(grade: Double?): Bool
        +data: Data
        +update(from: Data): Void
    }

    class SubjectVM {
        -original: Subject
        +model: Subject.Data
        +isEdited: Bool
        +onEditing(): Void
        +onEdited(isCancelled: Bool): Void
    }

    class SubjectViewCell {
        -subjectVM: SubjectVM
        -unitVM: UnitVM
        -unitsManagerVM: UnitsManagerVM
        -isGradeEditable: Bool
    }

    class UnitsManager {
        +units: [Unit]
        +getTotalAverage(): Double?
        +getProfessionalAverage(): Double?
        +getAverage(units: [Unit]): Double?
        +data: Data
        +update(from: Data): Void
    }

    class UnitsManagerVM {
        -original: UnitsManager
        +model: UnitsManager.Data
        +isEdited: Bool
        +isAllEditable: Bool
        +UnitsVM: [UnitVM]
        +updateUnit(unitVM: UnitVM): Void
        +TotalAverage: Double?
        +ProfessionalAverage: Double?
    }

    class MainView {
        -unitsManagerVM: UnitsManagerVM
    }

    UnitVM -- Unit : Uses
    UnitView -- UnitVM : Observes
    SubjectVM -- Subject : Uses
    SubjectViewCell -- SubjectVM : Observes
    UnitVM "1" o-- "*" SubjectVM : Contains
    UnitsManagerVM -- UnitsManager : Uses
    UnitsManagerVM "1" o-- "*" UnitVM : Contains
    MainView -- UnitsManagerVM : Observes
```



It might be useful to note that, just like `UnitVM`s aggregate `SubjectVM`s, `Unit`s aggregate `Subject`s, but these relationship between `Model` entities were removed from the diagram above for clarity. 

Here is the diagram with those relationships depicted.




```mermaid
classDiagram
    class Unit {
        +name: String
        +weight: Int
        +isProfessional: Bool
        +code: Int
        +subjects: [Subject]
        +getAverage(): Double?
        +data: Data
        +update(from: Data): Void
    }

    class UnitVM {
        -original: Unit
        +model: Unit.Data
        +isEdited: Bool
        +SubjectsVM: [SubjectVM]
        +onEditing(): Void
        +onEdited(isCancelled: Bool): Void
        +updateSubject(subjectVM: SubjectVM): Void
        +updateAllSubjects(): Void
        +deleteSubject(subjectVM: SubjectVM): Void
        +addSubject(subject: Subject): Void
        +Average: Double?
    }

    class UnitView {
        -unitVM: UnitVM
        -unitsManagerVM: UnitsManagerVM
        +delete(at: IndexSet): Void
    }

    class Subject {
        +name: String
        +weight: Int
        +grade: Double?
        +gradeIsValid(grade: Double?): Bool
        +data: Data
        +update(from: Data): Void
    }

    class SubjectVM {
        -original: Subject
        +model: Subject.Data
        +isEdited: Bool
        +onEditing(): Void
        +onEdited(isCancelled: Bool): Void
    }

    class SubjectViewCell {
        -subjectVM: SubjectVM
        -unitVM: UnitVM
        -unitsManagerVM: UnitsManagerVM
        -isGradeEditable: Bool
    }

    class UnitsManager {
        +units: [Unit]
        +getTotalAverage(): Double?
        +getProfessionalAverage(): Double?
        +getAverage(units: [Unit]): Double?
        +data: Data
        +update(from: Data): Void
    }

    class UnitsManagerVM {
        -original: UnitsManager
        +model: UnitsManager.Data
        +isEdited: Bool
        +isAllEditable: Bool
        +UnitsVM: [UnitVM]
        +updateUnit(unitVM: UnitVM): Void
        +TotalAverage: Double?
        +ProfessionalAverage: Double?
    }

    class MainView {
        -unitsManagerVM: UnitsManagerVM
    }

    UnitVM -- Unit : Uses
    UnitView -- UnitVM : Observes
    SubjectVM -- Subject : Uses
    SubjectViewCell -- SubjectVM : Observes
    UnitVM "1" o-- "*" SubjectVM : Contains
    Unit "1" o-- "*" Subject : Contains
    UnitsManagerVM -- UnitsManager : Uses
    UnitsManagerVM "1" o-- "*" UnitVM : Contains
    UnitsManager "1" o-- "*" Unit : Contains
    MainView -- UnitsManagerVM : Observes
```
