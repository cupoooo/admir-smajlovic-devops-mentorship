*U ovom fajlu se nalaze svi koraci u izvrsavanju worksop-a kao i slike koje potvrdjuju izvrsavanje ovog task-a*

# Sta cemo nauciti nakon zavrsetka ovog workshop-a

- Nakon zavrsetka ovog workshopa cemo nauciti kako da radimo sa AWS Code servisima kao sto su:

  - AWS CodeCommit as a Git repository
  - AWS CodeArtifact as a managed repository
  - AWS CodeBuild as a way to run tests and produce software packages
  - AWS CodeDeploy as a deployment service
  - AWS CodePipeline as a product to create automated CI/CD pipeline

Tokom prolazska kroz ovaj workshop koristit cemo takodjer i AWS Cloud9 servis koji sluzi kao cloud based IDE koji nam omogucava da editujemo, pokrecemo i debug-iramo kod koristeci samo browser.

# Vrijeme zavrsetka ovog workshop-a

- 3-5 sati

# Postupci prolazska kroz ovaj workshop

## Podesavanje okruzenja

- Prvo kreiramo environment koristeci AWS Cloud9 IDE

![slika](Images/Creating%20enviroment.png)

- Takodjer je kreirana i instanca
![slika](Images/Created%20instances.png)

## Kreiranje Web aplikacije

### Instaliranje Maven-a i Jave

>Apache Maven je alat za automatizaciju koji se koristi u Java projektima. U ovom workshop-u koristi cemo Maven za inicijalizaciju nase jesnostavne aplikacije i zapakovat cemo je u Web Application Archive (WAR) fajl.

1. Instaliramo Apache Maven koristeci komande:
```bash
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

2. Maven dolazi sa Java 7. Za nas build nam je potreban Java 8 pa cemo instalirati Java 8

```bash
sudo amazon-linux-extras enable corretto8
sudo yum install -y java-1.8.0-amazon-corretto-devel
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64
export PATH=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64/jre/bin/:$PATH
```
 Provjeravamo da li je instalirana Java 8 i Maven:

 ![slika](Images/Java%20and%20Maven%20versions.png)


 ### Kreiranje aplikacije
 
 1. Koristimo `mvn` za generisanje jednostavne Java web aplikacije

 ![slika](Images/Screenshot_1.png)

 Zatim provjerimo da li imamo index.jsp i pom.xml fajlove

 Izmjenimo index.jsp fajl gdje izmjenimo HTML kod po nasoj zelji 


 ## Koristenje AWS CodeCommit

- Podesit cemo CodeCommit repository da nam cuva Java kod

### Kreiranje repozitorija

- Unutar CodeCommit konzole kreiramo repozitorij pod nazivom `unicorn-web-project`

Iz clone URL kopiramo `Clone HTTPS` te link sacuvamo za kasnije

### Commitovanje koda

1. Unutar Cloud9 okruzenja podesimo Git:

```bash
git config --global user.name "cupoooo"
git config --global user.email admirsmajlovic703@gmail.com
```

![slika](Images/Setting%20up%20git.png)

2. Moramo biti unutar putanje `/environment/unicorn-web-project` i uraditi: 

```bash
cd ~/environment/unicorn-web-project
git init -b main
git remote add origin https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/unicorn-web-project
```

3. Commitamo i pushamo kod

```bash
git add *
git commit -m "Initial commit"
git push -u origin main
```

[slika](Images/Pushing%20on%20git.png)

Unutar CodeCommita imamo kreirane:

![slika](Images/CodeCommit%20files.png)

## AWS CodeArtifact

U ovom workshop-u cemo instalirati CodeArtifact repozitorij koji cemo koristiti tokom build faze sa CodeBuild-om da fetch-ujemo Maven pakete sa javnog repozitorija za pakete.

### Kreiranje domena i repozitorija

- Kreiramo prvo domenu sa imenom `unicorns`

Kreirana unicorns domena:

![slika](Images/Creating%20domain.png)

- Zatim kreiramo repizitorij za domen pod nazivom `unicorn-packages`

![slika](Images/Creating%20repository.png)

Kreirana su dva repozitorija:

![slika](Images/Created%20repositories.png)


### Konektovanje CodeArtifact repozitorija

Pratimo korake u workshop-u te ispravimo settings .xml fajl

```bash
cd ~/environment/unicorn-web-project
echo $'<settings>\n</settings>' > settings.xml 
```

![slika](Images/Creating%20settings.xml.png)

### Testiranje sa Cloud9

- Provjerimo da li aplikacija moze biti uspjesno kompajlirana lokalno u Cloud9 koristenjem settings fajla:

`mvn -s settings.xml compile`

![slika](Images/Screenshot_2.png)

Ako je build bio uspjesan trebali bi vidjeti unicorn-packages repozitorij. Ovo znaci da su skinuti sa javnog repozitorija i sada su dostupni unutar CodeArtifact-a

![slika](Images/Created%20unicorn%20packages.png)


### IAM policy za CodeArtifact

Prije nastavka na sljedeci lab, moramo prvo definisati IAM policy tako da drugi servisi mogu koristiti nas novokreirani CodeArtifact repozitoriji.

![slika](Images/Codeartifact%20policy.png)


## AWS CodeBuild

- AWS CodeBuild je potpuno kontrolisan integracijski servis koji compajlira izvorni kod, odradjuje testove i pravi softverske pakete koji su spremni za deployment.

- Zatim kreiramo S3 Bucket sa imenom `unicorn-build-artifacts-08051998` jedinstvenog imena

### Kreiranje CodeBuild projekta

- Kreiran je `unicorn-web-build` projekat

![slika](Images/CodeBuild%20project.png)

### Kreiranje buildspec.yml fajla

- Sada kada imamo spreman build projekat moramo mu dati neke instrukcije kako da kreira nasu aplikaciju. Da to uradimo koristit cemo buildspec.yml (YAML) fajl.

 Kreiran je file `buildspec.yml`
```bash
cd /environment/unicorn-web-project/
touch buildspec.yml
```
Otvorimo ovaj fal i kopiramo kod koji smo dobili:

![slika](Images/buildspec.yml.png)

Onda commitamo i push-amo na CodeCommit

![slika](images/Pushing%20on%20git%202.png)

- Zatim roli `codebuild-unicorn-web-build-service-role` koju smo kreirali kroz CodeBuild projekat dodijelimo policy koji smo kreirali u prethodnom zadatku `codeartifact-unicorn-consumer-policy`


### Testiranje build projekta

1. U AWS konzoli trazimo CodeBuild service

2. Selektujemo unicorn-web-build project i onda selektujemo Start build > Start now

Moguce je da se pojavi Error pa u fajlu buildspec.yml umjesto `correto8` promijenimo u `correto17` te nakon ponovnog pokretanja build-a sve je kako treba.

![slika](Images/Succeeded%20build.png)

- Logovi su takodjer sacuvani kao zip file unutar naseg S3 bucket-a

![slika](Images/Saved%20as%20a%20zip%20file.png)

## AWS CodeDeploy

- Koristit cemo CodeDeploy da instaliramo nas Java WAR paket na Amazon EC2 instancu koristeci Apache Tomcat

Instancu kreiramo pomocu CF template koji nam je provajdan kao `ec2-cfn.yaml`

Kreiran je stack:

![slika](Images/Unicorn%20Stack.png)

Kreirana je i instanca `UnicornStack::WebServer`:

![slika](Images/Unicorn%20Instance.png)


### Kreiranje skripti za pokretanje aplikacije

- Ovdje cemo kreirati nekoliko bash skripti na nasem Git repozitoriju. CodeDeploy koristi ove skripte da instalira i deploy-a aplikaciju na EC2 instancu.

- Kreiramo folder `scripts` i potrebne skripte

![slika](Images/Creating%20script%20files.png)

Zatim editujemo `buildspec.yaml` u dijelu artifacts

```bash
version: 0.2

phases:
  install:
    runtime-versions:
      java: corretto17
  pre_build:
    commands:
      - echo Initializing environment
      - export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain unicorns --domain-owner 828462330928 --query authorizationToken --output text`
  build:
    commands:
      - echo Build started on `date`
      - mvn -s settings.xml compile
  post_build:
    commands:
      - echo Build completed on `date`
      - mvn -s settings.xml package
artifacts:
  files:
    - target/unicorn-web-project.war
    - appspec.yml # ovaj dio je dodat
    - scripts/**/* # ovaj dio je dodat
  discard-paths: no
  ```

Promjene sacuvamo u CodeCommit:

![slika](Images/Pushing%20on%20git%203.png)

Nakon ponovnog pokretanja Buidl procesa sa izmjenama ovo je outpit:

![slika](Images/New%20build%20with%20added%20changes.png)

### Kreiranje CodeBuild IAM Role

- Kreiramo rolu pod nazivom `UnicornCodeDeployRole`

![slika](Images/Unicorn%20Code%20Deploy%20Role.png)

### Kreiranje Deployment grupe

- Deployment grupa koja sadrzi opcije i konfiguracije koje se koriste tokom deployment-a. Definise npr. da nas deployment treba da targetuje EC2 instancu

Deployment grupa je kreirana:

![slika](Images/Deployment%20group.png)


### Kreireanje Deploymenta

Deployment je kreiran:

![slika](Images/Created%20deployment.png)


## AWS CodePipeline

- AWS CodePipeline je potpuno upravljan kontinuirani servis isporuke koji pomaze u automatizaciji pipeline-a za brzo i pouzdano unapredjivanje aplikacija i infrastrukture. 

- Kreiramo Pipeline sa nazivom `unicorn-web-pipeline`

![slika](Images/Code%20Pipeline.png)

Sada imamo fully managed CI/CD pipeline

Testiramo da li radi sve kako treba:

1. Vratimo se na Cloud9 okruzenje

2. Updejtujemo index.jsp sa novim html kodom te kreiramo images folder i dodamo sliku koja je pruzena od strane workshop-a

3. Zatim pratimo promjene na CodePipline te je deployment uspjesno prosao

Webserver instanca izgleda ovako:

![slika](Images/Working%20instance.png)

### Update CloudFormation stack

- Uradimo update naseg stack-a na nacin da dodamo novi template `ec2-cfn-cp-ext.yaml`

![slika](Images/Update%20stack.png)


### Kreiranje SNS topic-a

- Kreiramo SNS topic pod nazivom `unicorn-pipeline-notifications` i kreiramo subscription za email.

![slika](Images/Created%20SNS.png)

- Potvrdimo email i sada je status Confirmed:

### Update CodePipeline

- Dodani su novi stages sa akcijama kako je navedeno u workshop-u

![slika](Images/Screenshot_3.png)

Nakon toga ce nam na email doci approval

![slika](Images/Approval.png)



## Cleanup

### Delete CloudFormation stack
- Obrisemo `UnicornStack` - brise se VPC, subnet i EC2 instance

### Delete the Cloud9 environment
- Obrisemo `UnicornIDE`

### Delete CodePipeline
- Obrisemo `unicorn-web-pipeline`

### Delete the CodeCommit repository
- Obrisemo `unicorn-web-project`

### Delete the CodeArtifact repository and domain
- Obrisati u `Repositories` -> `maven-central-store`, ` unicorn-packages`
- Obrisati u `Domain` -> `unicorn`

### Delete CodeBuild projects
- Obrisati `unicorn-web-build`

### Delete CodeDeploy application
- Obrisati u `Applications`- `unicorn-web-deploy`

### Delete SNS topic and subscription
- Obrisati Topics `unicorn-pipeline-notifications`
- Obrisati Subscription 

### Delete artifact S3 bucket
- Empty `unicorn-build-artifacts` i onda Delete 

### Empty and delete buckets created in S3

### Delete IAM Policies and Roles
- Obrisati Topics `codeartifact-unicorn-consumer-policy`i `UnicornCodeDeployRole`te sve sto ima u imenu `unicorn-web`

### Delete CloudWatch Logs group
- Obrisati `unicorn-build-logs`

