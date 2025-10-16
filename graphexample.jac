# node Student {
#     has name:str;
#     has subject:str;
# }
# node Teacher {
#     has name:str;
#     has teaching_subject:str;
# }
# edge subject{
#     has level:int;
#     has score:int;
# }

# walker numberOfStudents{
#     has total:int=0;

#     can start with `root entry{
#         visit [-->];
#     }
#     can count with Student entry{
#         self.total = self.total + 1;
#         visit [-->];    
#     }
# }

# with entry{
#     nathan=Student(name="Nathan",subject="Math");
#     emily=Student(name="Emily",subject="Science");
#     mr_smith=Teacher(name="Mr. Smith",teaching_subject="Math");

#     root ++> nathan;
#     root ++> emily;
#     root ++> mr_smith;

#     nathan +>:subject(level=101,score=95):+> mr_smith;
#     emily +>:subject(level=101,score=88):+> mr_smith;
    

#     totalnumber = root spawn numberOfStudents();
#     print(f"Total number of students: {totalnumber.total}");
# }

node Person {
    has name:str;
    has age:int;
}

node House {
    has name:str;
    has residents:list;
}

edge lives_in{}
edge road {
    has distance:int;
}

walker visitVillage {
    has visited_count:int = 0;

    can start with root entry {
        report "Starting village visit...";
        visit [-->];
    }

    can visit with House entry {
        self.visited_count += 1;
        report f"🏠 Visiting {here.name}...";
        for p in in_edges("lives_in").nodes{
            report f"👋 Hello, I'm visiting {p.name}, age {p.age}";
        }
        visit out_edges("road").nodes;
    }
}

with entry {
    # Create people
    nathan = Person(name="Nathan", age=25);
    emily = Person(name="Emily", age=22);
    oliver = Person(name="Oliver", age=30);

    # Create houses
    red_house = House(name="Red House", residents=["Nathan"]);
    blue_house = House(name="Blue House", residents=["Emily"]);
    green_house = House(name="Green House", residents=["Oliver"]);

    # Connect people to their houses
    nathan +>:lives_in:+> red_house;
    emily +>:lives_in:+> blue_house;
    oliver +>:lives_in:+> green_house;

    # Connect roads between houses
    red_house +>:road(distance=50):+> blue_house;
    blue_house +>:road(distance=70):+> green_house;
    green_house +>:road(distance=90):+> red_house;

    # Link everything to root
    root ++> red_house;
    root ++> blue_house;
    root ++> green_house;

    # Run the walker
    tour = root spawn visitVillage();
    print(f"Total houses visited: {tour.visited_count}");
}
