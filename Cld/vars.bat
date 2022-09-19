@ECHO OFF

REM -------------------------------------
REM COMMON SETTINGS

SET YC_ZONE=ru-central1-a
SET PROFILE_NAME=netology_hw
SET FOLDER_NAME=netology-homeworks
SET NETWORK_NAME=netology-homeworks-network
SET DEFAULT_SUBNET_NAME=netology-homeworks-default-subnet
SET DEFAULT_SUBNET_RANGE="192.168.0.0/24"
SET DEFAULT_SEC_GRP_NAME=netology-default-security-group

REM -------------------------------------
REM SSH-GATEWAY

SET SSH_GATE_SUBNET_NAME=netology-homeworks-ssh-gateway-subnet
SET SSH_GATE_SUBNET_RANGE="192.168.1.0/28"
SET SSH_GATE_SEC_GRP_NAME=netology-ssh-gateway-security-group
SET SSH_GATE_PUB_ADDR_NAME=netology-ssh-gateway-public-address
SET SSH_GATE_FQDN=netology-ssh-gateway