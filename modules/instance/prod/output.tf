output "webserver_instances_private_ips" {
    value       =   aws_instance.webserver.private_ip
}

output "webserver_instances_ids" {
    value       =   aws_instance.webserver.id
}

