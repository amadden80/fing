require 'bundler/setup'
Bundler.require

require 'open-uri'

get '/:junk' do
	redirect "/?fing-url=#{params['junk']}"
end


get '/' do 

	@message = 'Welcome...'

	if params['fing-url']
		url = params['fing-url']

		if url[0..3] != 'http'
			url = "http://#{url}"
		end

		begin
			response = Nokogiri::HTML(open(url))

			html = response.to_html

			html.gsub!(' the ', ' the fucking ')
			html.gsub!('The ', 'The fucking ')
			html.gsub!(' a ', ' a fucking ')
			html.gsub!('A ', 'A fucking ')
			html.gsub!(' an ', ' a fucking ')
			html.gsub!(' this ', ' this fucking ')
			html.gsub!(' his ', ' his fucking ')
			html.gsub!(' her ', ' her fucking ')
			html.gsub!(' my ', ' my fucking ')
			html.gsub!('Your ', 'Your fucking ')
			html.gsub!(' your ', ' your fucking ')

			html.gsub!("'/", '"'+url+'/')
			html.gsub!('"/', '"'+url+'/')
			html.gsub!('<img src="', '<img src="'+url+'/')

			return html

		rescue 
			@message = "That didn't work.  Try something else..."
		end
		
	end


	erb :index
end

