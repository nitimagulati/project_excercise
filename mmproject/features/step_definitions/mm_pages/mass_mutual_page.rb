require 'monetize'
#require 'money'
require_relative './base_page'
# encoding: utf-8

class MassMutualPage < BasePage
  def initialize(browser, host, locale, currency, symbol)
    super(browser, host, locale)
    @browser = browser
    @host = host
    @locale = locale
    @currency = currency
    @symbol = symbol
    @utils = Utilities.new(@browser)
  end

  I18n.config.available_locales = @locale
  #Money.locale_backend = :i18n
  #Monetize.I18n.locale = @locale

  def path
    "/values/"
  end

  def label_value_1_field
    @browser.label(id: "lbl_val_1")
  end

  # it returns an array of all of the right hand side text fields except sum text box
  def value_text_box_fields
    @browser.text_fields(id: /^txt_val_[1-2]$|^txt_val_[4-6]$/)
  end

  def value_text_box_fields_present_on_screen?
    value_text_box_fields.each { |text_field| @utils.wait_until(text_field.present?) }
  end

  # returns array of all of the label fields from left hand side except sum label box
  def values_label_fields
    labels = []
    (1..5).each do |i|
      labels << @browser.label(id: "lbl_val_#{i}")
    end
  end

  # counts the number of labels on screen
  def values_labels_count
    values_label_fields.count
  end

  # counts the number of text value boxes on right hand side of page except sum text box
  def values_text_boxes_count
    value_text_box_fields.to_a.count
  end

  #total balance text field element
  def total_balance_text_field
    @browser.text_field(:id, 'txt_ttl_val')
  end

  # Monetize.parse("$122,365.24") returns 122365.24
  def total_balance_field_monetized_parsed_value
    # encoding: utf-8
    Monetize.parse(@browser.text_field(id: 'txt_ttl_val').value)
  end

  # return value of total balance field (string)
  def total_balance_field_value_string
    @browser.text_field(:id, 'txt_ttl_val').value
  end

  # Monetize.parse("$122,365.24").symbol returns $
  def total_balance_field_value_currency_symbol
    # encoding: utf-8
    Monetize.parse(@browser.text_field(id: 'txt_ttl_val').value).symbol
  end

  # Monetize.parse("$122,365.24").currency returns "USD"
  # # it checks all of the right hand side text boxes which has value are formatted as currency
  # created a array of text fields which has values and not empty
  #
  def text_fields_with_values
    value_text_box_fields.select { |text_box| !text_box.value.nil? }
  end

  # validate for only text fields which are not empty
  # validation required for scenario where user enters in text field 1 and text field 3 but not text_field 2, so only validate text_fields which are not empty
  # (Need to confirm requirement here?) Could there be any text field be empty? 
  def text_fields_values_formatted_as_currency?(currency, text_fields_with_values)
    # encoding: utf-8
    # # Monetize.parse("$122,365.24") returns "USD"
    text_fields_with_values.all? { |text_box| Monetize.parse(tb.value).currency == currency }
  end

  # validate all of text fields should be currency formatted
  # it will fail if any of the text_field is empty or doesn't match currency set in env variable.
  def all_text_fields_values_formatted_as_currency?(currency)
    # encoding: utf-8
    value_text_box_fields.all? { |text_box| Monetize.parse(tb.value).currency == currency }
  end

  # Monetize.parse("$122,365.24") returns "USD"
  def value_fields_parsed_value_greater_than_zero?(text_fields_with_values)
    # encoding: utf-8
    text_fields_with_values.all? { |text_box| Monetize.parse(text_box.value) > 0 }
  end

  # Monetize.parse("$122,365.24") returns "USD"
  def all_value_fields_parsed_value_greater_than_zero?
    # encoding: utf-8
    value_text_box_fields.all? { |text_box| Monetize.parse(text_box.value) > 0 }
  end

  # return sum of text field values at any given point of time.
  # if only two text fields has value, will return sum of those two values
  def sum_of_value_text_fields
    # encoding: utf-8
    sum = 0
    value_text_box_fields.each { |text_box| sum += Monetize.parse(text_box.value) }
    sum
  end

  def text_field_1
    @browser.text_field(id: 'txt_val_1')
  end

  def text_field_2
    @browser.text_field(id: 'txt_val_2')
  end

  def text_field_3
    @browser.text_field(id: 'txt_val_4')
  end

  def text_field_4
    @browser.text_field(id: 'txt_val_5')
  end

  def text_field_5
    @browser.text_field(id: 'txt_val_6')
  end

  # check every label has text field along it
  def label_fields_vrs_text_fields(value_labels_count, values_text_boxes_count)
    if value_labels_count == values_text_boxes_count
      value_labels.zip value_text_boxes
    else
      raise "labels count doesn't match text boxes.labels count: #{value_labels.count}.text boxes count : #{value_text_boxes.count}"
    end
  end

end
