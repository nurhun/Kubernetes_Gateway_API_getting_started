# Kubernetes Gateway API getting started

This is a POC for the new kubernetes networking evolution step, [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/).


While it's supposed that the gateway API comes with extended featues versus the current [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) project already support. However, this demo will cover deploying simple application with splitted traffic.


Although there are already many implementations, but at the time of making this demo (Dec 31st, 2022) only Google's implementation is (GA).

GKE's implementation of the Gateway API is through the [GKE Gateway controller](https://cloud.google.com/kubernetes-engine/docs/concepts/gateway-api) which provisions Google Cloud Load Balancers for Pods in GKE clusters.

That's why I'm going to use a GKE in this demo.


#### Preparations and prerequisites
- A GKE cluster with 1.24+ version.
- Gateway & HTTPRoute manifests
- Dump app with variatiant services to test traffic splitting feature.


#### Usage
0. Provision the required infrastructure through the terraform module in 0-terraform. You need to pass your own project and other parameters, so make use of the terraform.tfvars.template file.

1. Define the gateway with the required gatewayClass. Here I used the gke-l7-global-external-managed gatewayClass. For more info on available gatewayClasses, take a look [here](https://cloud.google.com/kubernetes-engine/docs/how-to/gatewayclass-capabilities). Definition is in 1-gateway dir.

2. Deploy the app in 2-deployments. It's a dump django rest app with react frontend. For more info on the [app](https://github.com/nurhun/django_rest_framework_movies_apis_w_react_frontend).

3. Deploy routes to define how the gateway should manage the traffic. manifest in 3-HTTPRoutes dir. <br>
**NOTE:** You'll need to get the public ip address assigned to the gateway. To do so, run
```bash
kubectl get gateways.gateway.networking.k8s.io external-http -o=jsonpath="{.status.addresses[0].value}"
```
Then, pass this IP in the HTTPROUTE file .spec.hostnames in the format of browsable <ip_address>.nip.io 

4. Test the traffic spliting and routing behavior by visiting <ip_address>.nip.io

5. Cleanup infrastructure provisioned.


#### Out of scope:
- Securing the gateway.
- non-http protocol.


