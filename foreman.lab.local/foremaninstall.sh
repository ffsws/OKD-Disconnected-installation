#!/bin/bash
yum -y install https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://yum.theforeman.org/releases/1.22/el7/x86_64/foreman-release.rpm
yum -y localinstall https://fedorapeople.org/groups/katello/releases/yum/nightly/katello/el7/x86_64/katello-repos-latest.rpm
yum -y install foreman-installer 
yum -y update
yum -y install katello
hostnamectl set-hostname foreman.okd.local
foreman-installer --scenario katello  --foreman-initial-organization okd --foreman-initial-location UAE  --foreman-initial-admin-username admin --foreman-initial-admin-password password --foreman-compute-ec2-version
wget -q https://www.centos.org/keys/RPM-GPG-KEY-CentOS-7 -O /tmp/RPM-GPG-KEY-CentOS-7
wget -q https://centos.org/keys/RPM-GPG-KEY-CentOS-SIG-PaaS -O /tmp/RPM-GPG-KEY-CentOS-SIG-PaaS
wget -q https://centos.org/keys/RPM-GPG-KEY-CentOS-SIG-ConfigManagement -O /tmp/RPM-GPG-KEY-CentOS-SIG-ConfigManagemen
hammer gpg create --key /tmp/RPM-GPG-KEY-CentOS-7  --name 'GPG-CentOS-7' --organization "okd"
hammer gpg create --key /tmp/RPM-GPG-KEY-CentOS-SIG-PaaS  --name 'GPG-CentOS-7-PAAS' --organization "okd"
hammer gpg create --key /tmp/RPM-GPG-KEY-CentOS-SIG-ConfigManagemen  --name 'GPG-CentOS-7-CM' --organization "okd"
hammer product create --name=CentOS --organization "okd" --description CentOS
hammer repository create --name='CentOS 7 - Base - x86_64' --organization "okd" --product='CentOS' --content-type='yum' --publish-via-http=true --url=http://mirror.centos.org/centos/7/os/x86_64/ --gpg-key=GPG-CentOS-7
hammer repository create --name='CentOS 7 - Updates - x86_64' --organization "okd" --product='CentOS' --content-type='yum' --publish-via-http=true --url=http://mirror.centos.org/centos/7/updates/x86_64/ --gpg-key=GPG-CentOS-7
hammer repository create --name='CentOS 7 - Extras - x86_64' --organization "okd" --product='CentOS' --content-type='yum' --publish-via-http=true --url=http://mirror.centos.org/centos/7/extras/x86_64/ --gpg-key=GPG-CentOS-7
hammer repository create --name='CentOS 7 - Fasttrack - x86_64' --organization "okd" --product='CentOS' --content-type='yum' --publish-via-http=true --url=http://mirror.centos.org/centos/7/fasttrack/x86_64/ --gpg-key=GPG-CentOS-7
hammer repository create --name='CentOS 7 - Cr - x86_64' --organization "okd" --product='CentOS' --content-type='yum' --publish-via-http=true --url=http://mirror.centos.org/centos/7/cr/x86_64/ --gpg-key=GPG-CentOS-7
hammer repository create --name='CentOS 7 - Centosplus - x86_64' --organization "okd" --product='CentOS' --content-type='yum' --publish-via-http=true --url=http://mirror.centos.org/centos/7/centosplus/x86_64/ --gpg-key=GPG-CentOS-7
hammer repository create --name='CentOS 7 - Origin311 - x86_64' --organization "okd" --product='CentOS' --content-type='yum' --publish-via-http=true --url=http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin311/ --gpg-key=GPG-CentOS-7-PAAS
hammer repository create --name='CentOS 7 - Ansible26 - x86_64' --organization "okd" --product='CentOS' --content-type='yum' --publish-via-http=true --url=http://mirror.centos.org/centos/7/configmanagement/x86_64/ansible26/ --gpg-key=GPG-CentOS-7-CM
hammer product synchronize --organization='okd' --name='CentOS'
hammer product create --name='Containers' --organization='okd'
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/origin-node' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/origin-control-plane' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/origin-deployer' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/origin-template-service-broker' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/origin-pod' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/origin-console' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/origin-service-catalog' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/origin-web-console' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='cockpit/kubernetes' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://docker.io' --docker-upstream-name='openshift/prometheus-node-exporter' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://quay.io' --docker-upstream-name='coreos/kube-rbac-proxy' --publish-via-http="true"
hammer repository create --name='centos' --organization='okd' --product='Containers' --content-type='docker' --url='https://quay.io' --docker-upstream-name='coreos/coreos/etcd' --publish-via-http="true"
hammer product synchronize --organization='okd' --name='Containers'