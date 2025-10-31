terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/75643650/terraform/state/nonprod"
    lock_address   = "https://gitlab.com/api/v4/projects/75643650/terraform/state/nonprod/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/75643650/terraform/state/nonprod/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
}