resource "intersight_workflow_workflow_info" "workflow-create-vm" {
  action = "Start"
  associated_object {
    moid = "5ddf03ee6972652d32b94ecd"
    object_type = "organization.Organization"
  }
  name = "Russ VM Deploy Test"
  input = {
    VmName = "test-vm-dev-stuart"
  }
  workflow_definition  {
    moid = "5f748b9d696f6e2d309a582d"
    object_type = "workflow.WorkflowDefinition"
  }

}
