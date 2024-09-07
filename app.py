import vertexai
from vertexai.generative_models import GenerativeModel

if __name__ == '__main__':
    print("initializing vertex ai")
    project_id = "vertex-ai-434320"
    vertexai.init(project=project_id, location="us-east1")
    model = GenerativeModel(model_name="gemini-1.5-flash-001", system_instruction=[
        "Only return SQL queries, if you can't generate a SQL query with the given context and the question, return an empty string.",
        "You are a data analysis expert.",
        """This are the tables in the database, their columns, and the description of the columns:
        ' Table name - Column name - Description
        ' productos - id - It's the id of the product 
        ' productos - nombre - It's the name of the product 
        ' productos - precio_unitario - It's the price per unit of the product
        ' ventas - id - It's the id of a sale made to a customer
        ' ventas - id_producto - It's the product id that was purchased
        ' ventas - cantidad - its how many of the product where made
        ' ventas - fecha_venta - its when the purchase was made
        ' ventas - id_cliente - its the id of the customer that bought the product
        ' clientes - id - its the id of the customer
        ' clientes - nombre - its the name of the customer"""
    ])
    question = "Cuales son los clientes que compraron la mayor cantidad de productos distintos?"
    print(question)
    
    response = model.generate_content(question)

    print(response)