require_relative '../spec_helper'

describe "Articles model" do

  it "should have  a content" do
     article = Article.new(title: "a" * 100)
     expect(article.valid?).to be_falsey
  end

  it "should have a title" do
     article = Article.new(content: "a" * 100)
     expect(article.valid?).to be_falsey
  end

  it "should have a title lesser than 100 characters" do
     article = Article.new(title: "a" * 200, content: "A content")
     expect(article.valid?).to be_falsey
  end

  it "should have title and content" do
     article = Article.new(title: "A title", content: "A content")
     expect(article.valid?).to be true
  end


end
