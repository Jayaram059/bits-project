import io
import json
import logging
import oci
from fdk import response

def handler(ctx, data: io.BytesIO = None):
    try:
        # Parse the incoming request data
        body = json.loads(data.getvalue()) if data else {}
        text_to_analyze = body.get("text", "")

        if not text_to_analyze:
            raise ValueError("No text provided for language detection.")

        # Set up OCI SDK client
        signer = oci.auth.signers.get_resource_principals_signer()
        ai_client = oci.ai_language.AIServiceLanguageClient(config={}, signer=signer)
        
        # Request to detect dominant language using the provided text
        batch_detect_dominant_language_response = ai_client.batch_detect_dominant_language(
            batch_detect_dominant_language_details=oci.ai_language.models.BatchDetectDominantLanguageDetails(
                documents=[
                    oci.ai_language.models.DominantLanguageDocument(
                        key="doc1",
                        text=text_to_analyze  # Use text from the request body
                    )
                ],
                should_ignore_transliteration=True,
                chars_to_consider=905
            )
        )

        # Extracting data from the API response
        detected_language = batch_detect_dominant_language_response.data.documents[0].languages[0].name
        confidence = batch_detect_dominant_language_response.data.documents[0].languages[0].score

        # Prepare the result data
        result = {
            "detected_language": detected_language,
            "confidence": confidence
        }

        # Return the detected language result in response
        return response.Response(
            ctx, 
            response_data=json.dumps(result),  # Correct use of response_data
            headers={"Content-Type": "application/json"}
        )

    except Exception as ex:
        logging.getLogger().error(f"Error in handler: {str(ex)}")
        return response.Response(
            ctx, 
            response_data=json.dumps({"error": str(ex)}),  # Properly handle error response
            headers={"Content-Type": "application/json"}
        )
