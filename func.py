import io
import json
import logging
import oci
from fdk import response

def handler(ctx, data: io.BytesIO = None):
    try:
           # Set up OCI SDK client
        signer = oci.auth.signers.get_resource_principals_signer()
        ai_client = oci.ai_language.AIServiceLanguageClient(config={}, signer=signer)
        
        # Send the request to service, some parameters are not required, see API
        # doc for more info
        batch_detect_dominant_language_response = ai_client.batch_detect_dominant_language(
            batch_detect_dominant_language_details=oci.ai_language.models.BatchDetectDominantLanguageDetails(
                documents=[
                    oci.ai_language.models.DominantLanguageDocument(
                        key="doc1",
                        text="Zoom interface is really simple and easy to conduct virtual meetings. It is very easy to share the Zoom link to join the video conference.")],
                should_ignore_transliteration=True,
                chars_to_consider=905))

        # Get the data from response
        print(batch_detect_dominant_language_response.data)

        # Return the detected language result
        return response.Response(
            ctx, 
            batch_detect_dominant_language_response=json.dumps({
                "detected_language": response.data.languages[0].name,
                "confidence": response.data.languages[0].score
            }),
            headers={"Content-Type": "application/json"}
        )
    except Exception as ex:
        logging.getLogger().error(f"Error in handler: {str(ex)}")
        return response.Response(
            ctx, 
            batch_detect_dominant_language_response=json.dumps({"error": str(ex)}),
            headers={"Content-Type": "application/json"}
        )
