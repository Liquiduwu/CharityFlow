import heapq
import math

# Sample data for demonstration
courier_inventory = {
    "Food": 10,
    "Clothes": 5,
    "Medical Supplies": 7
}

charities = [
    {"name": "Food Bank", "category": "Food", "location": (30.0444, 31.2357)},
    {"name": "Clothing Drive", "category": "Clothes", "location": (30.0333, 31.2333)},
    {"name": "Hospital Supplies", "category": "Medical Supplies", "location": (30.0500, 31.2400)}
]

courier_location = (30.0500, 31.2300)  # Starting location of the courier


# Function to calculate distance between two points (Haversine formula for simplicity)
def calculate_distance(loc1, loc2):
    lat1, lon1 = loc1
    lat2, lon2 = loc2
    return math.sqrt((lat1 - lat2) ** 2 + (lon1 - lon2) ** 2)


# Resource allocation function
def allocate_resources(courier_inventory, charities, courier_location):
    route_plan = []  # Stores the delivery sequence

    while courier_inventory:
        nearest_charity = None
        nearest_distance = float('inf')

        # Find the nearest charity for the top priority item
        for charity in charities:
            if charity["category"] in courier_inventory and courier_inventory[charity["category"]] > 0:
                distance = calculate_distance(courier_location, charity["location"])
                if distance <= nearest_distance:
                    nearest_charity = charity
                    nearest_distance = distance

        if nearest_charity:
            # Allocate resources to the nearest charity
            item_category = nearest_charity["category"]
            route_plan.append({
                "charity": nearest_charity["name"],
                "category": item_category,
                "quantity": courier_inventory[item_category],
                "distance": nearest_distance
            })

            # Remove allocated items from the courier's inventory
            del courier_inventory[item_category]

            # Update courier's location
            courier_location = nearest_charity["location"]
        else:
            break  # No suitable charity found for the remaining items

    return route_plan


# Execute the algorithm
route_plan = allocate_resources(courier_inventory, charities, courier_location)

# Display the route plan
print("Courier Delivery Plan:")
for stop in route_plan:
    print(f"Deliver {stop['quantity']} of {stop['category']} to {stop['charity']} ({stop['distance']:.2f} units away).")
