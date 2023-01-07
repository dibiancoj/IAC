variable "main_queue_name" {
  description = "Main queue name"
  type        = string
}

variable "dead_letter_queue_name" {
  description = "Deadletter queue name"
  type        = string
}

variable "how_many_failures_before_going_to_dead_letter" {
  description = "How many failures before going to the dead letter queue"
  type        = number
}

variable "sns_topic_name_for_dead_letter" {
  description = "Name of the sns topic when a dead letter is created"
  type        = string
}

variable "emails_to_send_on_failure" {
  description = "Email to send on failure"
  type        = set(string)
}

variable "cloud_watch_dead_letter_alarm_name" {
  description = "Cloud watch dead letter alarm name"
  type        = string
}
