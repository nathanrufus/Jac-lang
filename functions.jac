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