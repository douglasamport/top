The Odin project - Event Manager Project
https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/event-manager-ruby-programming

What We’re Doing in This Tutorial

Imagine that a friend of yours runs a non-profit organization around political activism. A number of people have registered for an upcoming event. She has asked for your help in engaging these future attendees. For the first task, she wants you to find the government representatives for each attendee based on their zip code.
2. Create custom HTML e-mails for each attendee.
  - Create a rescue for invalid zip codes
  - Time the API Requests so as not to max out the Google API minute limit. (required to run the large data set)
3. Assignment: Clean Phone Numbers
Similar to the zip codes, the phone numbers suffer from multiple formats and inconsistencies. If we wanted to allow individuals to sign up for mobile alerts with the phone numbers, we would need to make sure all of the numbers are valid and well-formed.

  - If the phone number is less than 10 digits, assume that it is a bad number
  - If the phone number is 10 digits, assume that it is good
  - If the phone number is 11 digits and the first number is 1, trim the 1 and use the first 10 digits
  - If the phone number is 11 digits and the first number is not 1, then it is a bad number
  - If the phone number is more than 11 digits, assume that it is a bad number

  - I replaced the phonumbers in the entry and exported to a new CSV file.

4. Assignment: Time Targeting
The boss is already thinking about the next conference: “Next year I want to make better use of our Google and Facebook advertising. Find out which hours of the day the most people registered, so we can run more ads during those hours.” Interesting!

Using the registration date and time we want to find out what the peak registration hours are


5. Assignment: Day of the Week Targeting
The big boss gets excited about the results from your hourly tabulations. It looks like there are some hours that are clearly more important than others. But now, tantalized, she wants to know “What days of the week did most people register?”

Use Date#wday to find out the day of the week.

  - I combined assignment four an five and exported the data to google graphs to help visualize the data.
  - I also exported a json file of the final Hash Object just to practice.