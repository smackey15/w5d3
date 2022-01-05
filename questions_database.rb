require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question 
    attr_accessor :id, :title, :body, :users_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?
    SQL
    return "Question does not exist" if question.length == 0
    
    Question.new(question.first)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @users_id = options['users_id']
  end
end

class User 
    attr_accessor :id, :fname, :lname

  def self.all
    users = QuestionsDatabase.instance.execute("SELECT * FROM users")
    users.map {|datum| User.new(datum)}
  end

  def self.find_by_id(id)
    users = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL
      return "User does not exist" if users.length == 0
      User.new(users.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
end

class Reply
    attr_accessor :id, :questions_id, :replies_id, :users_id, :body

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?
    SQL
    return "reply does not exist" if reply.length == 0
    
    Reply.new(reply.first)
  end

  def initialize(options)
    @id = options['id']
    @questions_id = options['questions_id']
    @replies_id = options['replies_id']
    @users_id = options['user_id']
    @body = options['body']
  end
end

class QuestionFollow
    
    def self.all
      data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
      data.map { |datum| QuestionFollow.new(datum) }
    end

    def initialize(options)
      @id = options['id']
      @users_id = options['users_id']
      @questions_id = options['questions_id']
    end

    def self.follow_count(question_id)
      QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          SUM(questions_id)
        FROM
          question_follows
        WHERE
          questions_id = ?
        SQL
        
    end
end