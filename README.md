# Rbpipe

[![Build Status](https://secure.travis-ci.org/typd/rbpipe.png)](http://travis-ci.org/typd/rbpipe)

Ruby pipe supports "|" or ">>" as pipeline operator

Inspired by https://github.com/JulienPalard/Pipe

## Usage
    bundle install
    > require "Rbpipe"
    > include Rbpipe
    > [1, 2] >> stdout
      [1, 2]
    > piped(9) | stdout
      9
    > [1, 2] >> concat
      1, 2
    > [1, 2, 3, 4] >> even >> concat
      2, 4
    > [1, 2, 3, 4, 5] >> select{|x| x < 4} >> where{|x| x > 1} >> as_list
      [2, 3]
    > [1, 3] >> all? {|x| x > 0}
      true
    > [1, 3] >> any? {|x| x > 2}
      true
    > [[:a, 'b'], [:c, 'd']] >> as_dict
      {:a=>"b", :c=>"d"}
        
## NOTE

Add operators "|" and ">>" to Object

For the classes has their own "|" or ">>", use "piped(obj)", e.g.

    piped([1, 2]) | concat
    piped([8, 9]) >> concat
