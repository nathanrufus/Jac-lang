# example of a implementation in jac
obj nathan{
    has name:str;
    has age:int;
    has friends:list=[];

    def add_friend() -> str;
}
with entry{
    nathanname = nathan(name="Nathan", age=30);
    print(f"Person Name: {nathanname.name}, Age: {nathanname.age}");
    
    nathanname.add_friend();
    print(f"{nathanname.name}'s friends: {nathanname.friends}");
}