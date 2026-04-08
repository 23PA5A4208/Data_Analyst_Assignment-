#!/usr/bin/env python3
"""
PlatinumRx DA Assignment - Python Proficiency
Question 2: Remove Duplicates from String

Given a string, remove all duplicate characters and print the unique string.
Uses a loop as specified in the requirements.

Examples:
    "hello" → "helo"
    "programming" → "progamin"
    "aardvark" → "ardvk"
"""


def remove_duplicates(input_string):
    """
    Remove duplicate characters from a string using a loop.
    
    Args:
        input_string (str): The input string to process
        
    Returns:
        str: String with duplicate characters removed (first occurrence kept)
    """
    # Handle edge cases
    if input_string is None or len(input_string) == 0:
        return ""
    
    # Initialize empty result string
    result = ""
    
    # Loop through each character in the input string
    for char in input_string:
        # Check if character is NOT already in result
        if char not in result:
            # Add character to result if it's unique so far
            result += char
    
    return result


def remove_duplicates_case_insensitive(input_string):
    """
    Remove duplicate characters from a string (case-insensitive version).
    Preserves the case of first occurrence.
    
    Args:
        input_string (str): The input string to process
        
    Returns:
        str: String with duplicate characters removed (case-insensitive)
    """
    if input_string is None or len(input_string) == 0:
        return ""
    
    result = ""
    seen_lower = ""  # Track lowercase versions for comparison
    
    for char in input_string:
        if char.lower() not in seen_lower:
            result += char
            seen_lower += char.lower()
    
    return result


def main():
    """
    Main function to demonstrate the duplicate removal with various inputs.
    """
    print("=" * 60)
    print("PlatinumRx DA Assignment - Remove Duplicates")
    print("=" * 60)
    print()
    
    # Test cases
    test_cases = [
        "hello",           # Expected: "helo"
        "programming",     # Expected: "progamin"
        "aardvark",        # Expected: "ardvk"
        "mississippi",     # Expected: "misp"
        "banana",          # Expected: "ban"
        "abcdef",          # Expected: "abcdef" (no duplicates)
        "aaaaaa",          # Expected: "a"
        "a",               # Expected: "a" (single char)
        "",                # Expected: "" (empty string)
        "Python Programming",  # Expected: "Python Pgramig"
        "123321",          # Expected: "123"
        "!@#$@#!",         # Expected: "!@#$"
    ]
    
    print("Test Results (Case-Sensitive):")
    print("-" * 50)
    
    for test_string in test_cases:
        result = remove_duplicates(test_string)
        # Show limited preview for long strings
        display_input = test_string if len(test_string) <= 30 else test_string[:27] + "..."
        print(f"  Input:  \"{display_input}\"")
        print(f"  Output: \"{result}\"")
        print()
    
    print("=" * 60)
    print("\nCase-Insensitive Examples:")
    print("-" * 50)
    
    case_test_cases = [
        "HelloWorld",
        "AaBbCcAa",
        "Mississippi",
    ]
    
    for test_string in case_test_cases:
        result_sensitive = remove_duplicates(test_string)
        result_insensitive = remove_duplicates_case_insensitive(test_string)
        print(f"  Input:  \"{test_string}\"")
        print(f"  Case-Sensitive:   \"{result_sensitive}\"")
        print(f"  Case-Insensitive: \"{result_insensitive}\"")
        print()
    
    print("=" * 60)
    
    # Interactive mode
    print("\nInteractive Mode (type 'exit' to quit):")
    print("-" * 40)
    
    while True:
        user_input = input("\nEnter a string: ").strip()
        
        if user_input.lower() == 'exit':
            print("Goodbye!")
            break
        
        result = remove_duplicates(user_input)
        print(f"Result: \"{result}\"")
        print(f"Original length: {len(user_input)}, New length: {len(result)}")
        print(f"Characters removed: {len(user_input) - len(result)}")


if __name__ == "__main__":
    main()
