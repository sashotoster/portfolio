# Usage example:
# ./query.rb 30 https://www.reddit.com/r/personalfinance/comments/owhy0r/leverage_through_leaps_for_the_diy_investor/

require 'pry'
require 'scylla' # https://github.com/hashwin/scylla
require 'nlp_pure/segmenting/default_word'  # https://github.com/parhamr/nlp-pure
require 'nlp_pure/segmenting/default_sentence'
require 'json'

module Model
  extend self

  ENDPOINT_ID="6503919141550817280"
  PROJECT_ID="reddit-trend"

  def get_estimate(post_data)
    post = JSON.parse(post_data).first['data']["children"].first['data']
    passed_days = ((Time.now.to_i - post["created_utc"]).to_f / (60*60*24).to_f).ceil

    if post['archived'] || passed_days >= 180
      {days: 0, expected_rating: post['score'].to_i}
    else
      target_days = 180 - passed_days
      query_data = prepare_data(post, passed_days, target_days)
      google_response = query_google(query_data)
      expected_rating = post['score'].to_i + JSON.parse(google_response)['predictions'].first['value'].to_i
      {will_be_archived_in_days: target_days, expected_rating: expected_rating}
    end
  end

  private
  def query_google(data)
    `curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" \
    https://europe-west4-aiplatform.googleapis.com/v1/projects/#{PROJECT_ID}/locations/europe-west4/endpoints/#{ENDPOINT_ID}:predict \
    -d "#{data}"`
  end

  def get_passed_days(post)
    (Time.now.to_i - post["created_utc"]) / (60*60*24)
  end

  def post_valid?
    passed_days = (Time.now.to_i - post["created_utc"]) / (60*60*24)
    post['archived'] || passed_days + target_days > 180
  end

  def prepare_data(post, passed_days, target_days)
    {
      'instances' => [{
        'target_days' => target_days,
        'passed_days' => passed_days,
        'current_score' => post['score'],
        'upvote_ratio' => post['upvote_ratio'],
        'nsfw' => post['thumbnail'] == 'nsfw',
        'spoiler' => post['spoiler'],
        'over_18' => post['over_18'],
        'distinguished' => !!post['distinguished'],
        'gilded' => post['gilded'],
        'num_comments' => post['num_comments'],
        'media_only' => post['media_only'],
        'any_media' => !!post['media'] || !!post['media_embed'].any? || !!post['secure_media'] || !!post['secure_media_embed'].any?,
        'locked' => post['locked'],
        'hide_score' => post['hide_score'],
        'stickied' => post['stickied'],
        'contest_mode' => post['contest_mode'],
        'subscribers' => post['subreddit_subscribers'],
        'is_english' => (post['title'] + ' ' + post['selftext']).language == 'english',
        'title_symbols' => post['title'].gsub(/\s+/, "").size,
        'title_words' => NlpPure::Segmenting::DefaultWord.parse(post['title']).size,
        'body_symbols' => post['selftext'].gsub(/\s+/, "").size,
        'body_words' => NlpPure::Segmenting::DefaultWord.parse(post['selftext']).size,
        'body_sentences' => NlpPure::Segmenting::DefaultSentence.parse(post['selftext']).reject { |c| c.empty? }.size,
       }.transform_values{|v| "\"#{v}\""}]
    }.to_json
  end

end



