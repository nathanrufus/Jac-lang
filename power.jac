node PowerStation {
    has name:str;
    has capacity:int;
}
node House{
    has name:str;
    has power_usage:int;
}
node Factory {
    has name:str;
    has power_usage:int;
}
edge PowerLine{
    has distance:int;
    has status:str;
}

walker PowerFlow {
    has total_demand: int = 0;

    can start with PowerStation entry {
        print(f"⚙️ Starting power flow analysis at {here.name} (capacity: {here.capacity} MW)");
        self.total_demand = 0;

        # Visit only active connections
        visit [->:PowerLine:status == "active":->];
    }

    can visit with House entry {
        print(f"🏠 Visiting {here.name} (usage: {here.power_usage} kW)");
        self.total_demand += here.power_usage;
        disengage;
    }

    can visit with Factory entry {
        print(f"🏭 Visiting {here.name} (usage: {here.power_usage} kW)");
        self.total_demand += here.power_usage;
        disengage;
    }

    can exit with PowerStation entry {
        print("🔎 Calculating results...");
        total_in_mw = self.total_demand / 1000.0;  # Convert from kW to MW

        if total_in_mw > here.capacity {
            print(f"⚠️ Overload detected at {here.name}!");
            print(f"Total demand: {total_in_mw} MW exceeds capacity {here.capacity} MW.");
        } else {
            print(f"✅ Power supply stable for {here.name}.");
            print(f"Total demand: {total_in_mw} MW within capacity {here.capacity} MW.");
        }
        disengage;
    }
}

with entry {
    # Create Power Stations
    ps1 = PowerStation(name="Station A", capacity=5);
    ps2 = PowerStation(name="Station B", capacity=10);

    # Create Houses
    h1 = House(name="House 1", power_usage=1200);
    h2 = House(name="House 2", power_usage=800);
    h3 = House(name="House 3", power_usage=1500);

    # Create Factories
    f1 = Factory(name="Factory X", power_usage=3000);
    f2 = Factory(name="Factory Y", power_usage=5000);

    # Connect with PowerLines
    ps1 +>:PowerLine(distance=1.2, status="active"):+> h1;
    ps1 +>:PowerLine(distance=2.5, status="active"):+> f1;
    ps1 +>:PowerLine(distance=3.0, status="down"):+> h2;
    ps2 +>:PowerLine(distance=1.8, status="active"):+> h2;
    ps2 +>:PowerLine(distance=2.0, status="active"):+> h3;
    ps2 +>:PowerLine(distance=2.7, status="active"):+> f2;

    print("\n=== 🔋 Running Power Flow Simulation for Station A ===");
    flow1 = PowerFlow();
    ps1 spawn flow1;

    print("\n=== 🔋 Running Power Flow Simulation for Station B ===");
    flow2 = PowerFlow();
    ps2 spawn flow2;
}
