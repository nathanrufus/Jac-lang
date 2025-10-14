class displayName {
    has name:str;
    has age:int;
    has height:float;

    def displayInfo{
        print(f"My name is {self.name}, I am {self.age} years old, my height is {self.height} feet");
    }
}
with entry{
    person = displayName();
    person.name = "Nathan";
    person.age = 20;
    person.height = 5.9;
    person.displayInfo();
}