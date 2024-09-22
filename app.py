import vertexai
from vertexai.generative_models import GenerativeModel
from database_schema_reparaciones import context
# from database_schema_damap import context
from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "http://localhost:5174"}})

@app.route('/transform-query', methods=['POST'])
def transform_query():
    data = request.json
    sql_query = ask_vertex_for_query(data.get("schema"), data.get("query"))
    return jsonify({"sqlQuery": sql_query})


def remove_formatting(text):
    return text.replace("```sql", "").replace("```", "")

def ask_vertex_for_query(schema, question):
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
        # f"Database Schema: \n {context}",
        f"Database Schema: \n {schema}",
        # f"User Input: \n {context}",
        "Remember, avoid explaining and commenting the query. Return ONLY the query in a SINGLE CODE BLOCK.",
        "Let’s think step by step.",
    ])

    response = model.generate_content(f"User Input: \n {question}")

    return remove_formatting(response.text)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8001)