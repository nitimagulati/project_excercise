# project_excercise
# project
Problem :

High level scenario: Validate Total balance value and field values on Values page.

Based on attached PPT had couple of questions.
My approach would be to get it clarified from stakeholder and proceed with the confirmed expectations.

ques) Attached ppt shows text fields already have values in it, From where the values are getting populated? 
screen didn’t show any button to update balance text field, How the total balance is getting updated?. Is it any blur event? (exp tab out) Would like to get it clarified from stakeholders.

Assumptions:
I assumed here that user is entering the values in text value field and on tab out event Total balance field is getting updated.

Following frameworks have been used
- Watir, Selenium web driver, 
- Ruby on rails, Rspec
- Cucumber, Cucumber html formatter to generate reports.
- Monetize gem

I found Monetize gem (A library for converting values into Money Object) be helpful in parsing String values to Money, it provided me ability to parse String values to Money.

Monetize gem requires Money gem and has several unit tests to make sure, invalid strings formats throws exception. 
Found it useful as test would fail if there is wrong formatting, data is not object of Money class or data doesn’t have ISO code (money code)

Project Structure

features-> 
mm_values_page_validation.feature
step_definations
->mm_values_page_validation.rb
-> mm_page
->base_page
->mass_mutual_page
support

2) mm_values_page_validation.feature file specifies feature to be tested, a high level description of scenarios to be tested, it assume prerequisite in Given block, describes the flow of action performed in when block and validate/assert expected result in Then block

3)-> step_definations folder -> mm_values_page_validation.rb is actual implementation of the steps (which are mentioned in feature file) in ruby language. Specify procedures to perform actions and validate results. Returning any value is not significant here. Test will fail if any of step throw exception.

4) -> step_definations folder -> mm_pages -> base_page and mm_page

base page is to create url based on protocol (https) host and path. (would like to enhance it for query string parameters)

mass_mutual_page specifies element selector methods, procedures for currency validations and parsing of text_fields values as Money and calculating Total balance as sum of the values of text fields.

5) Support folder 
env.rb file contains all of gems which are required for project to work. Before and After block that will run at before every scenario and after feature.
Before block is to initiate browser test needs to create fresh browser before start of any scenario.

Currently locale (“en”) and currency value (“USD”) which tests are using as expected values are getting passed using env variables. This could be passed from feature file as local variables.

env_manager file could be enhanced to set Env variables which could be used in any methods for screenshots 

6) Cucumber html formatter to generate reports this could potentially be enhanced to get reports in xml, Junit or more formats.


To do 
spec_helper To do is to enhance it for proper formatting.
Enhance utilities for Money parser.

To run test script 
Install chrome driver and Place executable path in your $PATH env variable
(:/Users/home/mmproject/features/support/browser_driver)

Run command
cucumber /project_path/mmproject/features/mm_values_page_validation.feature --color -r features --format html > output/outputresult.html

Screenshot of mock report generated via test script is as attached
