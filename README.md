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