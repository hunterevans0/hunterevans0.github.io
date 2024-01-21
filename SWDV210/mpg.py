#!/usr/bin/env python3

# display a welcome message
print("The Miles Per Gallon program")
print()

# get input from the user
miles_driven = float(input("Enter miles driven:\t\t"))
gallons_used = float(input("Enter gallons of gas used:\t"))
gallon_cost  = float(input("Enter cost per gallon:\t\t"))

# calculate miles per gallon
mpg = round(miles_driven / gallons_used, 1)
tgc = round(gallons_used * gallon_cost, 1)
cpm = round(tgc / miles_driven, 1)
            
# format and display the result
print()
print(f"Miles Per Gallon:\t\t{mpg}")
print(f"Total Gas Cost:\t\t\t{tgc}")
print(f"Cost Per Mile:\t\t\t{cpm}")
print()
print("Bye!")


