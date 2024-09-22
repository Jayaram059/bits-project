resource "oci_apigateway_gateway" "api_gateway" {
  compartment_id = var.compartment_id
  endpoint_type  = "PUBLIC"
  subnet_id      = var.public_subnet_id
  display_name   = var.api_gateway_name

}


resource "oci_apigateway_deployment" "api_gateway_deployment" {
  compartment_id = var.compartment_id
  gateway_id     = oci_apigateway_gateway.api_gateway.id
  display_name   = "bitsproject_api_deployment"

  path_prefix = "/v1"

  specification {
    logging_policies {
      access_log {
        is_enabled = true
      }
      execution_log {
        is_enabled = true
      }
    }



    request_policies {
      mutual_tls {
        is_verified_certificate_required = false
        allowed_sans                     = []
      }

    }


    routes {
      backend {
        type        = "ORACLE_FUNCTIONS_BACKEND"
        function_id = "ocid1.fnfunc.oc1.ap-hyderabad-1.aaaaaaaar36cvw652cpallxov5hdj2r7xnmz4kuc5xlvesaegduxxh6bxj7a"
      }

request_policies {

  response_cache_lookup {
                    #Required
                    type = "SIMPLE_LOOKUP_POLICY"
  }
}
      response_policies  {
        response_cache_store {
          time_to_live_in_seconds = "30"
          type = "FIXED_TTL_STORE_POLICY"
        }

          }

      path    = "/genai"
      methods = ["ANY"]
  
    }
  }


}





resource "oci_apigateway_deployment" "genai-bits" {
  compartment_id = var.compartment_id
  gateway_id     = oci_apigateway_gateway.api_gateway.id
  display_name   = "bitsproject_api_deployment-bits"
  path_prefix	= "/bits"
  specification {
	request_policies {
  	mutual_tls {
    	is_verified_certificate_required = false
    	allowed_sans                 	= []
  	}
	}
	logging_policies {
  	access_log {
    	is_enabled = true
  	}
  	execution_log {
    	is_enabled = true
  	}
	}

	routes {
  	backend {
    	type    	= "ORACLE_FUNCTIONS_BACKEND"
    	function_id = "ocid1.fnfunc.oc1.ap-hyderabad-1.aaaaaaaar36cvw652cpallxov5hdj2r7xnmz4kuc5xlvesaegduxxh6bxj7a"
  	}
  	request_policies {
    	authorization {
      	type = "AUTHENTICATION_ONLY"
    	}
  	}
  	path	= var.bits_function_api_path
  	methods = ["POST"]
	}
  }

}
output "api_gateway_id" {
  value = oci_apigateway_gateway.api_gateway.id
}

output "api_gateway_endpoint" {
  value = oci_apigateway_deployment.api_gateway_deployment.endpoint
}



