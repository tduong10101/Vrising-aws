data "local_file" "input_template" {
    filename = "${path.module}/vrising-install.tftpl"
}

data "template_file" "input" {
    template = data.local_file.input_template.content
    vars = {
        name = var.name
        game_mode_type = var.game_mode_type
        password = var.password
    }
}