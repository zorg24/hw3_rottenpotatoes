# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    #puts movie

    # Movie.create!(movie) unless Movie.where(:title => movie["title"])
  Movie.create!(:title => movie['title'],
                :rating => movie['rating'],
                :release_date => movie['release_date'])
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # debugger
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "([^"]*)" before "([^"]*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body =~ /#{e1}.*#{e2}/m
end

Then /I should (not )?see the following movies: (.*)/ do |n, movie_list|
  movie_list = movie_list.split(", ")
  if n
    assert !movie_list.any? { |s| page.body.include? s }
  else
    assert movie_list.all? { |s| page.body.include? s }
  end
end

When /I press on the homepage "([^"]*)"/ do |button|
  click_button("ratings_submit") if button == "Refresh"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |rat|
    
    if uncheck
      uncheck("ratings_" + rat)
    else
      check("ratings_" + rat)
    end
  end
end