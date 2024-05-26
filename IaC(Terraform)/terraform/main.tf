provider "aws" {
  region = "us-west-2"  # Change to your desired region
}

resource "aws_iam_role" "emr_role" {
  name = "EMR_DefaultRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "elasticmapreduce.amazonaws.com"
      },
      Effect = "Allow",
      Sid = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "emr_attach" {
  role       = aws_iam_role.emr_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

resource "aws_iam_role_policy_attachment" "s3_readonly_attach" {
  role       = aws_iam_role.emr_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "emr_instance_profile" {
  name = "EMR_EC2_DefaultRole"
  role = aws_iam_role.emr_role.name
}

resource "aws_emr_cluster" "emr_cluster" {
  name          = "EMR-Cluster"
  release_label = "emr-6.4.0"
  applications  = ["Hadoop", "Spark"]
  service_role  = aws_iam_role.emr_role.arn
  instances {
    instance_group {
      instance_type = "m5.xlarge"
      instance_count = 1
      instance_role = "MASTER"
    }
    instance_group {
      instance_type = "m5.xlarge"
      instance_count = 2
      instance_role = "CORE"
    }
  }
  ec2_attributes {
    instance_profile = aws_iam_instance_profile.emr_instance_profile.arn
  }

  step {
    name = "Spark Application"
    action_on_failure = "CONTINUE"
    hadoop_jar_step {
      jar = "command-runner.jar"
      args = [
        "spark-submit",
        "--master", "yarn",
        "s3://path-to-your-script/ETL_jobs.py"  # Change to your S3 path
      ]
    }
  }
}

resource "null_resource" "delete_cluster" {
  provisioner "local-exec" {
    command = <<EOT
      aws emr terminate-clusters --cluster-ids ${aws_emr_cluster.emr_cluster.id}
    EOT
  }

  triggers = {
    cluster_id = aws_emr_cluster.emr_cluster.id
  }

  depends_on = [aws_emr_cluster.emr_cluster]
}
