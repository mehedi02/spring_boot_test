## What is it?
This source code is an Spring Boot web application (mvc + thymeleaf).
 
Tested with
* Docker 19.03
* Ubuntu 19
* Java 8 or Java 11
* Spring Boot 2.2.4.RELEASE
* Maven

For explanation, please visit this article - [Docker and Spring Boot](https://mkyong.com/docker/docker-spring-boot-examples/)

## How to run this?
```bash
$ git clone https://github.com/mkyong/docker-java
$ cd docker-spring-boot
$ mvn clean package
$ java -jar target/spring-boot-web.jar

  access http://localhost:8080

//dockerize

// create a docker image
$ sudo docker build -t spring-boot:1.0 .
// run it
$ sudo docker run -d -p 8080:8080 -t spring-boot:1.0

  access http://localhost:8080
```

## Access the kubeconfig content
```bash
az aks get-credentials --resource-group <resource-group-name> --name <cluster-name> --file kubeconfig-ss
```

set the **KUBECONFIG** in github secrets and its value will be the content inside the **kubeconfig-ss** file and use it in CI/CD pipeline

## Create Azure Credentials
In github secrets create a variable **AZURECREDENTIALS** and the value will be
```json
{
    "clientId": "<client ID>",
    "clientSecret": "<client secret>",
    "subscriptionId": "<subscription ID>",
    "tenantId": "<tenant ID>",
    "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
    "resourceManagerEndpointUrl": "https://management.azure.com/",
    "activeDirectoryGraphResourceId": "https://graph.windows.net/",
    "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
    "galleryEndpointUrl": "https://gallery.azure.com/",
    "managementEndpointUrl": "https://management.core.windows.net/"
}
```

To create new service principal and to get the above json run below command
```bash
az ad sp create-for-rbac --name "myApp" --role contributor \
                            --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group} \
                            --sdk-auth
```

The above service principal in the scope of resource group, if you want to give the subscription level access ommit the **/resourceGroups/{resource-group}**