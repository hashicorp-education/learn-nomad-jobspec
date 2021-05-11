job "template" {
  datacenters = ["dc1"]
  type = "batch"

  parameterized {
    meta_required = ["my_name"]
    meta_optional = ["my_title"] 
  }

  group "renderer" {
    task "output" {
      driver = "«driver»"

      config {
        command = "cat"
        args = ["local/out.txt"]
      }

      template {
        destination = "local/out.txt"
        data =<<EOT
This is my template.
Hello {{ if ( env "NOMAD_META_MY_TITLE" ) }}{{ env "NOMAD_META_MY_TITLE" }} {{ end }}{{ env "NOMAD_META_MY_NAME" }}.
EOT
      }
    }
  }
}
