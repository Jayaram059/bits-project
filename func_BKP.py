#
# hello-python version 1.0.
#
# Copyright (c) 2020 Oracle, Inc.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
#

import io
import json
import os

from fdk import response
from openai import OpenAI


def callOpenAPI():
    client = OpenAI()

    os.environ['OPENAI_API_KEY'] = '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'

    completion = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {
                "role": "user",
                "content": "Write a haiku about recursion in programming."
            }
        ]
    )
    print(completion.choices[0].message)
    
def handler(ctx, data: io.BytesIO=None):
    print("Entering Python Hello World handler", flush=True)
    name = "World"
    try:
        body = json.loads(data.getvalue())
        print(body)
        name = body.get("tenantId")
    except (Exception, ValueError) as ex:
        print(str(ex), flush=True)

    print("Vale of name = ", name, flush=True)
    print("Exiting Python Hello World handler", flush=True)
    return response.Response(ctx, response_data=callOpenAPI())
   # return response.Response(
   #     ctx, response_data=json.dumps(
   #         {"message": "Hello {0}".format(name)}),
   #     headers={"Content-Type": "application/json"}
    #)