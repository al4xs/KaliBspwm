import openai

openai.api_key = "sk-FWrY6osXeq1NRSQs2szUT3BlbkFJb7UqvFasdfasdfasdf"

while True:
	# Set up the model and prompt
	model_engine = "text-davinci-003"
	prompt = input("\n\r\n$ ")

	# Generate a response
	completion = openai.Completion.create(
	    engine=model_engine,
	    prompt=prompt,
	    max_tokens=2048,
	    n=1,
	    stop=None,
	    temperature=0.5,
	)

	response = completion.choices[0].text
	print(response)
