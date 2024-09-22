import streamlit as st
import requests
import oci
import json

# Function to generate OCI IDCS token using client credentials
def get_oci_idcs_token(client_id, client_secret, idcs_url):
    headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    }
    data = {
        "grant_type": "client_credentials",
        "client_id": client_id,
        "client_secret": client_secret,
        "scope": "https://bits-genai.oracle.com/genai"
    }
    response = requests.post(f"{idcs_url}", headers=headers, data=data)
    if response.status_code == 200:
        token = response.json().get("access_token")
        return token
    else:
        st.error(f"Error fetching IDCS token: {response.status_code}")
        return None

# Function to hit API Gateway with generated token and user input
def call_api_gateway(api_gateway_url, token, user_input):
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
        "teantID": "1234"
    }
    payload = {
        "text": user_input
    }
    response = requests.post(api_gateway_url, headers=headers, data=json.dumps(payload))
    if response.status_code == 200:
        return response.json()
    else:
        st.error(f"API Gateway Error: {response.status_code}")
        return None

# Streamlit app logic
def main():
    # State variable to track login status
    if 'login_status' not in st.session_state:
        st.session_state.login_status = False

# Check login status to determine whether to show login page or main content
    if st.session_state.login_status:
        # Side pane with radio buttons for navigation
        selected_page = st.sidebar.radio(
            "Choose a page",
            ["OCI Lang Detection GenAI Model", "Data Analysis Model", "Model Insights Model"]
        )

        # Based on user selection, load the corresponding page
        if selected_page == "OCI Lang Detection GenAI Model":
            gen_ai_page()
        elif selected_page == "Data Analysis Model":
            data_analysis_page()
        elif selected_page == "Model Insights Model":
            model_insights_page()
    else:
        welcome_page()  # If not logged in, show the welcome page for login

# Welcome page with login form
def welcome_page():
    st.title("Welcome - Login Page")
    idcs_url_options = [
    "https://idcs-e671b59e80c64834b346c2d7a9ca75fb.identity.oraclecloud.com/oauth2/v1/token",  # Replace with real URLs
    "https:///idcs-e671b59e80c64834b346c2d7a9ca75fb.identity.oraclecloud.com/oauth2/v1/token"
]

    # Login form
    with st.form(key="login_form"):
        client_id = st.text_input("User ID")
        client_secret = st.text_input("User Password", type="password")
        idcs_url = st.selectbox("Select Environment To Authenticate", options=idcs_url_options)
        submit_button = st.form_submit_button("Login")

    if submit_button:
        if client_id and client_secret and idcs_url:
            token = get_oci_idcs_token(client_id, client_secret, idcs_url)
            if token:
                st.success("Login successful!")
                # Set the login status to true and store the token in session
                st.session_state.login_status = True
                st.session_state.oci_token = token
                #st.experimental_rerun()
        else:
            st.error("Please fill in all fields.")

# GenAI page with text input and API request
def gen_ai_page():
    st.title("OCI GenAI - Language Detection GenAI Model")

    # Input form for the GenAI page
    with st.form(key="genai_form"):
        user_input = st.text_area("Enter text to findout language type")
        api_gateway_url = st.text_input("API Gateway URL", value="https://b4ebjriwxzdganeq7khjxr42za.apigateway.ap-hyderabad-1.oci.customer-oci.com/v1/genai")
        submit_button = st.form_submit_button("Submit")

    if submit_button:
        if user_input and api_gateway_url:
            # Retrieve the token from session
            token = st.session_state.oci_token
            response = call_api_gateway(api_gateway_url, token, user_input)
            if response:
                st.success("API call successful!")
                st.json(response)
        else:
            st.error("Please provide all required inputs.")

# Additional Page 1: Data Analysis Page
def data_analysis_page():
    st.title("Data Analysis")

    # Simulating a text box and a button for further interaction
    with st.form(key="data_analysis_form"):
        data_input = st.text_area("Enter data for analysis")
        submit_button = st.form_submit_button("Analyze Data")

    if submit_button:
        if data_input:
            st.write(f"Analyzing data: {data_input}")
            # Simulate some data processing here
            st.success("Data analysis completed!")
        else:
            st.error("Please provide data for analysis.")

# Additional Page 2: Model Insights Page
def model_insights_page():
    st.title("Model Insights")

    # Simulating some content to show model insights
    st.write("Here you can display insights from the model.")
    
    # You can load some static information or results here
    insights = {
        "Model Version": "v1.2",
        "Accuracy": "95%",
        "Last Updated": "2024-09-01"
    }

    st.json(insights)  # Displaying the insights in JSON format





# Streamlit app entry point
if __name__ == "__main__":
    main()

