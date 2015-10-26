#!/usr/bin/env ruby
require 'rspec'
require 'engtagger'

class WordCounter
  attr_accessor :words, :frequency_count, :tgr

  def initialize(input_text)
    @words = input_text.split(/[^\w\']+/)
    @frequency_count = Hash.new(0)
    @words.each { |w| frequency_count[w.upcase] += 1 }
    @tgr = EngTagger.new
    @tagged = @tgr.add_tags(input_text)
  end

  def distinct_words
    frequency_count.keys
  end

  def words_sorted_by_frequency
    frequency_count.sort { |a, b| b[1] <=> a[1] }.to_h
  end

  def nouns
    tgr.
  end

  def summary
    description = "Number of words: #{words.count}\n"
    description << "Number of distinct words: #{distinct_words.count}\n"
    description << "Most common 5 words: #{words_sorted_by_frequency.keys.first(5).join(', ')}\n"
    description << "Least common 5 words: #{words_sorted_by_frequency.keys.reverse.first(5).join(', ')}\n"
  end
end


###############################################################
## Add the code here to create an instance of a
##   WordCounter object.  Initialize it with the text of
##   the Gettysburg Address.  Then print the WordCounter summary.



###############################################################
RSpec.describe WordCounter do
  it "counts words in simple sentences" do
    wc = WordCounter.new("I like pie")
    expect(wc.words.count).to eq 3
  end

  it "counts distinct words" do
    wc = WordCounter.new("I like the pies that I made")
    expect(wc.distinct_words.count).to eq 6
  end

  it "ignores sentence-ending punctuation" do
    wc = WordCounter.new("I still like pie!")
    expect(wc.words.sort).to eq ['I', 'like', 'pie', 'still']
  end

  it "does not break up a contraction" do
    wc = WordCounter.new("Don't stop believing!")
    expect(wc.words.first).to eq "Don't"
  end

  it "can find the most commonly repeated words" do
    wc = WordCounter.new("You know, I think I will eat the fish I caught.")
    expect(wc.words_sorted_by_frequency.keys.first).to eq "I"
  end
end

