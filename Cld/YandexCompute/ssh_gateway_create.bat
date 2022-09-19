@ECHO OFF

IF NOT DEFINED PUB_SSH_KEY_PATH ECHO "'PUB_SSH_KEY_PATH' variable must be defined" && PAUSE && EXIT

IF NOT DEFINED PROFILE_NAME           ECHO "'PROFILE_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED DEFAULT_SUBNET_NAME    ECHO "'DEFAULT_SUBNET_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED SSH_GATE_SEC_GRP_NAME  ECHO "'SSH_GATE_SEC_GRP_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED NETWORK_NAME           ECHO "'NETWORK_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED SSH_GATE_PUB_ADDR_NAME ECHO "'SSH_GATE_PUB_ADDR_NAME' variable must be defined" && PAUSE && EXIT
IF NOT DEFINED SSH_GATE_FQDN          ECHO "'SSH_GATE_FQDN' variable must be defined" && PAUSE && EXIT

yc config profile activate %PROFILE_NAME%

REM -------------------------------------
REM Create a VMinstance for ssh connections in the cloud

yc vpc addr create --name %SSH_GATE_PUB_ADDR_NAME% --description "A public ip4 address for a gateway." --external-ipv4

REM TODO:: create a VM instance
REM https://cloud.yandex.ru/docs/cli/cli-ref/managed-services/compute/instance/create
REM yc compute instance create --name %SSH_GATE_FQDN% --description "A gateway to connect via SSH." --ssh-key %PUB_SSH_KEY_PATH% --network-interface subnet-name=%DEFAULT_SUBNET_NAME%,nat-address=%SSH_GATE_PUB_ADDR_NAME%,nat-ip-version=ipv4