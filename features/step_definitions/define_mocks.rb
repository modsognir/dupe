Given /^a book resource$/ do
end

When /^I define a count mock$/ do
  Dupe.define_mocks :book do |define|
    define.count do |mock, records|
      mock.get "/books/count.xml", {}, {:count => records.size}.to_xml
    end
  end
end

When /^I define a find by genre mock$/ do
  Dupe.define_mocks :book do |define|
    define.find_by_genre do |mock, records|
      mock.get "/books.xml?genre=Science+Fiction", {}, (Dupe.find(:books) {|b| b.genre == "Science Fiction"}).to_xml(:root => 'books')
      mock.get "/books.xml?genre=Fantasy", {}, (Dupe.find(:books) {|b| b.genre == "Fantasy"}).to_xml(:root => 'books')
    end
  end
end

When /^(?:I )?stub (\d+) (?:more )?books$/ do |count|
  Dupe.stub(
    :book,
    :template => {:name => 'book'},
    :count    => count.to_i
  )
end

When /^stub (\d+) books with genre "([^\"]*)"$/ do |count, genre|
   Dupe.stub(
    :book,
    :template => {:name => 'book', :genre => genre},
    :count    => count.to_i,
    :sequence => :name,
    :sequence_start_value => (Dupe.find(:books).size+1)
  )
end