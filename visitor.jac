node Student{
    has name:str;
    has subjects:List[str];
    has favorite_subject:str;
    can getstd with getall_students entry{
        students=[root -->(`?Student)](?favorite_subject=="Math");
        if students != None{ 
             for i in students{
                print(i);
             }     
             }else{
                print("No students found");
             }
}
}
node teacher{
    has name:str;
    has subject:str;
    has years_of_experience:int;
}
walker getall_students{
   can getstudents with `root entry{
    visit[root -->(`?Student)];
   }
}
with entry{
    bob=Student(name="Bob", subjects=["Math", "Science"], favorite_subject="Math");
    alice=Student(name="Alice", subjects=["History", "Art"], favorite_subject="Art");
    mr_smith=teacher(name="Mr. Smith", subject="Math", years_of_experience=10);
    ms_jones=teacher(name="Ms. Jones", subject="History", years_of_experience=8);    
    root ++> bob;
    root ++> alice;     
    root ++> mr_smith;
    root ++> ms_jones;
    output= root spawn getall_students();
    print(output);
}