#!/usr/bin/env python3
"""
PlatinumRx DA Assignment - Python Proficiency
Question 1: Time Converter

Convert a given number of minutes into human-readable format.

Examples:
    130 becomes "2 hrs 10 minutes"
    110 becomes "1 hr 50 minutes"
    60 becomes "1 hr"
    45 becomes "45 minutes"
"""


def convert_minutes_to_readable(minutes):
    """
    Convert minutes to human-readable time format.
    
    Args:
        minutes (int): Total number of minutes to convert
        
    Returns:
        str: Human-readable time string
    """
    # Handle edge cases
    if minutes is None or minutes < 0:
        return "Invalid input: minutes must be a non-negative number"
    
    if minutes == 0:
        return "0 minutes"
    
    # Calculate hours and remaining minutes
    hours = minutes // 60
    remaining_minutes = minutes % 60
    
    # Build the result string
    parts = []
    
    # Add hours if present
    if hours > 0:
        hour_text = f"{hours} hr" if hours == 1 else f"{hours} hrs"
        parts.append(hour_text)
    
    # Add minutes if present
    if remaining_minutes > 0:
        minute_text = f"{remaining_minutes} minute" if remaining_minutes == 1 else f"{remaining_minutes} minutes"
        parts.append(minute_text)
    
    # Join parts with space
    return " ".join(parts)


def main():
    """
    Main function to demonstrate the time converter with various inputs.
    """
    print("=" * 60)
    print("PlatinumRx DA Assignment - Time Converter")
    print("=" * 60)
    print()
    
    # Test cases from the assignment
    test_cases = [
        130,    # Expected: "2 hrs 10 minutes"
        110,    # Expected: "1 hr 50 minutes"
        60,     # Expected: "1 hr"
        45,     # Expected: "45 minutes"
        0,      # Expected: "0 minutes"
        1,      # Expected: "1 minute"
        120,    # Expected: "2 hrs"
        150,    # Expected: "2 hrs 30 minutes"
        1000,   # Expected: "16 hrs 40 minutes"
        1440,   # Expected: "24 hrs" (1 day)
    ]
    
    print("Test Results:")
    print("-" * 40)
    
    for minutes in test_cases:
        result = convert_minutes_to_readable(minutes)
        print(f"{minutes:>6} minutes → {result}")
    
    print()
    print("=" * 60)
    
    # Interactive mode
    print("\nInteractive Mode (type 'exit' to quit):")
    print("-" * 40)
    
    while True:
        user_input = input("\nEnter minutes: ").strip()
        
        if user_input.lower() == 'exit':
            print("Goodbye!")
            break
        
        try:
            minutes = int(user_input)
            result = convert_minutes_to_readable(minutes)
            print(f"Result: {result}")
        except ValueError:
            print("Error: Please enter a valid integer number.")


if __name__ == "__main__":
    main()
