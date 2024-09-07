resource "oci_functions_application" "function_app" {
  display_name   = var.function_app_name
  compartment_id = var.compartment_id
  subnet_ids     = [var.public_subnet_id]
}

resource "oci_functions_function" "function" {
  display_name   = var.function_name
  application_id = oci_functions_application.function_app.id
  image          = var.function_image
  memory_in_mbs  = 128
  timeout_in_seconds = 30
}


output "function_id" {
  value = oci_functions_function.function.id
}

