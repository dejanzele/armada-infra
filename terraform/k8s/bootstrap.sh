#!/bin/bash

/etc/eks/bootstrap.sh "${CLUSTER_NAME}" --container-runtime containerd --use-max-pods false --kubelet-extra-args "--max-pods=${NODE_MAX_PODS}"
