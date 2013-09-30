# Example of model definition:
#
#define 'User', ->
#  property 'email', String, index: true
#  property 'password', String
#  property 'activated', Boolean, default: false
#

Task = describe 'Task', ->
    property 'description', String
    property 'completed', Boolean
    property 'updated_at', Date
    set 'restPath', pathTo.tasks

