enum GoalType {
    case Meal_plan
    case Intuitive_eating
    case Exercise
    case Not_exercise
    case Custom
    
    
   static func getType(var count: Int) -> String{
        if (count == 0){
            return "Meal Plan"
        }
        if (count == 1){
            return "Intuitive eating"
        }
        else if (count == 2){
            return "Exercise"
        } else if (count == 3){
            return "Not exercise"
        }
        else {
            return "Custom"
        }
    }
}