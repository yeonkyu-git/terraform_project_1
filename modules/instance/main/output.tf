output "bastion_instances_public_ip" {
    value       =   aws_instance.bastion.public_ip
}

output "bastion_instance_private_ip" {
    value       =   aws_instance.bastion.private_ip
}

output "webserver_instances_ids" {
    value       =   aws_instance.webserver.*.id
}

output "webserver_instances_private_ips" {
    value       =   aws_instance.webserver.*.private_ip
}