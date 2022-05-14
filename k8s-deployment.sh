#!/bin/bash

#k8s-deployment.sh

# replace image name
sed -i "s#replace#${imageName}#g" k8s_deployment_service.yaml
kubectl -n default get deployment ${deploymentName} > /dev/null


#If status of above kubectl cmd is !=0 then deployment doesnot exist & then deploy 
#application 
if [[ $? -ne 0 ]]; then
    echo "deployment ${deploymentName} doesnt exist"
    kubectl -n default apply -f k8s_deployment_service.yaml

#if status code is 0 then deployment exist, then update Image of deployment
else
    echo "deployment ${deploymentName} exist"
    echo "image name - ${imageName}"
    kubectl -n default set image deploy ${deploymentName} ${containerName}=${imageName} --record=true
fi