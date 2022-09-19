@ECHO OFF

IF NOT DEFINED SECRET_TOKEN ECHO "'SECRET_TOKEN' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED CLOUD_ID     ECHO "'CLOUD_ID' variable must be defined" && PAUSE && EXIT

IF NOT DEFINED YC_ZONE              ECHO "'YC_ZONE' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED PROFILE_NAME         ECHO "'PROFILE_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED FOLDER_NAME          ECHO "'FOLDER_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED NETWORK_NAME         ECHO "'NETWORK_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED DEFAULT_SUBNET_NAME  ECHO "'DEFAULT_SUBNET_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED DEFAULT_SEC_GRP_NAME ECHO "'DEFAULT_SEC_GRP_NAME' variable must be defined" && PAUSE && EXIT

REM -------------------------------------
REM PROFILE

yc config profile create %PROFILE_NAME%
yc config profile activate %PROFILE_NAME%
yc config set token %SECRET_TOKEN%
yc config set cloud-id %CLOUD_ID%
yc config set folder-name %FOLDER_NAME%
yc config set format yaml
yc config set compute-default-zone %YC_ZONE%

REM -------------------------------------
REM FOLDER
yc resource-manager folder create --name %FOLDER_NAME% --description "A default folder for Netology homeworks" --token %SECRET_TOKEN% --cloud-id %CLOUD_ID%

REM -------------------------------------
REM NETWORK

yc vpc network create --name %NETWORK_NAME% --description "Network for instances and services related to Netology.ru's homework."

REM Default subnet
yc vpc subnet create --name %DEFAULT_SUBNET_NAME% --description "A default subnet." --network-name %NETWORK_NAME% --range "%DEFAULT_SUBNET_RANGE%"

REM SSH gateway subnet
yc vpc subnet create --name %SSH_GATE_SUBNET_NAME% --description "A SSH gateway subnet." --network-name %NETWORK_NAME% --range "%SSH_GATE_SUBNET_RANGE%"

REM -------------------------------------
REM SECURITY GROUPS

REM Default security-group for new instances
yc vpc security-group create --name %DEFAULT_SEC_GRP_NAME% --description "A default cloud interconnection security-group." --network-name %NETWORK_NAME%
yc vpc security-group update-rules --name %DEFAULT_SEC_GRP_NAME% --add-rule "description='Allow any ingress traffic inside the security-group',direction=ingress,port=any,protocol=any,predefined=self_security_group"
yc vpc security-group update-rules --name %DEFAULT_SEC_GRP_NAME% --add-rule "description='Allow any egress traffic inside the security-group',direction=egress,port=any,protocol=any,predefined=self_security_group"

REM SSH gateways
yc vpc security-group create --name %SSH_GATE_SEC_GRP_NAME% --description "A security group for SSH gateways." --network-name %NETWORK_NAME%
yc vpc security-group update-rules --name %SSH_GATE_SEC_GRP_NAME% --add-rule "description='Allow SSH packets from outside.',direction=ingress,port=22,protocol=tcp,v4-cidrs=0.0.0.0/0"

REM Special rules
yc vpc security-group update-rules --name %DEFAULT_SEC_GRP_NAME% --add-rule "description='Allow SSH inbound traffic from SSH gateway.',direction=ingress,port=22,protocol=tcp,security-group-name=%SSH_GATE_SEC_GRP_NAME%"
yc vpc security-group update-rules --name %SSH_GATE_SEC_GRP_NAME% --add-rule "description='Allow SSH connection to local cloud resources.',direction=egress,port=22,protocol=tcp,security-group-name=%DEFAULT_SEC_GRP_NAME%"
REM At day 19 of September, 2022, "security-group-name" doesn't work. Use security-group-id instead
REM yc vpc security-group update-rules --name %DEFAULT_SEC_GRP_NAME% --add-rule "description='Allow SSH inbound traffic from SSH gateway.',direction=ingress,port=22,protocol=tcp,security-group-id="
REM yc vpc security-group update-rules --name %SSH_GATE_SEC_GRP_NAME% --add-rule "description='Allow SSH connection to local cloud resources.',direction=egress,port=22,protocol=tcp,security-group-id="