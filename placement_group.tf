resource "aws_placement_group" "cluster" {
  name     = "cluster"
  strategy = "cluster"
}

resource "aws_placement_group" "spread" {
  name         = "spread"
  strategy     = "spread"
  spread_level = "rack"
}

resource "aws_placement_group" "aws_partition" {
  name            = "aws_partition"
  strategy        = "partition"
  partition_count = 4
}