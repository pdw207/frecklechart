require 'pry'
require '../app.rb'


#TODO write tests for each model

describe 'Employee' do
 it 'has a valid name' do
  employee = Employee.new(name: "John")
  expect(employee.name == "John").to eql true
 end
end

