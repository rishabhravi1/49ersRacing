def radiator_size(engine_power):
    # Constants
    specific_heat_capacity = 4.18  # Specific heat capacity of water in kJ/(kg·K)
    temperature_difference = 20  # Typical temperature difference for cooling systems in degrees Celsius
    
    # Assume a flow rate of 0.5 kg/s for a car engine
    flow_rate = 0.03  # in kg/s
    
    # Calculate required heat dissipation in kW
    required_heat = engine_power / (specific_heat_capacity * temperature_difference)
    
    # Calculate required radiator size in square meters
    radiator_size = required_heat / (flow_rate * temperature_difference)
    
    return radiator_size

# Example usage
engine_power = float(input("Enter engine power in kW: "))

result = radiator_size(engine_power)
print(f"\nYou would need a radiator with an approximate size of {result:.2f} square meters.")\
    
