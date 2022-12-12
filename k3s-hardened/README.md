# k3s hardened cluster

### Custom cluster sample
```yaml
apiVersion: provisioning.cattle.io/v1
kind: Cluster
metadata:
  name: <name>
  annotations:
    field.cattle.io/description: <description>
  labels:
    {}
  namespace: fleet-default
spec:
  defaultPodSecurityPolicyTemplateName: 'restricted-psp'
  kubernetesVersion: v1.24.8+k3s1
  localClusterAuthEndpoint:
    caCerts: ''
    enabled: false
    fqdn: ''
  rkeConfig:
    chartValues:
      {}
    etcd:
      disableSnapshots: false
      s3:
      snapshotRetention: 5
      snapshotScheduleCron: 0 */5 * * *
    machineGlobalConfig:
      kube-apiserver-arg:
      - enable-admission-plugins=NodeRestriction,PodSecurityPolicy  # CIS 1.2.16 and CIS 5.2
      - audit-policy-file=/var/lib/rancher/k3s/server/audit.yaml    # CIS v1.20/v1.23 3.2.1
      - audit-log-path=/var/lib/rancher/k3s/server/logs/audit.log   # CIS v1.20 1.2.21 and CIS v1.23 1.2.19
      disable-cloud-controller: false
      disable-kube-proxy: false
      disable-scheduler: false
      etcd-expose-metrics: false
      profile: null
      disable-apiserver: false
      disable-controller-manager: false
      disable-etcd: false
      disable-network-policy: false
      secrets-encryption: true
    machinePools:
    machineSelectorConfig:
      - config:
          protect-kernel-defaults: true
          selinux: false
          docker: false
    registries:
      configs:
        {}
      mirrors:
        {}
    upgradeStrategy:
      controlPlaneConcurrency: '1'
      controlPlaneDrainOptions:
        deleteEmptyDirData: true
        disableEviction: false
        enabled: false
        force: false
        gracePeriod: -1
        ignoreDaemonSets: true
        skipWaitForDeleteTimeoutSeconds: 0
        timeout: 120
      workerConcurrency: '1'
      workerDrainOptions:
        deleteEmptyDirData: true
        disableEviction: false
        enabled: false
        force: false
        gracePeriod: -1
        ignoreDaemonSets: true
        skipWaitForDeleteTimeoutSeconds: 0
        timeout: 120
  machineSelectorConfig:
    - config: {}
__clone: true
```
