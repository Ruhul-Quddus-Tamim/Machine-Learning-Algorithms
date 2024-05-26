from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
    'retries': 1,
}

dag = DAG(
    'ETLJob',
    default_args=default_args,
    description='Run Goodreads ETL with EMR',
    schedule_interval=None,
)

create_cluster_and_run_job = BashOperator(
    task_id='create_cluster_and_run_job',
    bash_command='cd /path-to-your-terraform-directory && terraform apply -auto-approve',
    dag=dag,
)

"""

Rest of the ETL jobs' tasks goes here

"""

delete_cluster = BashOperator(
    task_id='delete_cluster',
    bash_command='cd /path-to-your-terraform-directory && terraform destroy -auto-approve',
    dag=dag,
)

create_cluster_and_run_job >> delete_cluster
