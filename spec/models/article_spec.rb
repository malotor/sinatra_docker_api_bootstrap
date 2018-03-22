require_relative '../spec_helper'

describe "Articles model" do

  it "should have a title and a content" do
     #article = Article.new(content: "a" * 100)
     #expect(article.valid?).to be_falsey
     expect {  Article.new( "a" * 100) }.to raise_error(ArgumentError)

  end

  it "should have a title lesser than 100 characters" do
     article = Article.new( "a" * 200,  "A content")
     expect(article.valid?).to be_falsey
  end

  it "should have title and content" do
     article = Article.new( "A title",  "A content")
     expect(article.valid?).to be true
  end

  it "should not be published if new" do
    article = Article.new( "A title",  "A content")

    expect(article.have_been_published?).to be false
  end

  it "should not be published" do
    article = Article.new( "A title",  "A content")
    article.publish
    expect(article.have_been_published?).to be true
  end
  it "should not have publish date is article has not been published" do
    article = Article.new( "A title",  "A content")
    expect(article.have_been_published?).to be false
  end

  it "should have a publish date if is published" do
    article = Article.new( "A title",  "A content")
    article.publish
    expect(article.published_on).not_to be false
  end

  it "should no be publish if it already has been published" do
    article = Article.new( "A title",  "A content")
    article.publish
    expect { article.publish }.to raise_error(ArticlesHasAlreadyPublishedError)
  end
end
