**TASK 10**

**Monolitna arhitektura**

Monolitnu arhitekturu možemo zamisliti kao blackbox te postoje tri tiera:
    upload
    processing
    store and manage

Osobine monolitne arhitekture čine:

1. Pad jednog monolita vodi padu svih zajedno
2. Skaliranje je zajedničko (vertikalno skaliranje)
3. Naplaćivanje je zajedničko

**Tiered arhitektura**

Tiered arhitektura može biti na svom ili zajedničkom serveru
Mogu se zasebno vertikalno skalirati te moguće je skaliranje i horizontalno
Možemo koristiti internal load balancere

**Nedostaci:**

Tierovi su povezani(coupled)
Moraju postojati tierovi, ukoliko želimo da sve funkcioniše kako treba
Nemoguće skaliranje na 0

**Razvoj sa redovima(Evolving with QUEUE)**

Proširujemo arhitekturu sa redovima čekanja(QUEUE)
Korištenjem redova čekanja(QUEUE) razdvajamo(decouple) tierov
Skaliranje se radi sa dužinom reda čekanja(Queue Lenght)

**Mikroservisna arhitektura**

To je kolekcija mikroservisa
Mikroservis možemo zamisliti kao malu aplikaciju koja ima svoju logiku


**AWS Lambda**

AWS Lambda pripada skupini Function as a Service (FaaS).

Plaćanje na osnovu broja zahtjeva i koda kompajliranog(vremena do izvršenja)
Koristi se za Serverless ili Event-driven arhitekturu
Nije dobro koristiti Lambdu za konterizaciju(Docker je anti-pattern)
Moze koristiti Lambda funkcije kao kontejnere
512 MB memorije je dostupno(/tmp) moguće skaliranje na 10240 MB
Maksimalno vrijeme izvršavanja lambda funckije je 900sec(15 minuta) 
Sigurnost ostvarena i kontrolisana uz pomoć execution role(IAM Role)

**Lambda može da ima dva network moda:**

1.Public kao defaultni

2.VPC network mode


**Poziv lambde:**

1. Sinhrono pozivanje
2. Asinhrono pozivanje
3. Event source mapping


**CloudWatch Events i Event Bridge**

CloudWatch Events bilježi near realtime evente sve promjene na AWS servisima.

Event Bridge servis koji replicira CloudWatch Events, ima sve mogućnosti CloudWatch Events ali može da handla evente.

**Serverless arhitektura:**

Serverless computing ( ili serverless skraćeno ) je model gdje je cloud provajder ( AWS, AZure ili Google Cloud ) odgovoran za izvršavanje dio kod-a dinamički dodjeljivanjem resursa. 

Aplikacije se kolekcije malih ili specijalnih funkcija
Statless i kratkotrajna okruženja - naplaćivanje u vremenu trajanja
Koristi se veliki broj managed servisa, izbjegavaju se no self managed servisi

**Simple Notification Service (SNS)**

SNS je Javno dostupan AWS servis
Kordinira slanje i dostavljanje poruka
Veličine poruke su <= 256 kB
SNS Topic je bazni entitet SNS-a

Pretplatnici mogu biti: HTTP, Email, SQS, Mobile Push, SMS Messages i Lambda


**AWS Step Functions**

Serverless workflow START -> STATES -> END
Maksimalno trajanje AWS Step Functions-a je 1 godina


**API Gateway**

Kreira i upravlja API-ma(APPLICATION PROGRAMMING INTERFACE)
Endpoint/Entry point aplikacija
Može konektovati na servise/endpointe u AWS-u ili on-premises

**Vrste API-a**

1. HTTP API

2. REST API

3. WEBSOCKET API


API Gateway Cache može biti korišten za smanjenje broja poziva prema backend integraciju te može poboljšati klijentove performanse

**Endpoint tipovi:**

      -Edge-Optimized

      -Regional

      -Private



**Errori:**

    -4xx Client Error - Invalid request on client side

    -5xx Server Error - Invalid Request, backend issue



    -400 - Bad request - Generic

    -403 - Access denied - Authorizer denies or WAF

    -429 - API Gateway can throttle

    -502 - Bad gateway exception - bad output returned

    -503 - Service unavaliable - backend endpoint offline

    -504 - Integration Failure/Timeout - 29 sec limit for integration

**Simple Queue Service**

Javno dostupan, potpuno kontrolisan i visoko dostupan
Koristi se za asinhrono razdvajanje aplikacija
Neograničen broj poruka u redu čekanja
Maksimalna veličina poruke 256KB.
Consumer povlači poruku iz reda čekanja. Kada consumer procesira poruku poruka se briše.
Maksimalno zadržavanje poruke u redu čekanja 14 dana.







