#!/usr/bin/env python3
import validation
        
def calculate_future_value(monthly_investment, yearly_interest, years):
    # convert yearly values to monthly values
    monthly_interest_rate = yearly_interest / 12 / 100
    months = years * 12

    # calculate future value
    future_value = 0.0
    for i in range(months):
        future_value += monthly_investment
        monthly_interest = future_value * monthly_interest_rate
        future_value += monthly_interest

    return future_value

# def get_float(prompt, low, high):
#     done = "n"
#     while done == "n":
#         answer = float(input(prompt))
#         if answer > low and answer <= high:
#             done = "y"
#             return answer
#         else:
#             print(f"Entry must be greater than {low} and less than or equal to {high}")
            
# def get_int(prompt, low, high):
#     done = "n"
#     while done == "n":
#         answer = int(input(prompt))
#         if answer > low and answer <= high:
#             done = "y"
#             return answer
#         else:
#             print(f"Entry must be greater than {low} and less than or equal to {high}")

def main():
    choice = "y"
    while choice.lower() == "y":
        # get input from the user
        monthly_investment = validation.get_float("Enter monthly investment:\t", 0, 1000)
        yearly_interest_rate = validation.get_float("Enter yearly interest rate:\t", 0, 15)
        years = validation.get_int("Enter number of years:\t\t", 0, 50)

        # get and display future value
        future_value = calculate_future_value(
            monthly_investment, yearly_interest_rate, years)

        print(f"Future value:\t\t\t{round(future_value, 2)}")
        print()

        # see if the user wants to continue
        choice = input("Continue? (y/n): ")
        print()

    print("Bye!")
    
if __name__ == "__main__":
    main()
