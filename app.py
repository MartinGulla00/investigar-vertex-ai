import vertexai
from vertexai.generative_models import GenerativeModel
from database_schema_reparaciones import context
# from database_schema_damap import context

def remove_formatting(text):
    return text.replace("```sql", "").replace("```", "")

if __name__ == '__main__':
    print("initializing vertex ai")
    project_id = "vertex-ai-434320"
    vertexai.init(project=project_id, location="us-east1")
    model = GenerativeModel(model_name="gemini-1.5-flash-001", system_instruction=[
        "You are a MySQL expert that generates SQL queries based on a database schema and a user's natural language input provided.",
        "Read the user input carefully and create a syntactically correct MySQL query to retrieve the data needed from the database to answer the user's question.",
        "Ensure that you incorporate all relevant details, such as specific dates, from the user's input in the SQL query.",
        "Provide only the SQL query as a single block code with no explanation or extra information.",
        "Always prioritize retrieving descriptive fields such as `name` or `description` instead of IDs, to make the query results more understandable and user-friendly.",
        "Never query for all columns from a table. You must query only the columns that are needed to answer the question.",
        "Double-check that all columns used in the query exist in the table schema provided. Be careful to not query for columns that do not exist. Also, pay attention to which column is in which table.",
        "Double-check that all columns used in the query exist in the table schema provided. Be careful to not query for columns that do not exist. Also, pay attention to which column is in which table.",
        f"Database Schema: \n {context}",
        f"User Input: \n {context}",
        "Remember, avoid explaining and commenting the query. Return ONLY the query in a SINGLE CODE BLOCK.",
        "Let’s think step by step.",
    ])
    chat = model.start_chat()
    question = input("Enter question: ")

    response = chat.send_message(question).text
    # print(f"""Response \n{response}""")
    sql = remove_formatting(response)
    print(f"""SQL \n{sql}""")
    # sql = remove_formatting(chat.send_message(f"""Given the following database schema: {context}\n Is the following SQL right for that schema? {sql} \n Return only the SQL or the SQL with the necessary corrections""").text)
    # print(f"""Second SQL \n{sql}""")