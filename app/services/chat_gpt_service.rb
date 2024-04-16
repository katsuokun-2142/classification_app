class ChatGptService

  def initialize
    @openai = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_ACCESS_TOKEN"))
  end

  def chat(prompt)
    response = @openai.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required. # 使用するGPT-3のエンジンを指定
        response_format: { type: "json_object" }, # JSONモード
        # messages: [{ role: "system", content: "You are a helpful assistant. response to japanese" }, { role: "user", content: prompt }],
        messages: [
          {
              role: "system",
              # content: "あなたは優秀なアシスタントです。あなたはあらゆるジャンルのクイズを作ることが出来ます。日本語で回答してください。lang:ja。{questions: [{question: '問題', options:['回答1', '回答2', '回答3', '回答4'], answerIndex: 0},...]}のJSON形式で返却してください。"
              # content: "You are an excellent assistant. Please answer in Japanese and return in JSON format with {message: 'message'}."
              content: "You are an excellent assistant. You can categorize the content of any site. You may also summarize the site in 140 characters or less. Please provide no more than 3 subcategories of output.
                        Please answer in Japanese and return in JSON format with {category: 'category', summary_text: 'summary text', sub_categories: ['sub_category1', 'sub_category2', 'sub_category3']}."
          },
          {
              role: "user",
              # content: "ジャンル「{genre}」に関するクイズを、{num_questions}問作ってください。{num_options}択クイズでお願いします."
              # content: "#{prompt}"
              content: "Please classify and summarize the site in the URL. URL: `#{prompt}`"
          }],
        temperature: 0.7, # 応答のランダム性を指定
        max_tokens: 200,  # 応答の長さを指定
      },
      )
    # response['choices'].first['message']['content']
    JSON.parse(response['choices'].first['message']['content'],symbolize_names: true)
  end
end
