require_relative '../spec_helper'

describe 'API' do

  before(:each) do
    # cleanup database
    Article.destroy_all
  end

  it "Start page ok" do
    get "/"
    expect(last_response.status).to eq(200)
    expect(last_response.content_type).to eq("application/json")
    expect(last_response.body).to eq({ status: 'UP' }.to_json)

  end


  it "GET /articles" do
    article = Article.create(title: 'Title 1', content: "Content 1")

    get "/articles"

    expect(last_response.status).to eq(200)

    # parse JSON
    info = JSON::parse(last_response.body)
    expect(info.size).to eq(1)
    expect(info[0]['title']).to eq(article.title)
    expect(info[0]['content']).to eq(article.content)

  end

  it "POST /article" do
    post '/articles', { :title => 'Title 1', :content => "Content 1" }
    expect(last_response.status).to eq(201)
    expect(Article.count).to eq(1)
    expect(Article.first.title).to eq("Title 1")

  end


end
