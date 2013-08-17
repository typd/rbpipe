module Rbpipe
  extend self

  def piped(obj)
    Subject.new obj
  end

  # stopword pipes
  def as_list
    Pipe.new(false) do |obj|
      obj.is_a?(Array)? obj : [obj]
    end
  end

  def as_dict
    Pipe.new(false) do |obj|
      if obj.is_a?(Hash)
        obj
      else
        res = {}
        obj.each {|k, v| res[k] = v}
        res
      end
    end
  end

  def any?(&condition)
    Pipe.new(false) {|list| list.any? &condition}
  end

  def all?(&condition)
    Pipe.new(false) {|list| list.all? &condition}
  end

  def concat(sep=", ")
    Pipe.new(false) {|list| list.join(sep) }
  end

  def stdout
    Pipe.new(false) {|obj| p obj}
  end

  # pipes
  def select(&condition)
    Pipe.new {|list| list.select {|x| condition[x]}}
  end
  alias_method :where, :select
  alias_method :filter, :select

  def first(count)
    Pipe.new {|list| list.first(count)}
  end
  alias_method :take, :first

  def even
    Pipe.new {|list| list.select {|x| x % 2 == 0}}
  end

  private
  class Pipe
    def initialize(pipeable=true, &function)
      @pipeable = pipeable
      @function = function
    end

    def |(other)
      pipe(other)
    end

    def >>(other)
      pipe(other)
    end

    def pipe(other)
      result = @function[other]
      @pipeable ? Subject.new(result) : result
    end
  end

  class Subject
    def initialize(obj)
      @obj = obj
    end

    def |(pipe)
      pipe | @obj
    end

    def >>(pipe)
      pipe >> @obj
    end
  end
end

class Object
  def |(other)
    other | self
  end

  def >>(other)
    other | self
  end
end
