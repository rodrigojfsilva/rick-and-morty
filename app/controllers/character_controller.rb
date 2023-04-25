class CharacterController < ApplicationController
  def index
    search_text = params[:name]
    response =
      RestClient.get(
        "https://rickandmortyapi.com/api/character/?name=#{search_text}"
      )
    json_response = Oj.load(response.body)
    characters = json_response["results"]
    episodes = get_all_episodes

    characters_with_appearances =
      characters.map do |character|
        appearances = get_appearances(character, episodes)
        character.merge(appearances)
      end

    render json: characters_with_appearances
  end

  private

  def get_all_episodes
    response = RestClient.get("https://rickandmortyapi.com/api/episode")
    json_response = Oj.load(response.body)
    json_response["results"]
  end

  def get_appearances(character, episodes)
    appearances = Hash.new(0)

    episodes.each do |episode|
      if episode["characters"].include?(character["url"])
        match = episode["episode"].match(/S(\d{2})E(\d{2})/)
        season = match[1].to_i
        appearances["Season #{season}"] += 1
      end
    end

    { appearances: appearances }
  end
end
