require_relative "../config/environment.rb"
require 'pry'
class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL

    DB[:conn].execute(sql)
  end

  def save
    if self.id 
      update
    else
      # sql = <<-SQL
      # INSERT INTO students (name, grade) 
      # VALUES (?, ?)
      # SQL
      #self.name = eri); DROP TABLE students;
      
      sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
      #bad_sql = eri) DROP TABLE students
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
  end

def self.create(name, grade)
  new_student = Student.new(name, grade)
  new_student.save
  new_student
end

def self.new_from_db(array)
  new_student = Student.new(array[0], array[1], array[2])
  
  # new_student.id = array[0] 
  # new_student.id = array [1]
  # new_student.id = array [2]
end

def self.find_by_name(name)
  sql = <<-SQL
  SELECT * FROM students WHERE name = ? LIMIT 1;
  SQL
  DB[:conn].execute(sql, name).map do |row|
    self.new_from_db(row)
  end.first
end

def update
  sql = "UPDATE students SET name = ? WHERE grade = ?;"

  DB[:conn].execute(sql, self.name, self.grade)
end

end
