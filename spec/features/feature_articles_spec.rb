require_relative '../spec_helper'

describe 'API' do

  before(:each) do
    # cleanup database
    Article.destroy_all
  end


  it "should recover all articles" do
    article = Article.create(title: 'Title 1', content: "Content 1")

    get "/articles"

    expect(last_response.status).to eq(200)

    # parse JSON
    info = JSON::parse(last_response.body)
    expect(info.size).to eq(1)
    expect(info[0]['title']).to eq(article.title)
    expect(info[0]['content']).to eq(article.content)

  end

  it "should create an article" do
    post '/articles', { :title => 'Title 1', :content => "Content 1" }
    expect(last_response.status).to eq(201)
    expect(Article.count).to eq(1)
    expect(Article.first.title).to eq("Title 1")

    expect(last_response.headers).to have_key('Location')
  end

  it "should require title and content to create an article" do
    post '/articles', { :title => 'Title 1' }
    expect(last_response.status).to eq(400)
  end

  it "should valid parameters to create an article" do
    post '/articles', { :title => "a" * 200 , :content => "Content 1"}
    expect(last_response.status).to eq(422)
  end


  it "should remove an article" do

    article = Article.create(title: 'Title 1', content: "Content 1")

    delete "/articles/#{article.id}"
    expect(last_response.status).to eq(204)
    expect(Article.count).to eq(0)

  end


  it "should recover a single article" do

    article = Article.create(title: 'Title 1', content: "Content 1")

    get "/articles/#{article.id}"
    expect(last_response.status).to eq(200)
    # parse JSON
    info = JSON::parse(last_response.body)
    expect(info['title']).to eq(article.title)
    expect(info['content']).to eq(article.content)
    expect(last_response.headers).to have_key('Location')

  end

  it "should fail recovering a non existent  article" do
    get "/articles/1"
    expect(last_response.status).to eq(404)
  end

  it "should update an article" do

    article = Article.create(title: 'Title 1', content: "Content 1")

    put "/articles/#{article.id}", { :title => 'Title 2' }
    expect(last_response.status).to eq(200)

    updated_article = Article.find(article.id)

    expect(updated_article.title).to eq("Title 2")

    info = JSON::parse(last_response.body)
    expect(info['title']).to eq(updated_article.title)
  end

end
