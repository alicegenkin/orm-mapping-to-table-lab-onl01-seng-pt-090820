class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self._table
    sql = <<-SQL
       TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students(name,grade)
    VALUES(?,?)
    SQL
    DB[:conn].execute(sql,self.name,self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students") [0][0]
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  end


  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      )
    SQL
    DB[:conn].execute(sql)
  end
    #this is a class method that creates the students table. Use a heredoc to set a variable, `sql`, equal to the necessary SQL statement. Remember, the attributes of a student, `name`, `grade`, and `id`, should correspond to the column names you are creating in your students table. The `id` column should be the primary key. With your `sql` variable pointing to the correct SQL statement, you can execute that statement using the `#execute` method provided to us by the SQLite3-Ruby gem. Remember that this method is called on whatever object stores your connection to the database, in this case `DB[:conn]`.
    def self.create(name:, grade:)
      student = student.new(name, grade)
      student.save
      student
    end
end
