# # Traditional OOP approach
# obj Person {
#     has name: str;
#     has friends: list = [];  # List of other Person objects

#     def add_friend(person: object) {
#         self.friends.append(person);
#         person.friends.append(self);  # Make it mutual
#     }
# }

# with entry {
#     alice = Person(name="Alice");
#     bob = Person(name="Bob");
#     charlie = Person(name="Charlie");

#     # Create friendships manually
#     alice.add_friend(bob);
#     alice.add_friend(charlie);
#     bob.add_friend(charlie);

#     # Find friends manually
#     print(f"{alice.name}'s friends:");
#     for friend in alice.friends {
#         print(f"  - {friend.name}");
#     }
# }

# node Nathan{
#     has name:str;
#     has age:int;
#     has subject: str;
# }
# with entry{
#     ouput=Nathan(name="Nathan", age=20, subject="Math");
#     print(f"My name is {ouput.name}, I am {ouput.age} years old, I study {ouput.subject}.");
# }
# node Person {
#     has name: str;
# }

# walker Greeter {
#     can start with `root entry {
#         print("Walker starting journey!");
#         visit [-->];  # Visit all connected nodes
#     }

#     can greet with Person entry {
#         print(f"Hello, {here.name}!");
#         visit [-->];  # Visit this person's connections
#     }
# }

# with entry {
#     # Build graph
#     alice = Person(name="Alice");
#     bob = Person(name="Bob");
#     charlie = Person(name="Charlie");

#     root ++> alice ++> bob ++> charlie;

#     # Spawn walker
#     root spawn Greeter();
# }
# Example: Simple social network graph

# node Person {
#     has name: str;
# }

# walker FindPerson {
#     has target: str;
#     has found: bool = False;

#     can start with `root entry {
#         visit [-->];
#     }

#     can search with Person entry {
#         if here.name == self.target {
#             print(f"Found {here.name}!");
#             self.found = True;
#             disengage;  # Stop immediately
#         }
#         visit [-->];
#     }
# }

# with entry {
#     alice = Person(name="Alice");
#     bob = Person(name="Bob");
#     charlie = Person(name="Charlie");

#     root ++> alice ++> bob ++> charlie;

#     finder = FindPerson(target="Bob");
#     root spawn finder;

#     print(f"Found: {finder.found}");
# }


# social network graph with attributes
# Define our graph structure
# node User {
#     has username: str;
#     has age: int;
#     has interests: list;
# }

# edge Friendship {
#     has since: int;
#     has strength: int = 1;  # How close they are (1-10)
# }

# # Walker to recommend friends
# walker FriendRecommender {
#     has recommendations: list = [];

#     can start with `root entry {
#         visit [-->];
#     }

#     # Start from a user
#     can find_recommendations with User entry {
#         print(f"Finding recommendations for {here.username}...");
#         # Visit friends of friends (2 hops)
#         potential_friends = [here ->:Friendship:-> ->:Friendship:->];

#         # Get current friends to exclude
#         current_friends = [here ->:Friendship:->];

#         for person in potential_friends {
#             # Don't recommend current friends or self
#             if person not in current_friends and person != here {
#                 self.recommendations.append(person.username);
#             }
#         }
#         disengage;
#     }
# }

# # Walker to find users by interest
# walker InterestMatcher {
#     has target_interest: str;
#     has matches: list = [];

#     can start with `root entry {
#         visit [-->];
#     }

#     can find with User entry {
#         if self.target_interest in here.interests {
#             self.matches.append(here.username);
#         }
#         visit [-->];
#     }
# }

# with entry {
#     # Create users
#     alice = User( username="alice", age=25, interests=["coding", "hiking", "photography"] );

#     bob = User(
#         username="bob",
#         age=28,
#         interests=["coding", "gaming"]
#     );

#     charlie = User(
#         username="charlie",
#         age=26,
#         interests=["hiking", "reading"]
#     );

#     dana = User(
#         username="dana",
#         age=27,
#         interests=["photography", "travel"]
#     );

#     # Build social graph
#     root ++> alice;
#     root ++> bob;
#     root ++> charlie;
#     root ++> dana;

#     alice +>:Friendship(since=2020, strength=8):+> bob;
#     bob +>:Friendship(since=2021, strength=6):+> charlie;
#     alice +>:Friendship(since=2019, strength=9):+> dana;

#     # Find friend recommendations for Bob
#     recommender = FriendRecommender();
#     bob spawn recommender;
#     print(f"Recommendations: {recommender.recommendations}");

#     # Find users interested in hiking
#     matcher = InterestMatcher(target_interest="hiking");
#     root spawn matcher;
#     print(f"Users interested in hiking: {matcher.matches}");
# }

# Jac OSP approach - Concise, declarative, type-safe
node Person {
    has name: str;
}

edge Friend {
}

walker FindFriends {
    can start with `root entry {
        visit [-->];
    }

    can find with Person entry {
        report here.name;
        visit [->:Friend:->];
    }
}

with entry {
    alice = Person(name="Alice");
    bob = Person(name="Bob");
    charlie = Person(name="Charlie");

    root ++> alice;
    alice +>:Friend:+> bob;
    alice +>:Friend:+> charlie;

    friends = root spawn FindFriends();
    print(f"Found friends: {friends}");
}