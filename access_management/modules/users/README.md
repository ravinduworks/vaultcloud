#  VaultCloud to Human users Integration


All the modules in this folder integrates Vault to Human Users access integration. 

Each module acts as a separate namespace for group of users, that way we can create isolated environment for each team within the organization. 

### PROVIDING ACCESS TO USERS AND TEAMS:

Google G-Suite simplifies user management and works well along with Google Cloud Platform. Groups claim can be leveraged to authorize a user in VaultCloud by mapping its associated Google G-Suite group with a VaultCloud group. This way the user can be assigned the relevant VaultCloud policy.

Group name should follow three word naming convention, for example: For engineering platform devops team, group name would be `VaultCloud-Engplatform-DevOps` where:
	VaultCloud - Application platform name
	Engplatform - Team’s business unit or Application Service
	DevOps - Within the business unit, team it belongs to.

1. Create a Google Group for a team if it doesn't exist. Refer - https://support.google.com/groups/answer/2464926?hl=en
2. Onboard GSuite group to the VaultCloud. All you have to do is copy one of the existing module with new google cloud group name and update all files accordingly. 


