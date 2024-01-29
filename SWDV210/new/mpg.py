#!/usr/bin/env python3

# display a welcome message
print("The Miles Per Gallon program")
print()

yn = "y"
while yn == "y":
    # get input from the user
    miles_driven = float(input("Enter miles driven:         "))
    gallons_used = float(input("Enter gallons of gas used:  "))
    gallon_cost  = float(input("Enter cost per gallon:      "))

    print()
    
    if miles_driven <= 0:
        print("Miles driven must be greater than zero. Please try again.")
        print()
    elif gallons_used <= 0:
        print("Gallons used must be greater than zero. Please try again.")
        print()
    elif gallon_cost <= 0:
        print("Gallon cost must be greater than zero. Please try again.")
        print()
    else:
        # calculate and display miles per gallon
        mpg = round(miles_driven / gallons_used, 2)
        print("Miles Per Gallon:          ", mpg)
        tgc = round(gallons_used * gallon_cost, 1)
        print("Total Gas Cost:            ", tgc)
        cpm = round(tgc / miles_driven, 1)
        print("Cost Per Mile:             ", cpm)
        
        print()
        
    yn = input("Get entries for another trip (y/n)? ")
    yn = yn.lower()
    
    print()

print()
print("Bye!")



