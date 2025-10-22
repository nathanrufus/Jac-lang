node Teacher {
    has name:str;
    has age:int;
}
node Student {
    has name:str;
    has grade:int;
}
edge Teaches{
    has subject:str;
}
walker GetTeacherofstudents{
    has students:list=[];

    can getStudent with Student entry{
        self.students.append(here.name );
        print(here.name + " is a student" );
        visit[-->];
    }
    can mathTeacher with Teacher entry{
        print(here.name + " is a math teacher");
        visit[->:Teaches:subject == "maths":->];
    }
}
with entry{
    bob=Teacher(name="Bob", age=40);
    alice=Student(name="Alice", grade=90);
    charlie=Student(name="Charlie", grade=85);
    nathan=Teacher(name="Nathan", age=35);
    amos=Student(name="Amos", grade=88);
    chris=Student(name="Chris", grade=92);
    root ++> bob;
    root ++> nathan;
    root ++> alice;

    nathan +>:Teaches("maths"):+> alice;
    bob +>:Teaches("Kiswahili"):+> charlie;
    nathan +>:Teaches("science"):+> amos;
    bob +>:Teaches("history"):+> chris;
    nathan +>:Teaches("art"):+> bob;
    nathan +>:Teaches("maths"):+> chris;
    result=nathan spawn GetTeacherofstudents();
    print(result);
    
}