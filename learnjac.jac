def sayHello() -> str {
    return ("Jac is a good progaramming language");
}

with entry{
    print(f" {sayHello()}");
}

with entry{
    nathan="Rufus";
    print(f"Hello {nathan}");

}

# type annotations
with entry{
    name: str = "Nathan";
    age: int = 20;
    height: float = 5.9;
    is_student: bool = true;
    print(f"My name is {name}, I am {age} years old, my height is {height} feet, and it is {is_student} that I am a student.");
}

# calculate area of a rectangle
def areOfRectangle(length:float ,width:float) -> float{
    return length * width;
}

with entry{
    length:float = 5.0;
    width:float = 3.0;
    area:float = areOfRectangle(length, width);
    print(f"The area of the rectangle is {area}");
}