impl nathan.add_friend{
    friend_name = input("Enter friend's name: ");
    self.friends.append(friend_name);
    print(f"Added {friend_name} to {self.name}'s friends list.");
}