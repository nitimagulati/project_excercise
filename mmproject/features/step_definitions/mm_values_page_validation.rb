require 'rspec'

Given("a user goes to values page") do
  @page.visit
  expect(@page.label_value_1_field.present?).to be true
end

When("values page loads") do
  expect(@page.label_value_1_field.present?).to be true
end

Then("right count of values labels and text boxes display on screen") do
  expect(@page.values_text_boxes_count).to match 5
  expect(@page.values_labels_count).to match 5
  expect(@page.values_text_boxes_count).to match(@page.values_labels_count)
  expect(@page.value_text_box_fields_present_on_screen?).to be true
end

When("user enters values in first text field on right top") do
  @page.text_field_1.set(@text_field_value_1)
  @page.text_field_1.send_keys :tab
end

Then("Total balance should be same as of value of first text field value") do
  expect(@page.total_balance_field_monetized_parsed_value).to match(@page.sum_of_value_text_fields)
  expect(@page.total_balance_field_monetized_parsed_value).to match(@text_field_1_monetized_value)
end

When("user enters values in first, third and fifth of text fields on right top") do
  @page.text_field_1.set(@text_field_value_1)
  @page.text_field_1.send_keys :tab
  # enter values in 3rd text field
  @page.text_field_3.set(@text_field_value_3)
  @page.text_field_3.send_keys :tab
  # enter values in 5th text field
  @page.text_field_5.set(@text_field_value_5)
  @page.text_field_5.send_keys :tab
end

Then("Total balance should be sum of all of first, third and fifth text boxes values") do
  expect(@page.total_balance_field_monetized_parsed_value).to match(@page.sum_of_value_text_fields)
end

When("user enters values in all of text fields on right top") do
  @page.text_field_1.set(@text_field_value_1)
  @page.text_field_1.send_keys :tab
  # enter values in 2nd text field
  @page.text_field_2.set(@text_field_value_2)
  @page.text_field_2.send_keys :tab
  # enter values in 3rd text field
  @page.text_field_3.set(@text_field_value_3)
  @page.text_field_3.send_keys :tab
  # enter values in 4th text field
  @page.text_field_4.set(@text_field_value_4)
  @page.text_field_4.send_keys :tab
  # enter values in 5th text field
  @page.text_field_5.set(@text_field_value_5)
  @page.text_field_5.send_keys :tab
end

Then("Total balance should be same as listed value") do
  expect(@page.total_balance_field_monetized_parsed_value).to match(@page.sum_of_value_text_fields)
  expect(@page.total_balance_field_monetized_parsed_value).to match(@total_bal_calculated_value)
end

Then("value on the screen should be greater than {int}") do |int|
  expect(@page.all_value_fields_parsed_value_greater_than_zero?).to be true
end

Then("value on the screen should be formatted as currency") do
  expect(@page.all_text_fields_values_formatted_as_currency?(@options[:currency])).to be true
  expect(@page.total_balance_field_value_currency_symbol).to eq(@options[:symbol])
end

Then("Total balance should be sum of all of text boxes values") do
  expect(@page.sum_of_value_text_fields).to match(@total_bal_monetized_value)
  expect(@page.sum_of_value_text_fields).to match(@page.total_balance_field_monetized_parsed_value)
end
After do
  @browser.close
end