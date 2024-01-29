#!/usr/bin/env python3

def get_float(prompt, low, high):
    done = "n"
    while done == "n":
        answer = float(input(prompt))
        if answer > low and answer <= high:
            done = "y"
            return answer
        else:
            print(f"Entry must be greater than {low} and less than or equal to {high}")
            
def get_int(prompt, low, high):
    done = "n"
    while done == "n":
        answer = int(input(prompt))
        if answer > low and answer <= high:
            done = "y"
            return answer
        else:
            print(f"Entry must be greater than {low} and less than or equal to {high}")

def main():
    choice = "y"
    while choice.lower() == "y":
        get_float("This is a test of the get_float function. Enter a value: ", 0, 100)
        get_int("This is a test of the get_int function. Enter a value:   ", 0, 200)
        choice = input("Continue? (y/n): ")
        print()

    print("Bye!")
    
if __name__ == "__main__":
    main()
