# This is an automatically generated code sample.
# To make this code sample work in your Oracle Cloud tenancy,
# please replace the values for any parameters whose current values do not fit
# your use case (such as resource IDs, strings containing ‘EXAMPLE’ or ‘unique_id’, and
# boolean, number, and enum parameters with values not fitting your use case).

import oci

# Create a default config using DEFAULT profile in default location
# Refer to
# https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File
# for more info
config = oci.config.from_file()


# Initialize service client with default config file
ai_language_client = oci.ai_language.AIServiceLanguageClient(config)


# Send the request to service, some parameters are not required, see API
# doc for more info
batch_detect_dominant_language_response = ai_language_client.batch_detect_dominant_language(
    batch_detect_dominant_language_details=oci.ai_language.models.BatchDetectDominantLanguageDetails(
        documents=[
            oci.ai_language.models.DominantLanguageDocument(
                key="doc1",
                text="Zoom interface is really simple and easy to conduct virtual meetings. It is very easy to share the Zoom link to join the video conference.")],
        should_ignore_transliteration=True,
        chars_to_consider=905))

# Get the data from response
print(batch_detect_dominant_language_response.data)
