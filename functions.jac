def conversion(value:float) ->float{
    return value / 0.4535924;
}
with entry{
    result:float=conversion(55);
    print(f"My weight in pounds is : {result}");
}

# looping through lists
with entry{
    numbers:list[int] = [1, 2, 3, 4, 5];
    sum:int = 0;
    for num in numbers {
        sum += num;
    }
    print(f"The sum of the list is: {sum}");
}

# dictionaries
with entry{
    capitals:dict[str, int] = { "nathan":25, "alice":30, "bob":22 };
    oldest:str = "";
    max_age:int = 0;
    for (name, age) in capitals.items() {
        if age > max_age {
            max_age = age;
            oldest = name;
        }
    }
    print(f"The oldest person is {oldest} with age {max_age}");
}

with entry{
    # enum-like pattern using a dict (portable if language lacks native enum)
    Colors:dict[str, int] = { "RED": 0, "GREEN": 1, "BLUE": 2 };

    def color_name(val:int) -> str {
        for (k, v) in Colors.items() {
            if v == val {
                return k;
            }
        }
        return "UNKNOWN";
    }

    def paint(color:int) {
        if color == Colors["RED"] {
            print("Painting red");
        } elif color == Colors["GREEN"] {
            print("Painting green");
        } else {
            print("Painting blue/other");
        }
    }

    # usage
    current:int = Colors["GREEN"];
    print(f"Current color numeric value: {current}");
    if current == Colors["GREEN"] {
        print("It's green!");
    }
    print(f"Name from value: {color_name(current)}");

    paint(current);
}