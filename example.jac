import from byllm.lib { Model }
glob llm = Model(model_name="gemini/gemini-2.0-flash");

"""Represents the personal record of a person"""
obj Person {
    has name: str;
    has dob: str;
    has ssn: str;
}

sem Person.name = "Full name of the person";
sem Person.dob = "Date of Birth";
sem Person.ssn = "Last four digits of the Social Security Number of a person";

"""Calculate eligibility for various services based on person's data."""
def check_eligibility(person: Person, service_type: str) -> bool by llm();