# Management EKS Cluster 생성용 IaC Repository

ⓘ 목적 : 관리용 EKS Cluster / 관리용 Admin Server / 관리용 Bastion Server를 Provisioning 하기위해 IaC를 도입 및 운영에 활용한다.

## IaC Terraform 수행
 - IaC Code 수행내역    
   관리용 VPC 및 Subnet, Route Table, Nat/Internet Gateway 생성 및 설정    
   관리용 EKS Cluster / EKS Node Group 생성 및 설정    
   관리용 Admin Server(kubectl 수행용) 생성, tree, unzip, awscli, terraform, kubectl 설치    
   
<br>

### 1. AWS EC2 **Key Pair**를 생성한다.

- Bastion/Admin Server 접속에 필요한 key 를 생성하고, 해당 key를 다운로드 받아 저장한다.    
- key는 분실에 유의하여 개인 로컬에 관리한다.

![](images/create_key_pair.png)

> |항목|내용|
> |---|---|
> |➕ Key pair name | `MyKeyPair` 입력 |

<br>

### 2. AWS Region 설정한다.

- 아래 예시는 ap-northeast-2(Seoul) 리젼에서 진행
- 아래 예시는 ap-northeast-2(Seoul) 리젼 내 Ubuntu 20.04 LTS 운영체제    
  AMI ID : ami-0ea5eb4b05645aa8a
- terraform.tfvars

```bash
1 aws_region = "ap-northeast-2"           # 개인이 사용할 리젼으로 변경
2 my_ami     = "ami-0ea5eb4b05645aa8a"    # 개인이 사용할 리젼의 Ubuntu, 20.04 LTS x86 운영체제 AMI ID로 변경
3 my_keypair = "MyKeyPair"                # 변경하지 않고 그대로 사용
```

<br>

### 3. Terraform IaC 실행

- 아래 예시는 ubuntu home 디렉토리 내 ehop-mgmt-IaC git repository를 생성하였다는 가정

<br>

```bash
cd ~/eshop-mgmt-IaC
```
```bash
terraform init
```
```bash
terraform plan
```
```bash
terraform apply
```
<br>

### 4. Argocd 설치

<br>

Argocd Container Install
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.0.4/manifests/install.yaml
kubectl patch service argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```
<br>

Argocd cli Install
```bash
VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
sudo curl --silent --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd
```
<br>

Argocd 초기 Password 확인
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
<br>

Argocd endpoint 확인
```bash
kubectl get service -n argocd
```

<br>
