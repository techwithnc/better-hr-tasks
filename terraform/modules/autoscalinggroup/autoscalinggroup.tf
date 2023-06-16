resource "aws_launch_configuration" "lcfg01" {
  name_prefix     = "anco-ec2-"
  associate_public_ip_address = true
  image_id        = "ami-0df7a207adb9748c7"
  instance_type   = "${var.ec2_type}"
  user_data       = file("user-data.sh")
  security_groups = ["${var.security_gp_1}"]

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "autogp01" {
  name                 = "autoscaling_group"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.lcfg01.name
  vpc_zone_identifier  = ["${var.public_subnet_id_1}", "${var.public_subnet_id_2}"]
  health_check_type = "ELB"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Env" 
    value               = "testing"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_policy" "scalup" {
  autoscaling_group_name = aws_autoscaling_group.autogp01.name
  name = "scaling-up"
  policy_type = "SimpleScaling"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown = 300
}
resource "aws_cloudwatch_metric_alarm" "scalup-alarm" {
  alarm_name = "scalup-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "60"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autogp01.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.scalup.arn ]
}
resource "aws_autoscaling_policy" "scaldown" {
  autoscaling_group_name = aws_autoscaling_group.autogp01.name
  name = "scaling-down"
  policy_type = "SimpleScaling"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown = 300
}
resource "aws_cloudwatch_metric_alarm" "scaldown-alarm" {
  alarm_name = "scaldown-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "10"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autogp01.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.scaldown.arn ]
}
resource "aws_autoscaling_attachment" "attach01" {
  autoscaling_group_name = aws_autoscaling_group.autogp01.id
  lb_target_group_arn   = "${var.lb_tg_arn}"
}