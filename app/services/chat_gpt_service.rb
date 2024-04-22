class ChatGptService
  def initialize
    @openai = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN'))
  end

  def chat(prompt)
    response = @openai.chat(
      parameters: {
        model: 'gpt-3.5-turbo', # Required. # 使用するGPT-3のエンジンを指定
        response_format: { type: 'json_object' }, # JSONモード
        messages: [
          {
            role: 'system',
            content: "You are an excellent assistant.
                      You can categorize the content of any site.
                      You may also summarize what the site content in 140 characters or less.
                      Please provide no more than 3 subcategories of output.
                      Please answer in Japanese and return in JSON 
                      format with {category: 'category', summary_text: 'summary text', sub_categories: ['sub_category1', 'sub_category2', 'sub_category3']}.
                      If you can't classify or summarize return `{category: 'その他', summary_text: 'Could not summarize', sub_categories: ['その他']}`."
          },
          {
            role: 'user',
            content: "Good boy! Please classify and summarize the site in the URL. URL: `#{prompt}`"
          }
        ],
        temperature: 0.7, # 応答のランダム性を指定
        max_tokens: 200   # 応答の長さを指定
      }
    )
    JSON.parse(response['choices'].first['message']['content'], symbolize_names: true)
  end
end
