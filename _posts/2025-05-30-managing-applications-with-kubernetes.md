---
title: Managing Applications with Kubernetes.
date: 2025-05-30
categories: [Kubernetes]
tags:
  - Kubernetes
description: explore ReplicaSets, autoscaling, rolling updates, ConfigMaps, Secrets, and service bindings, and learn how you can use these capabilities to manage Kubernetes applications. learn how ReplicaSets scale applications to meet increasing demand, and how autoscaling creates dynamic demand-based scaling.  how to use rolling updates to publish application updates and roll back changes without interrupting the user experience. learn how to use ConfigMaps and Secrets to provide configuration variables and sensitive information to your deployments and to keep your code clean.  scale and update applications deployed in Kubernetes.
---


## ReplicaSet: Ensuring Application Availability and Scalability

**Introduction:**
Deploying an application on a single Pod has severe limitations: it cannot handle increased demand, fails entirely on outages (single point of failure), lacks high availability, and cannot automatically restart if something goes wrong. ReplicaSets address these limitations.

### What is a ReplicaSet?

A `ReplicaSet` is a Kubernetes object that ensures a **specified number of identical Pod replicas are always running** at any given time. It continuously monitors the current state of Pods against the desired state.

### How a ReplicaSet Works:

1.  **Desired vs. Actual State:** A ReplicaSet's primary function is to continuously match the actual number of running Pods to the desired number of replicas specified in its configuration.
2.  **Scaling:**
    * If the actual number of Pods is *less* than the desired state, it **adds new Pods**.
    * If the actual number of Pods is *more* than the desired state, it **deletes surplus Pods**.
3.  **Redundancy & Self-Healing:**
    * It replaces failing, terminated, or deleted Pods to maintain the desired count, ensuring high availability and minimizing downtime.
4.  **Pod Ownership (via Labels):**
    * A ReplicaSet **does not own** any Pods directly. Instead, it uses **Pod labels** (defined in its `selector`) to identify which Pods it should manage. If a Pod's labels match the ReplicaSet's selector, the ReplicaSet considers it part of its managed set.

### Benefits of Using a ReplicaSet:

* **High Availability:** Provides redundancy by ensuring multiple Pods are running, eliminating single points of failure.
* **Scalability:** Enables easy scaling of applications by adding or removing Pods as demand changes.
* **Self-Healing:** Automatically replaces failing or terminated Pods, ensuring application continuity.
* **Maintain Desired State:** Guarantees that the specified number of application instances are always available.

### ReplicaSet vs. ReplicationController:

* `ReplicaSet` **supersedes** `ReplicationController` and should be used instead. They share the same core functionality, but `ReplicaSet` has more powerful label selectors.

### ReplicaSet and Deployments (Recommended Best Practice):

* While you *can* create a `ReplicaSet` directly, it is **highly recommended** to manage `ReplicaSet` objects through a **Deployment**.
* **Deployments manage ReplicaSets:** When you create a Deployment, it automatically creates a ReplicaSet to manage its Pods.
* **Enhanced Features:** Deployments provide additional management capabilities on top of ReplicaSets, such as:
    * **Declarative Updates:** Send declarative updates to Pods.
    * **Automated Rollouts and Rollbacks:** Manage application versions and safely deploy new ones or revert to old ones.

### Demonstrations:

1.  **Deployment Automatically Creates a ReplicaSet:**
    * Create a Deployment (e.g., `kubectl create deployment hello-kubernetes`).
    * Verify the ReplicaSet is automatically generated (`kubectl get rs`).
    * Describe the Pod to see it's controlled by the ReplicaSet (`kubectl describe pod <pod-name>`).

2.  **Creating a ReplicaSet from Scratch (for understanding, not recommended for production):**
    * Apply a YAML file with `kind: ReplicaSet`.
    * Confirm creation with `kubectl get rs` and `kubectl get pods`.

3.  **Scaling a Deployment:**
    * Ensure a Deployment and its default single Pod exist.
    * Use `kubectl scale deployment/<deployment-name> --replicas=<number>` (e.g., to 3).
    * Observe the `ReplicaSet` creating new Pods to reach the desired count (`kubectl get pods`).

4.  **ReplicaSet Maintaining Desired State (Self-Healing):**
    * **Deleting a Pod:**
        * Observe 3 running Pods.
        * Manually delete one Pod (`kubectl delete pod <pod-name>`).
        * Observe the `ReplicaSet` immediately creating a new Pod to replace the deleted one, restoring the count to 3.
    * **Manually Creating a Pod (unmanaged):**
        * Observe 3 running Pods.
        * Manually create an *additional* Pod with matching labels (`kubectl create pod <pod-name> ...`).
        * Observe 4 Pods initially.
        * The `ReplicaSet` detects more Pods than desired and **deletes** the manually created, unmanaged Pod to restore the desired count of 3.

### Conclusion:

* A ReplicaSet provides high availability through redundancy.
* A ReplicaSet enables scaling by creating or deleting Pods.
* You can create a ReplicaSet using the CLI (via a YAML descriptor).
* A ReplicaSet always strives to match the actual state to the desired state.
* **Best Practice:** Use a Deployment to manage ReplicaSets, rather than creating ReplicaSets directly, to leverage advanced features like rollouts and rollbacks.

---
# Autoscaling

---

## Auto-Scaling in Kubernetes: Optimizing Resource Usage and Costs

**Introduction:**
While ReplicaSets provide a baseline for maintaining a desired number of Pods, they don't dynamically adjust to fluctuating demand. Kubernetes auto-scaling solves this by automatically scaling resources (at the Pod or Node level) in line with application demand, optimizing both performance and cost.

Kubernetes offers auto-scaling at two layers:
1.  **Pod Level:** Adjusting the number or size of application instances.
2.  **Cluster/Node Level:** Adjusting the underlying infrastructure (Nodes).

### Three Types of Kubernetes Auto-Scalers:

1.  **Horizontal Pod Autoscaler (HPA)**
2.  **Vertical Pod Autoscaler (VPA)**
3.  **Cluster Autoscaler (CA)**

### 1. Horizontal Pod Autoscaler (HPA)

* **Definition:** The HPA automatically adjusts the **number of replicas (Pods)** of a workload resource (like a Deployment or ReplicaSet) by increasing or decreasing the number of Pods. This is also known as "scaling out" or "scaling in."
* **How it Works:**
    * Monitors **metrics** (e.g., CPU utilization, memory utilization, or custom/external metrics) of the target workload.
    * Compares the actual metric value to a defined **target utilization percentage**.
    * Increases the number of Pods if utilization exceeds the target.
    * Decreases the number of Pods if utilization falls below the target, respecting `min` and `max` replica counts.
* **Example Scenario:**
    * **Low load (early morning):** One Pod is sufficient.
    * **Peak load (11:00 AM):** HPA scales out to three Pods to meet demand.
    * **Usage drops (afternoon/evening):** HPA scales in, removing surplus Pods to conserve resources.
* **Creation:** Can be created using the `kubectl autoscale` imperative command (e.g., `kubectl autoscale deployment/my-app --min=2 --max=10 --cpu-percent=50`) or by defining an `HorizontalPodAutoscaler` object in a YAML file.
* **Relationship with Deployment/ReplicaSet:** The HPA directly updates the `replicas` field of the Deployment (which in turn controls its ReplicaSet), letting the Deployment/ReplicaSet handle the actual Pod creation/deletion.

### 2. Vertical Pod Autoscaler (VPA)

* **Definition:** The VPA automatically adjusts the **resource requests and limits (CPU and memory)** of individual containers within a Pod by increasing or decreasing the allocated resource size or speed. This is also known as "scaling up" or "scaling down."
* **How it Works:**
    * Monitors the **actual resource usage** (CPU, memory) of Pods over time.
    * Recommends or automatically applies new resource requests and limits to optimize resource allocation.
    * Often, to apply new limits, the VPA might need to **restart the Pod** (though some advanced implementations might allow in-place adjustments for some resources).
* **Example Scenario:**
    * **Low load (early morning):** Pod uses minimal CPU/memory. VPA scales down resources.
    * **Peak load (11:00 AM):** VPA scales up resources (CPU, memory) for the existing Pod to meet demand.
    * **Usage drops (afternoon/evening):** VPA scales down resources for the Pod.
* **Important Consideration:** **You should not use VPAs with HPAs on the *same* resource metrics** (like CPU or memory) because they would conflict (one tries to change count, the other changes individual Pod size based on the same metric). However, they *can* be used together if they scale on different metrics (e.g., HPA on custom metrics, VPA on CPU/memory).

### 3. Cluster Autoscaler (CA)

* **Definition:** The CA automatically adjusts the **number of Nodes** (worker machines) in the cluster itself. It increases or decreases the underlying compute capacity of the cluster.
* **How it Works:**
    * **Scaling Up:** Adds Nodes when:
        * Pods fail to schedule due to insufficient resources on existing Nodes.
        * Demand for Pods increases beyond the current Node capacity.
    * **Scaling Down:** Removes Nodes when:
        * Nodes become underutilized (many Pods have been deleted or moved off).
        * There are Nodes that can be safely drained of Pods and removed without impacting performance.
* **Example Scenario:**
    * **Low load (early morning):** Existing Nodes handle the load.
    * **Increased demand/unfulfillable Pod requests:** CA adds new Nodes to accommodate new Pods.
    * **Usage drops (afternoon/evening):** CA identifies underutilized Nodes (where all Pods are removed or rescheduled) and removes them to save costs.
* **Benefit:** Ensures there is always enough compute power to run your tasks, and that you aren't paying for unused infrastructure during low demand periods (e.g., nights, weekends, or between batch jobs).

### Combining Auto-Scalers (Best Practice):

* Each auto-scaler type is suitable for specific scenarios.
* Analyzing the pros and cons of each is crucial for optimal choice.
* Often, the **most optimized solution** involves using a **combination of all three types**:
    * **HPA:** Handles fluctuating application load by adjusting Pod count.
    * **VPA:** Optimizes individual Pod resource allocation.
    * **CA:** Ensures the underlying cluster infrastructure has enough capacity to support the Pods.
* This combination ensures services run stably at peak load times and costs are minimized during periods of lower demand.

### Key Takeaways:

* Auto-scaling enables dynamic scaling at both the cluster/node level and the Pod level.
* You can auto-scale Deployments or ReplicaSets using HPAs.
* The three main autoscaler types are HPA, VPA, and CA.
* A combination of all three autoscaler types often provides the most optimized and cost-effective solution.


# Deployment Strategies

This document provides an excellent overview of various deployment strategies in Kubernetes, highlighting their characteristics, pros, cons, and suitability for different scenarios. It's a critical topic for anyone managing applications in a production Kubernetes environment.

Here's a structured summary of the deployment strategies discussed:

---

## Kubernetes Deployment Strategies: Achieving and Maintaining Application State

A Kubernetes deployment strategy defines the lifecycle of an application, enabling automated deployment, updates, and rollbacks while maintaining a desired configured state. Effective strategies aim to minimize risk, downtime, and user impact.

Kubernetes deployment strategies are used to:
* Deploy, update, or rollback ReplicaSets, Pods, Services, and Applications.
* Pause/Resume Deployments.
* Scale Deployments manually or automatically.

You can use a single strategy or combine multiple strategies depending on your needs.

### Types of Deployment Strategies:

Here are six common deployment strategies:

---

### 1. Recreate Strategy

* **Description:** The simplest strategy where all Pods running the current version (v1) are *simultaneously shut down* (deleted), and then the new version (v2) is deployed on newly created Pods.
* **Steps:**
    1.  New version (v2) ready.
    2.  All v1 Pods are shut down/deleted.
    3.  New v2 Pods are created.
* **Rollback:** Replaces v2 with v1 in reverse order.
* **Pros:**
    * Simple setup.
    * Application version is completely replaced (clean slate).
* **Cons:**
    * **Short downtime** occurs between the shutdown of the existing deployment and the new deployment.

---

### 2. Rolling (Ramped) Strategy

* **Description:** The default Kubernetes deployment strategy. Pods are updated *one at a time* (or in small batches). A single v1 Pod is replaced with a new v2 Pod, and this process repeats until all Pods are v2.
* **Steps:**
    1.  New version (v2) ready.
    2.  One v1 Pod is shut down/deleted.
    3.  A new v2 Pod is created to replace the removed v1 Pod.
    4.  Steps 2 and 3 are repeated until all v1 Pods are replaced by v2 Pods.
* **Rollback:** Reversed process, v2 Pods are replaced by v1 Pods.
* **Pros:**
    * Simple setup.
    * **Hardly any downtime** since users are directed to either version during the update.
    * Suitable for stateful applications that need to handle rebalancing of data (though dedicated stateful solutions are often better).
* **Cons:**
    * Rollout/rollback takes time (gradual process).
    * You cannot control traffic distribution (users might hit both v1 and v2 during the update).

---

### 3. Blue/Green Strategy

* **Description:** Two identical environments ("Blue" for the current live version and "Green" for the new version) run in parallel. The new "Green" environment is thoroughly tested. Once ready, user traffic is *switched instantly* from Blue to Green.
* **Steps:**
    1.  Create a new, identical "Green" environment.
    2.  Deploy and thoroughly test the new v2 application in the "Green" environment.
    3.  Route all user traffic to the "Green" environment.
* **Rollback:** Instantaneous switch back to the "Blue" environment.
* **Pros:**
    * **Instant rollout/rollback (zero downtime)**.
    * New version is available immediately to all users.
* **Cons:**
    * **Expensive** (requires double the resources running simultaneously).
    * Rigorous testing required *before* switching traffic.
    * Handling stateful applications can be difficult.

---

### 4. Canary Strategy

* **Description:** A new version (v2) is deployed alongside the current live version (v1), but initially, only a *small, random subset of users* (or traffic) is routed to v2. The new version is monitored for performance, errors, and issues. If successful, traffic is gradually increased to v2 until it becomes the primary version.
* **Steps:**
    1.  Design a new v2 application.
    2.  Route a small sample of user requests to v2.
    3.  Test for efficiency, performance, bugs, and issues. Rollback if needed.
    4.  Repeat steps 2-3 (gradually increasing traffic) until all issues are resolved.
    5.  Route all traffic to v2.
* **Rollback:** Fast rollback with no downtime, as only a few users are exposed to the new version initially.
* **Pros:**
    * Convenient for reliability, error, and performance monitoring with real traffic.
    * Fast rollback (minimal user impact).
* **Cons:**
    * **Slow rollout** (gradual user access).

---

### 5. A/B Testing Strategy

* **Description:** Similar to Canary but with a specific purpose: evaluating two (or more) versions of an application (A and B) that often have features catering to *different, targeted sets of users*. Users are selected based on specific conditions (e.g., location, cookie values, browser version, user traits), and their interactions are monitored to determine which version is best for wider deployment.
* **Steps:**
    1.  Design a new version with specific features (e.g., UI changes).
    2.  Identify a small set of users based on conditions.
    3.  Route requests from this user set to the new version.
    4.  Monitor for bugs, efficiency, and performance.
    5.  Once issues resolved, route all target traffic to the new version (or scale it globally).
* **Rollback:** Can be implemented, but downtime can impact the targeted user set.
* **Pros:**
    * Multiple versions can run in parallel.
    * Full control over traffic distribution to specific user segments.
* **Cons:**
    * Requires an **intelligent load balancer** or ingress controller with advanced routing capabilities.
    * Difficult to troubleshoot errors for a given session (distributed tracing becomes mandatory).

---

### 6. Shadow Strategy

* **Description:** A "shadow version" (v2) of the application is deployed alongside the live version (v1). User requests are sent to *both* versions simultaneously. The shadow version processes all requests using real-world data but **does not forward responses back to the users**. This allows developers to see how the new version performs under production load without impacting the live user experience.
* **Steps:**
    1.  Deploy a "shadow version" (v2) alongside the live v1.
    2.  Mirror (copy) all user requests to both v1 and v2.
    3.  v1 handles the requests and responds to users. v2 processes requests but discards responses.
    4.  Monitor v2's performance using real-world data.
* **Rollback:** Not applicable in the traditional sense, as v2 isn't live. Simply stop mirroring traffic to the shadow.
* **Pros:**
    * **Performance testing with production traffic** (highly realistic).
    * **No user impact** or downtime.
* **Cons:**
    * **Expensive** (requires double resources).
    * Not a true user experience test (can lead to misinterpreted results if user interaction patterns are critical).
    * Complex setup (requires traffic mirroring).
    * Requires monitoring for two environments.

---

### Deployment Strategies Summary Table:

| Strategy    | Zero Downtime | Real Traffic Testing | Targeted Users | Cloud Cost | Rollback Duration | Negative User Impact | Complexity of Setup |
| :---------- | :------------ | :------------------- | :------------- | :--------- | :---------------- | :------------------- | :------------------ |
| **Recreate**| ✗             | ✗                    | ✗              | •--        | •••               | •••                  | •--                 |
| **Rolling** | ✓             | ✗                    | ✗              | •--        | •••               | •--                  | •--                 |
| **Blue/Green**| ✓             | ✗                    | ✗              | •••        | ---               | ••-                  | ••-                 |
| **Canary** | ✓             | ✓                    | ✗              | •--        | •--               | •--                  | ••-                 |
| **A/B Testing**| ✓             | ✓                    | ✓              | •--        | •--               | •--                  | •••                 |
| **Shadow** | ✓             | ✓                    | ✗              | •••        | ---               | ---                  | •••                 |

*Legend for Cost/Duration/Impact/Complexity:*
* `•--` = Low
* `••-` = Medium
* `•••` = High
* `---` = Instant/None

---

### Key Considerations for Creating a Good Strategy:

* **Product Type & Target Audience:** These heavily influence the best strategy.
* **Live User Requests:** Shadow and Canary strategies leverage real user traffic for testing.
* **A/B Testing:** Ideal for minor tweaks or UI feature changes where you want to compare user interaction.
* **Blue/Green:** Useful for complex or critical applications requiring proper monitoring and absolutely no downtime during deployment.
* **Canary:** A good choice for zero downtime where you're comfortable gradually exposing the new version to a subset of the public.
* **Rolling:** A default, gradual deployment with no downtime and easy rollback, suitable for many general-purpose applications.
* **Recreate:** Best for non-critical applications where a short downtime is acceptable and won't significantly impact users.


# Rolling Updates

---

## Kubernetes Rolling Updates: Seamless Application Changes

**Rolling Updates** are a key feature in Kubernetes that enables automated and controlled deployment of application changes across Pods. They allow for updates without application downtime and provide easy rollback capabilities.

### What is a Rolling Update and How It Works?

* **Automated and Controlled Changes:** Rolling updates manage the process of updating your application, ensuring that changes are applied gradually and systematically.
* **Zero Downtime Goal:** The primary aim is to publish changes to applications without noticeable interruption for end-users.
* **Pod Templates (Deployments):** Rolling updates work by modifying the **Pod template** (e.g., the container image) within a higher-level controller like a **Deployment**. The Deployment then orchestrates the update of its managed Pods.
* **Rollback Capability:** Rolling updates allow for easy reversion to a previous stable version if issues arise with a new deployment.

### Pre-steps Before Applying a Rolling Update:

To ensure a smooth and zero-downtime rolling update, certain best practices and configurations are crucial:

1.  **Add Liveness Probes:**
    * A **liveness probe** checks if a container is still running. If it fails, Kubernetes restarts the container. This ensures that only *healthy* containers are part of the service.
2.  **Add Readiness Probes:**
    * A **readiness probe** determines if a container is ready to serve requests. If it fails, Kubernetes removes the Pod's IP address from the Service endpoints, preventing traffic from being sent to an unready Pod. This is vital for zero-downtime updates.
3.  **Define Rolling Update Strategy in YAML:**
    * For a Deployment, you configure the rolling update strategy within its `spec.strategy.rollingUpdate` section. Key parameters include:
        * `maxUnavailable`: The maximum number of Pods that can be unavailable during the update process.
            * **For Zero Downtime:** Set `maxUnavailable: 0` to ensure no Pods are taken down until new ones are ready.
        * `maxSurge`: The maximum number of Pods that can be created *above* the desired number of replicas during an update.
            * Example: If you have 10 Pods and `maxSurge: 2`, Kubernetes can temporarily create up to 12 Pods during the update.
            * Setting `maxSurge: 100%` would effectively double the number of Pods during the update, ensuring a complete replica of the new version is up before the old one is fully taken down.
        * `minReadySeconds`: The minimum number of seconds for which a newly created Pod must be in a "ready" state before it's considered available for the rollout, allowing for proper initialization and warm-up.

### Demonstrating a Rolling Update:

* **Scenario:** Update an application from "Hello World" (v1) to "Hello World v2" (v2) with zero downtime, starting with 3 Pods.
* **Steps:**
    1.  **Build and Push New Image:** The new `hello-kubernetes:2.0` image is built, tagged, and uploaded to a container registry (e.g., Docker Hub). (These are Docker commands, external to Kubernetes deployment.)
    2.  **Apply New Image to Deployment:** The `kubectl set image deployment/hello-kubernetes hello-kubernetes=upkar/hello-kubernetes:2.0` command is used. This declaratively updates the Deployment's Pod template to use the new image.
    3.  **Monitor Rollout Status:** Use `kubectl rollout status deployment/hello-kubernetes` to track the progress. It confirms when the deployment has "successfully rolled out."
    4.  **Verify New Version:** Accessing the application's URL confirms that the message has changed to "Hello World v2."

### How to Roll Back a Rolling Update:

* Rollbacks are straightforward in Kubernetes.
* **Command:** Use `kubectl rollout undo deployment/<deployment-name>` (e.g., `kubectl rollout undo deployment/hello-kubernetes`).
* **Process:** Kubernetes initiates a new rolling update, but this time, it replaces the current version (v2) with the *previous* stable version (v1).
* **Verification:**
    * `kubectl get pods` will show the termination of v2 Pods and the creation of new v1 Pods.
    * Accessing the application's URL confirms the original message (v1) is displayed again.

### Visualizing Rollout and Rollback Strategies:

1.  **"All-at-Once" (Not a standard Kubernetes Rolling Update):**
    * **Rollout:** All v1 Pods are removed, user access is blocked, then all v2 Pods are created and become active. **Significant downtime** occurs.
    * **Rollback:** All v2 Pods are removed, user access is blocked, then all v1 Pods are created and become active. **Significant downtime** occurs.
    * *(Note: This is generally equivalent to the "Recreate" strategy in Kubernetes, which is not the default for Deployments.)*

2.  **"One-at-a-Time" (The essence of Kubernetes Rolling Update):**
    * **Rollout:**
        * A new v2 Pod is created and becomes active.
        * One v1 Pod is marked for deletion and removed.
        * This process repeats until all v1 Pods are replaced by v2 Pods.
        * **User access is not interrupted** due to the staggered update.
    * **Rollback:**
        * A new v1 Pod is created and becomes active.
        * One v2 Pod is marked for deletion and removed.
        * This process repeats until all v2 Pods are replaced by v1 Pods.
        * **User access is not interrupted** during the rollback.

### Conclusion:

* Rolling updates automate and control application changes seamlessly.
* They publish changes without noticeable interruption (when configured correctly with readiness probes).
* They provide robust rollback capabilities.
* The core mechanism (one-at-a-time replacement) ensures continuous availability.


# ConfigMaps and Secrets

---

## ConfigMaps and Secrets: Managing Configuration and Sensitive Data in Kubernetes

**Introduction:**
A fundamental best practice in software development is to separate configuration variables from application code. This allows changes in settings without requiring code modifications or new deployments. Kubernetes provides `ConfigMap` and `Secret` objects for this purpose.

### 1. ConfigMap

* **Purpose:** An API object that stores **non-confidential data** in key-value pairs. It's designed for non-sensitive information as it provides no secrecy or encryption.
* **Benefits:**
    * **Decouples configuration** from application code.
    * Provides configuration data to Pods and Deployments, preventing hard-coding.
    * **Reusable** for multiple deployments, decoupling the environment.
* **Characteristics:**
    * Stores data in **key-value pairs**.
    * Data size **cannot exceed 1 megabyte**. For larger data, consider mounting a volume, or using a separate database/file service.
    * Has optional `data` and `binaryData` fields.
    * **No `spec` field** in its template (unlike Pods, Deployments, etc.).
    * The ConfigMap name must be a valid DNS subdomain name.

#### Ways to Create a ConfigMap:

1.  **From String Literals (on the command line):**
    * Provides key-value pairs directly in the `kubectl create configmap` command.
    * **Example:** `kubectl create configmap myconfig --from-literal=message='hello from the config map'`
2.  **From an Existing Properties or Key-Value File:**
    * Use a file containing `key=value` pairs (similar to `.properties` files).
    * Useful for adding many variables at once.
    * **Example:** If `my.properties` contains `message=hello from the my.properties file`, then `kubectl create configmap myconfig --from-file=my.properties`
    * Can load an entire directory: `kubectl create configmap myconfig --from-file=<directory>`
    * Can load a specific file with a custom key: `kubectl create configmap myconfig --from-file=my-message=my.properties`
3.  **Using a YAML Descriptor File:**
    * Define the ConfigMap explicitly in a YAML file and apply it.
    * **Example:**
        ```yaml
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: myconfig
        data:
          message: "hello from the YAML file"
        ```
        Then, `kubectl apply -f my-config.yaml`

#### Ways to Consume a ConfigMap in Pods/Deployments:

Kubernetes applies the ConfigMap just before running the Pod/Deployment.

1.  **As Environment Variables:**
    * Refer to the ConfigMap key within the Pod's container definition using `valueFrom` and `configMapKeyRef`.
    * **Example in Deployment YAML:**
        ```yaml
        env:
        - name: MESSAGE_VAR
          valueFrom:
            configMapKeyRef:
              name: myconfig
              key: message
        ```
    * In application code (Node.js example): `process.env.MESSAGE_VAR`
2.  **As Mounted Files (using `volumes` plugin):**
    * Mount the ConfigMap as a volume into the Pod. Each key-value pair in the ConfigMap becomes a file within the mounted directory.
    * **Example in Deployment YAML:**
        ```yaml
        volumes:
        - name: config-volume
          configMap:
            name: myconfig
        containers:
        - name: my-app-container
          volumeMounts:
          - name: config-volume
            mountPath: /etc/config
        ```
    * In application code: Read the file `/etc/config/message`.

### 2. Secrets

* **Purpose:** An API object that stores **confidential data** (e.g., passwords, API keys, OAuth tokens) in key-value pairs.
* **Key Difference from ConfigMap:** Secrets are designed for sensitive information and provide a base64 encoded representation of the data, offering a layer of obfuscation (though not true encryption at rest without additional measures).
* **Characteristics:**
    * Data is base64 encoded by default.
    * Size limits similar to ConfigMaps (1MB).

#### Ways to Create a Secret:

1.  **From String Literals (on the command line):**
    * Provide key-value pairs directly. The value will be base64 encoded automatically.
    * **Example:** `kubectl create secret generic my-secret --from-literal=api_key='my-super-secret-key'`
    * To verify, `kubectl get secret my-secret -o yaml` will show the encoded value.
2.  **From Environment Variables:**
    * It states "by using environment variables" as a creation method, but then demonstrates it as a consumption method. It's important to clarify: **Secrets are created from literal strings or files, then *consumed* as environment variables.**
    * **Consumption Example (via `valueFrom`):**
        ```yaml
        env:
        - name: API_CREDS
          valueFrom:
            secretKeyRef:
              name: my-secret
              key: api_key
        ```
    * In application code (Node.js): `process.env.API_CREDS`
3.  **From Files (similar to ConfigMap's `--from-file`):**
    * Create a secret from a file containing sensitive data.
    * **Example:** `kubectl create secret generic my-secret --from-file=api_creds.txt`
4.  **Using a YAML Descriptor File:**
    * Define the Secret explicitly in a YAML file. **Values must be base64 encoded in the YAML.**
    * **Example:**
        ```yaml
        apiVersion: v1
        kind: Secret
        metadata:
          name: my-secret
        type: Opaque # Or a specific type like kubernetes.io/dockerconfigjson
        data:
          api_key: bXktc3VwZXItc2VjcmV0LWtleQ== # base64 encoded 'my-super-secret-key'
        ```
        Then, `kubectl apply -f my-secret.yaml`

#### Ways to Consume a Secret in Pods/Deployments:

1.  **As Environment Variables:** (As shown above for `API_CREDS`)
2.  **As Mounted Files (using `volumes` plugin):**
    * Mount the Secret as a volume. Each key in the Secret becomes a file within the mounted directory, containing the *decoded* value.
    * **Example in Deployment YAML:**
        ```yaml
        volumes:
        - name: secret-volume
          secret:
            secretName: my-secret
        containers:
        - name: my-app-container
          volumeMounts:
          - name: secret-volume
            mountPath: /etc/api-creds
        ```
    * In application code: Read the file `/etc/api-creds/api_key`.

### Conclusion:

* **ConfigMaps** provide non-sensitive variables to applications.
* **Secrets** provide sensitive information to applications.
* Both can be created using string literals, files, or YAML descriptors.
* Both can be consumed by Pods/Deployments as environment variables or mounted as files.

---

# Service Binding

---

## Service Binding: Connecting Kubernetes Apps to External Services

**What is Service Binding?**

Service binding is the process of connecting applications running within a Kubernetes cluster to **external services** (also known as backing services). These external services can include:
* REST APIs
* Databases (e.g., PostgreSQL, MongoDB)
* Event Buses (e.g., Kafka)
* Managed cloud services (e.g., IBM Cloud Tone Analyzer, AWS RDS)

The core goal of service binding is to:
* **Manage configuration and credentials** for these backend services.
* **Protect sensitive data** by providing credentials securely.
* Make service credentials **automatically available** to your application, typically as a Kubernetes `Secret`.

**How Service Binding Works (Architectural Overview):**

1.  An **external service** (e.g., a database, an IBM Cloud API) exists outside the Kubernetes cluster.
2.  The Kubernetes cluster is **bound** to this external service. This process generates service credentials and configuration.
3.  These **credentials are stored securely** within the Kubernetes cluster, often as a `Secret`.
4.  The **application code** running in a Pod within the Kubernetes cluster consumes these credentials (from the `Secret`).
5.  The application then uses these credentials to **call and interact with the corresponding external service**.

### Steps to Bind an IBM Cloud Service to Your Cluster:


1.  **Provision an instance of the external service:**
    * This is the first step outside the Kubernetes cluster.
    * You create an instance of the desired service (e.g., a Tone Analyzer instance) using the IBM Cloud catalog or CLI.
2.  **Bind the service to your Kubernetes cluster:**
    * This critical step links the service instance to your cluster.
    * Using a command like `ibmcloud ks service bind` (specific to IBM Cloud Kubernetes Service), service credentials are created for your service instance using the public cloud service endpoint.
    * Crucially, this process **automatically creates a Kubernetes Secret** within your cluster, storing the service credentials. The credentials are base64 encoded and typically in JSON format inside the Secret.
3.  **Verify the Secret Object in your Kubernetes cluster:**
    * After binding, you can confirm the Secret's creation and inspect its (base64 encoded) contents.
    * **Commands to retrieve Secrets:**
        * `kubectl get secrets` (lists all Secrets in the namespace).
        * `kubectl describe secret <secret-name>` (shows details, but values are hidden/encoded).
        * `kubectl get secret <secret-name> -o yaml` (shows the base64 encoded values).
    * You can also view secrets via the Kubernetes Dashboard UI or the IBM Cloud Kubernetes Service UI.
4.  **Configure your application to access the service credentials from the Kubernetes Secret:**
    * This is how your application consumes the credentials. There are two primary methods:

    * **a) Mount the Secret as a Volume to your Pod:**
        * The Secret is mounted as a file or directory within the Pod's filesystem.
        * The content (e.g., JSON) of the Secret is made available as a file (e.g., named `binding`) in the specified `volumeMounts` directory.
        * **Example:** A `binding` file at `/etc/secrets/binding` containing the JSON credentials. Your application then reads and parses this file.

    * **b) Reference the Secret in Environment Variables:**
        * Specific keys from the Secret are exposed as environment variables within the Pod's containers.
        * The values are automatically decoded from base64 by Kubernetes.
        * **Example:** For a Node.js application, environment variables like `BINDING_API_KEY`, `BINDING_USERNAME`, `BINDING_PASSWORD` could be populated from corresponding keys in the Secret. The application would then access them via `process.env.<VARIABLE_NAME>`.

### Key Takeaways:

* Service binding facilitates the consumption of external/backing services by Kubernetes applications.
* It automatically provides service credentials to your application, typically stored securely as a Kubernetes `Secret`.
* Binding manages configuration and credentials for backend services while protecting sensitive data.
* Applications can configure themselves to use these credentials either by:
    * Mounting the Secret as a volume to the Pod.
    * Referencing the Secret keys in environment variables.

This process ensures that application code remains clean and doesn't contain hard-coded credentials, promoting security and maintainability.

---

# Verify the environment and command line tools

Okay, let's get your environment set up and verify the command-line tools for this lab.

---

## Verify the Environment and Command Line Tools

Follow these steps to ensure your terminal is ready and you have the necessary lab artifacts.

### Step 1: Open a Terminal Window

If you don't already have a terminal open in your lab environment, create a new one:

* **Action:** Go to the menu in the editor and select `Terminal > New Terminal`.

* **Note:** It might take a moment for the terminal prompt to appear. If it doesn't show up after 5 minutes, you might need to close the browser tab and relaunch the lab.

### Step 2: Change to your project folder

Ensure you are in the primary project directory. If your terminal prompt already shows `/home/project`, you can skip this step.

**Command:**

```bash
cd /home/project
```

**Explanation:**
* `cd`: The `change directory` command.
* `/home/project`: The target directory.

### Step 3: Clone the Git repository

Now, clone the repository containing the lab artifacts. This command will only execute if the `CC201` directory doesn't already exist, preventing redundant cloning.

**Command:**

```bash
[ ! -d 'CC201' ] && git clone https://github.com/ibm-developer-skills-network/CC201.git
```

**Explanation:**
* `[ ! -d 'CC201' ]`: This is a shell conditional.
    * `!` : Negates the following condition.
    * `-d 'CC201'`: Checks if a directory named `CC201` exists.
    * So, `[ ! -d 'CC201' ]` means "if the directory 'CC201' does NOT exist".
* `&&`: This is a logical AND operator. The command after `&&` will only run if the command before it succeeds (i.e., if the `CC201` directory does not exist).
* `git clone https://github.com/ibm-developer-skills-network/CC201.git`: Clones the specified Git repository.

**Expected Output (if cloning):**

```
Cloning into 'CC201'...
remote: Enumerating objects: XX, done.
remote: Counting objects: XX% (X/X), done.
remote: Compressing objects: XX% (X/X), done.
remote: Total XX (delta X), reused XX (delta X), pack-reused X
Receiving objects: XX% (X/X), XXX KiB | X.X MiB/s, done.
Resolving deltas: XX% (X/X), done.
```
*(The specific numbers and speed will vary.)*

### Step 4: Change to the specific lab directory

Navigate into the directory that contains the files for this particular lab on Kubernetes scaling and updates.

**Command:**

```bash
cd CC201/labs/3_K8sScaleAndUpdate/
```

### Step 5: List the contents of the directory

Finally, list the contents of the current directory to confirm that you are in the correct place and can see the necessary lab files.

**Command:**

```bash
ls
```

**Expected Output (example):**

You should see files related to this lab, such as YAML configuration files:

```
hello-world-deployment.yaml hello-world-hpa.yaml
```

You are now ready to proceed with the lab exercises!
---




# Build and push application image to IBM Cloud Container Registry


Okay, let's build and push your application image to the IBM Cloud Container Registry. This is a crucial step to make your application accessible to your Kubernetes cluster.

### Step 1: Export your namespace as an environment variable

First, set your unique namespace as an environment variable. This simplifies subsequent commands by allowing you to use `$MY_NAMESPACE` instead of typing out the full namespace each time. Remember that `$USERNAME` will be replaced by your actual lab username.

**Command:**

```bash
export MY_NAMESPACE=sn-labs-$USERNAME
```

**Explanation:**
* `export`: Makes the variable available to child processes.
* `MY_NAMESPACE`: The name of the environment variable.
* `sn-labs-$USERNAME`: Your unique namespace (e.g., `sn-labs-yourusername`).

*(There will be no output from this command.)*

### Step 2: Use the Explorer to view the Dockerfile

It's a good practice to inspect the `Dockerfile` to understand how your application image is being built.

* **Action:** In the left-hand panel, click on the **Explorer icon** (often looks like a sheet of paper or folder).
* **Navigation:** Ensure you are in the `CC201/labs/3_K8sScaleAndUpdate/` directory.
* **File:** Click on `Dockerfile` to open it in the editor.

You'll see the instructions that define your application's image.

### Step 3: Build and push the application image

Now, you'll build the Docker image for your `hello-world` application and push it to the IBM Cloud Container Registry. This is a combined command that first builds the image and then pushes it if the build is successful.

**Command:**

```bash
docker build -t us.icr.io/$MY_NAMESPACE/hello-world:1 . && docker push us.icr.io/$MY_NAMESPACE/hello-world:1
```

**Explanation:**
* `docker build`: Command to build a Docker image.
    * `-t us.icr.io/$MY_NAMESPACE/hello-world:1`: Tags the image with a name and version (`us.icr.io` is the registry, `$MY_NAMESPACE` is your namespace, `hello-world` is the image name, and `1` is the tag/version).
    * `.`: Specifies that the `Dockerfile` is in the current directory.
* `&&`: This is a logical AND operator. The `docker push` command will only execute if the `docker build` command completes successfully.
* `docker push us.icr.io/$MY_NAMESPACE/hello-world:1`: Pushes the tagged image to the specified container registry.

**Expected Output:**

You will see output indicating the build process (steps from the Dockerfile) and then the push process. If this is your first time pushing or if the image was deleted, you'll see messages like `Pushed`.

```
[+] Building 0.2s (7/7) FINISHED
 => [internal] load build definition from Dockerfile                                                                     0.0s
 => [internal] load .dockerignore                                                                                        0.0s
 => [internal] load metadata for docker.io/library/node:18-alpine                                                        0.0s
 => [1/3] FROM node:18-alpine                                                                                            0.0s
 => [2/3] WORKDIR /app                                                                                                   0.0s
 => [3/3] COPY . .                                                                                                       0.0s
 => exporting to image                                                                                                   0.0s
 => => exporting layers                                                                                                  0.0s
 => => writing image sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                             0.0s
 => => naming to us.icr.io/sn-labs-<your_username>/hello-world:1                                                        0.0s

The push refers to repository [us.icr.io/sn-labs-<your_username>/hello-world]
3f48a56f671c: Pushed
b7496ef9c1a5: Pushed
2174c776fb08: Pushed
1: digest: sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx size: 948
```

**Note on "Layer already Exists":**
If you have previously run this lab or pushed this specific image, you might see "Layer already Exists" messages instead of "Pushed". This is normal and means the Docker daemon has already pushed those layers. You can safely proceed with the lab steps.

Once this command completes, your application image will be available in the IBM Cloud Container Registry, ready for Kubernetes to pull and deploy.


# Deploy the application to Kubernetes

Okay, let's deploy your `hello-world` application to your Kubernetes cluster!

### Step 1: Edit `deployment.yaml` with your namespace

You need to personalize the `deployment.yaml` file by inserting your specific Kubernetes namespace.

1.  **Find your namespace:** In your **original terminal window**, run:
    ```bash
    echo $MY_NAMESPACE
    ```
    This will display your namespace (e.g., `sn-labs-yourusername`). Copy this value.

2.  **Open `deployment.yaml`:**
    * In the Explorer panel (left sidebar), navigate to `CC201/labs/3_K8sScaleAndUpdate/`.
    * Click on `deployment.yaml` to open it in the editor.

3.  **Insert your namespace:**
    * Locate the line that contains `<my_namespace>`.
    * **Replace `<my_namespace>` with the namespace you copied** from `echo $MY_NAMESPACE`.
    * **Save the file** (usually `Ctrl+S` or `Cmd+S`, or by going to `File > Save`).

### Step 2: Run your image as a Deployment

Now, apply the modified `deployment.yaml` file to create your Kubernetes Deployment.

**Command (in the original terminal):**

```bash
kubectl apply -f deployment.yaml
```

**Explanation:**
* `kubectl apply -f`: Applies a configuration from a file.
* `deployment.yaml`: The file containing your Deployment definition.

**Expected Output:**

```
deployment.apps/hello-world created
```
*Note:* If you've run this lab before and the deployment already exists, you might see `deployment.apps/hello-world unchanged`. This is normal; proceed to the next step.

### Step 3: List Pods until the status is “Running”

Wait for your application's Pod to transition to a "Running" state. This might take a moment as Kubernetes pulls the image and starts the container.

**Command (in the original terminal):**

```bash
kubectl get pods
```

**Expected Output (keep running until you see "Running"):**

Initially, you might see statuses like `ContainerCreating`:

```
NAME                          READY   STATUS              RESTARTS   AGE
hello-world-85b46b7d5-abcde   0/1     ContainerCreating   0          5s
```

Eventually, it should show `Running`:

```
NAME                          READY   STATUS    RESTARTS   AGE
hello-world-85b46b7d5-abcde   1/1     Running   0          45s
```
*Note:* Do not proceed until you see `Running`. If it stays `ContainerCreating` for a while, try re-running the command.

### Step 4: Expose the application via a Kubernetes Service

To make your application accessible within the cluster, you'll create a `ClusterIP` Service.

**Command (in the original terminal):**

```bash
kubectl expose deployment/hello-world
```

**Explanation:**
* `kubectl expose deployment/hello-world`: Creates a Service that targets your `hello-world` Deployment. By default, this will be a `ClusterIP` Service.

**Expected Output:**

```
service/hello-world exposed
```

### Step 5: Open a new terminal window for `kubectl proxy`

To access your `ClusterIP` Service from outside the cluster (for testing purposes), you'll use `kubectl proxy`. This command runs continuously, so you need a separate terminal.

* **Action:** Go to the editor menu and select `Terminal > New Terminal`.
* **Important:** **Do not close your original terminal window.**

### Step 6: Run `kubectl proxy` in the NEW terminal

This command will create a proxy server on your local machine that forwards requests to the Kubernetes API server, allowing you to access internal services.

**Command (in the **NEW SPLIT TERMINAL**):**

```bash
kubectl proxy
```

**Expected Output:**

```
Starting to serve on 127.0.0.1:8001
```
*This command will continue running and will not return to the prompt. Keep this terminal window open and running the proxy.*

### Step 7: Ping the application to get a response

Now, switch back to your **original terminal window**. You will use `curl` to send a request through the `kubectl proxy` to your `hello-world` application.

**Command (in the **ORIGINAL TERMINAL**):**

```bash
curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy
```

**Explanation:**
* `curl -L`: Command to make an HTTP request, `-L` follows redirects.
* `localhost:8001`: The address where `kubectl proxy` is listening.
* `/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy`: The path through the Kubernetes API to reach your `hello-world` Service within your namespace.

**Expected Output:**

```
Hello world from hello-world-xxxxxxxx-xxxx. Your app is up and running!
```
*(The specific Pod name will vary.)*

You have successfully deployed your application and verified its accessibility!


# Scaling the application using a ReplicaSet

Now that your application is deployed, let's observe how Kubernetes handles scaling using a ReplicaSet, which is automatically managed by your Deployment.

### Step 1: Scale Up Your Deployment to 3 Replicas

You'll use the `kubectl scale` command to increase the number of running instances (Pods) of your `hello-world` application.

**Command (in the terminal window that is *not* running the `proxy` command):**

```bash
kubectl scale deployment hello-world --replicas=3
```

**Explanation:**
* `kubectl scale`: Command used to change the number of running instances of a resource.
* `deployment hello-world`: Specifies the target resource is a Deployment named `hello-world`.
* `--replicas=3`: Sets the desired number of Pod replicas to 3.

**Expected Output:**

```
deployment.apps/hello-world scaled
```

### Step 2: Get Pods to ensure three Pods are running

After scaling, Kubernetes (via the Deployment and its underlying ReplicaSet) will work to create new Pods to meet the desired count. It might take a moment for them to reach the "Running" state.

**Command (in the same terminal):**

```bash
kubectl get pods
```

**Expected Output (keep running until you see three Pods in "Running" status):**

You will initially see one running Pod and two new ones being created:

```
NAME                           READY   STATUS              RESTARTS   AGE
hello-world-85b46b7d5-abcde    1/1     Running             0          2m
hello-world-85b46b7d5-fghij    0/1     ContainerCreating   0          5s
hello-world-85b46b7d5-klmno    0/1     ContainerCreating   0          5s
```

Eventually, all three should be `Running`:

```
NAME                           READY   STATUS    RESTARTS   AGE
hello-world-85b46b7d5-abcde    1/1     Running   0          2m30s
hello-world-85b46b7d5-fghij    1/1     Running   0          30s
hello-world-85b46b7d5-klmno    1/1     Running   0          30s
```

### Step 3: Ping your application multiple times to observe Load Balancing

Now that you have multiple Pods, you can see Kubernetes' built-in load balancing in action. The `kubectl proxy` (running in your *other* terminal) will distribute requests across the available Pods.

**Command (in the terminal *not* running the `proxy`):**

```bash
for i in `seq 10`; do curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy; done
```

**Explanation:**
* `for i in `seq 10``: A shell loop that runs the `curl` command 10 times.
* `curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy`: The same `curl` command you used earlier.

**Expected Output:**

You should see 10 lines of output. Notice that the Pod ID at the end of the message (`hello-world-xxxxxxxx-xxxx`) will change, indicating that different Pods are responding to your requests.

```
Hello world from hello-world-85b46b7d5-abcde. Your app is up and running!
Hello world from hello-world-85b46b7d5-fghij. Your app is up and running!
Hello world from hello-world-85b46b7d5-klmno. Your app is up and running!
Hello world from hello-world-85b46b7d5-abcde. Your app is up and running!
... (and so on, cycling through the Pods)
```

### Step 4: Scale Down Your Deployment to 1 Replica

Just as easily as you scaled up, you can scale down. Kubernetes will gracefully terminate surplus Pods.

**Command (in the terminal *not* running the `proxy`):**

```bash
kubectl scale deployment hello-world --replicas=1
```

**Expected Output:**

```
deployment.apps/hello-world scaled
```

### Step 5: Check the Pods to confirm scale-down

Now, observe the Pods. Two of them will be marked for deletion.

**Command (in the same terminal):**

```bash
kubectl get pods
```

**Expected Output (initially):**

You'll see one `Running` Pod and two `Terminating` Pods:

```
NAME                          READY   STATUS        RESTARTS   AGE
hello-world-85b46b7d5-abcde   1/1     Running       0          3m
hello-world-85b46b7d5-fghij   1/1     Terminating   0          1m
hello-world-85b46b7d5-klmno   1/1     Terminating   0          1m
```

**Repeat the `kubectl get pods` command** after a few moments. Eventually, only one Pod should remain:

```
NAME                          READY   STATUS    RESTARTS   AGE
hello-world-85b46b7d5-abcde   1/1     Running   0          3m30s
```

You have successfully demonstrated scaling your application up and down, and observed Kubernetes' load-balancing capabilities.



#  Perform rolling updates

Let's perform rolling updates to your application. This process allows you to deploy new versions with minimal to no downtime, and easily roll back if issues arise.

### Step 1: Edit `app.js` to change the welcome message

You'll modify the application's source code to create a visually different version.

1.  **Open `app.js`:**
    * In the Explorer panel (left sidebar), navigate to `CC201/labs/3_K8sScaleAndUpdate/`.
    * Click on `app.js` to open it in the editor.

2.  **Change the welcome message:**
    * Find the line: `'Hello world from ' + hostname + '! Your app is up and running!\n'`
    * **Change it to:** `'Welcome to ' + hostname + '! Your app is up and running!\n'`

3.  **Save the file** (Ctrl+S or Cmd+S, or File > Save).

### Step 2: Build and push the new version (tag: 2) to Container Registry

Now, build a new Docker image from your modified `app.js` and push it to the IBM Cloud Container Registry with a new tag (`:2`). Remember to use the terminal window *that isn't running the `proxy` command*.

**Command (in the original terminal):**

```bash
docker build -t us.icr.io/$MY_NAMESPACE/hello-world:2 . && docker push us.icr.io/$MY_NAMESPACE/hello-world:2
```

**Explanation:**
* `docker build -t ...:2 .`: Builds the image and tags it as version `2`.
* `&& docker push ...:2`: Pushes this new version `2` to the registry.

**Expected Output:**

Similar to before, you'll see build output followed by push output. You might see "Layer already Exists" messages if common layers haven't changed.

```
[+] Building ...
... (build output) ...
Successfully built ...
Successfully tagged us.icr.io/sn-labs-<your_username>/hello-world:2

The push refers to repository [us.icr.io/sn-labs-<your_username>/hello-world]
... (push output) ...
2: digest: sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx size: 948
```

### Step 3: List images in Container Registry

Verify that both versions of your application image are now present in your Container Registry.

**Command (in the original terminal):**

```bash
ibmcloud cr images
```

**Expected Output:**

You should see both version `1` and version `2` of your `hello-world` image. Look for the `hello-world` repository and verify the tags.

```
Repository                  Tag      Digest         Namespace             Created          Size     Security Status
us.icr.io/sn-labs-<your_username>/hello-world   1        sha256:...     sn-labs-<your_username>   ...              ...      No Issues
us.icr.io/sn-labs-<your_username>/hello-world   2        sha256:...     sn-labs-<your_username>   ...              ...      No Issues
```
**NOTE:** Ensure the `Security Status` for the new image is `No Issues`. If not, re-run the `docker build` and `docker push` command until it shows `No Issues`.

### Step 4: Update the Deployment to use the new version

Now, instruct your Kubernetes Deployment to use the newly pushed version `2` of your application image. Kubernetes will then initiate a rolling update.

**Command (in the original terminal):**

```bash
kubectl set image deployment/hello-world hello-world=us.icr.io/$MY_NAMESPACE/hello-world:2
```

**Explanation:**
* `kubectl set image`: A command to update the image of a container in a Deployment (or other workload).
* `deployment/hello-world`: Specifies the target Deployment.
* `hello-world=us.icr.io/$MY_NAMESPACE/hello-world:2`: Sets the container named `hello-world` (within the Deployment) to use the new image tagged `2`.

**Expected Output:**

```
deployment.apps/hello-world image updated
```

### Step 5: Get the status of the rolling update

Monitor the progress of your rolling update. Kubernetes will incrementally replace old Pods with new ones running version 2.

**Command (in the original terminal):**

```bash
kubectl rollout status deployment/hello-world
```

**Expected Output:**

You will see progress messages until the rollout is complete.

```
Waiting for deployment "hello-world" rollout to finish: 1 out of 1 new replicas have been updated...
deployment "hello-world" successfully rolled out
```

### Step 6: Get the Deployment with the `wide` option to verify the image tag

Confirm that your Deployment is now configured to use the `2` tag.

**Command (in the original terminal):**

```bash
kubectl get deployments -o wide
```

**Expected Output:**

Look for the `IMAGES` column. It should show `us.icr.io/sn-labs-<your_username>/hello-world:2`.

```
NAME          READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS    IMAGES                                               SELECTOR
hello-world   1/1     1            1           5m    hello-world   us.icr.io/sn-labs-<your_username>/hello-world:2   app=hello-world
```

### Step 7: Ping your application to confirm the new welcome message

Access your application again. You should now see the "Welcome to..." message.

**Command (in the original terminal):**

```bash
curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy
```

**Expected Output:**

```
Welcome to hello-world-xxxxxxxx-xxxx! Your app is up and running!
```
*(The specific Pod name will vary.)*

---

### Perform Rollback

If a new version introduces a bug or you simply need to revert, Kubernetes makes rolling back easy.

### Step 8: Rollback the Deployment

This command will revert your Deployment to its previous version (version 1).

**Command (in the original terminal):**

```bash
kubectl rollout undo deployment/hello-world
```

**Expected Output:**

```
deployment.apps/hello-world rolled back
```

### Step 9: Get the status of the rolling update (rollback)

Monitor the progress of the rollback.

**Command (in the original terminal):**

```bash
kubectl rollout status deployment/hello-world
```

**Expected Output:**

```
Waiting for deployment "hello-world" rollout to finish: 1 out of 1 new replicas have been updated...
deployment "hello-world" successfully rolled out
```

### Step 10: Get the Deployment with the `wide` option to verify the old image tag

Confirm that your Deployment has reverted to using the `1` tag.

**Command (in the original terminal):

```bash
kubectl get deployments -o wide
```

**Expected Output:**

Look for the `IMAGES` column. It should now show `us.icr.io/sn-labs-<your_username>/hello-world:1`.

```
NAME          READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS    IMAGES                                               SELECTOR
hello-world   1/1     1            1           6m    hello-world   us.icr.io/sn-labs-<your_username>/hello-world:1   app=hello-world
```

### Step 11: Ping your application to confirm the original message

Access your application again. You should now see the original "Hello world..." message.

**Command (in the original terminal):**

```bash
curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy
```

**Expected Output:**

```
Hello world from hello-world-xxxxxxxx-xxxx! Your app is up and running!
```
*(The specific Pod name will vary.)*

You have successfully performed both a rolling update and a rollback, demonstrating Kubernetes' capability for seamless application version management!



# Using a ConfigMap to store configuration

Now we'll move on to a powerful Kubernetes feature: using ConfigMaps to manage application configuration. This allows you to update settings without rebuilding your Docker image.

### Step 1: Create a ConfigMap that contains a new message

First, let's create a ConfigMap named `app-config` and store a message within it.

**Command (in the original terminal):**

```bash
kubectl create configmap app-config --from-literal=MESSAGE="This message came from a ConfigMap!"
```

**Explanation:**
* `kubectl create configmap`: Creates a new ConfigMap.
* `app-config`: The name of your ConfigMap.
* `--from-literal=MESSAGE="..."`: Specifies a key-value pair to store, where `MESSAGE` is the key and `"This message came from a ConfigMap!"` is its value.

**Expected Output:**

```
configmap/app-config created
```
*Note:* If you get an "already exists" error, it's fine; proceed to the next step.

### Step 2: Edit `deployment-configmap-env-var.yaml` with your namespace

You need to update this new deployment file with your specific namespace.

1.  **Open `deployment-configmap-env-var.yaml`:**
    * In the Explorer panel (left sidebar), navigate to `CC201/labs/3_K8sScaleAndUpdate/`.
    * Click on `deployment-configmap-env-var.yaml` to open it.

2.  **Insert your namespace:**
    * Locate the line that contains `<my_namespace>` under `image: us.icr.io/<my_namespace>/hello-world:3`.
    * **Replace `<my_namespace>` with your actual namespace** (e.g., `sn-labs-yourusername`).

3.  **Observe `envFrom` section:** Notice the `envFrom` section that points to your `app-config` ConfigMap. This tells Kubernetes to load all key-value pairs from `app-config` as environment variables into the Pod.

    ```yaml
    containers:
    - name: hello-world
      image: us.icr.io/<my_namespace>/hello-world:3
      ports:
      - containerPort: 8080
      envFrom: # This section is crucial for ConfigMap consumption
      - configMapRef:
          name: app-config
    ```

4.  **Save the file.**

### Step 3: Edit `app.js` to read from environment variable

Now, modify your application code to read the message from an environment variable instead of a hardcoded string.

1.  **Open `app.js`:**
    * In the Explorer panel, navigate to `CC201/labs/3_K8sScaleAndUpdate/`.
    * Click on `app.js`.

2.  **Edit the `res.send` line:**
    * Find the line: `res.send('Welcome to ' + hostname + '! Your app is up and running!\n')`
    * **Change it to:** `res.send(process.env.MESSAGE + '\n')`

3.  **Save the file.**

### Step 4: Build and push a new image (tag: 3)

Since you modified `app.js`, you need to build a new Docker image containing these code changes and push it to the registry. This time, tag it as version `3`.

**Command (in the original terminal):**

```bash
docker build -t us.icr.io/$MY_NAMESPACE/hello-world:3 . && docker push us.icr.io/$MY_NAMESPACE/hello-world:3
```

**Expected Output:**

Similar to previous builds/pushes, indicating success for building and pushing the `hello-world:3` image.

### Step 5: Apply the new Deployment configuration

Now, apply the `deployment-configmap-env-var.yaml` file. This will create a new Deployment (or update the existing one) that uses the `hello-world:3` image and is configured to pull environment variables from the `app-config` ConfigMap.

**Command (in the original terminal):**

```bash
kubectl apply -f deployment-configmap-env-var.yaml
```

**Expected Output:**

```
deployment.apps/hello-world configured
```
*Note:* If it says `created`, it means the previous deployment was implicitly deleted. If it says `configured`, it means an update was applied.

### Step 6: Ping your application to see the message from ConfigMap

It might take a few moments for the new Pods to start and read the ConfigMap. Keep pinging until you see the new message.

**Command (in the original terminal):**

```bash
curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy
```

**Expected Output (keep running until you see this):**

```
This message came from a ConfigMap!
```
If you still see the old message ("Hello world" or "Welcome to"), wait a few more seconds and retry.

---

### Demonstrating Dynamic Configuration Update (without image rebuild)

This is where the power of ConfigMaps shines! You can update the configuration without touching your application code or rebuilding the image.

### Step 7: Delete the old ConfigMap and create a new one with a different message

You'll perform this in a single command, first deleting the old ConfigMap, then creating a new one with the exact same name but updated content.

**Command (in the original terminal):**

```bash
kubectl delete configmap app-config && kubectl create configmap app-config --from-literal=MESSAGE="This message is different, and you didn't have to rebuild the image!"
```

**Expected Output:**

```
configmap "app-config" deleted
configmap/app-config created
```

### Step 8: Restart the Deployment (for environment variables to refresh)

When ConfigMaps are consumed as environment variables, Pods generally only load them at *startup time*. To make the new ConfigMap changes effective, you need to restart the Pods in your Deployment.

**Command (in the original terminal):**

```bash
kubectl rollout restart deployment hello-world
```

**Explanation:**
* `kubectl rollout restart`: Triggers a new rollout of the Deployment, effectively restarting all its Pods. This forces them to pick up the new environment variable value from the updated ConfigMap.

**Expected Output:**

```
deployment.apps/hello-world restarted
```
You can optionally run `kubectl get pods` to watch the old Pod terminate and new ones spin up.

### Step 9: Ping your application again to see the new message

Once the new Pods are running, they will have loaded the updated message from the ConfigMap.

**Command (in the original terminal):**

```bash
curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy
```

**Expected Output:**

```
This message is different, and you didn't have to rebuild the image!
```

This demonstrates how ConfigMaps enable dynamic configuration updates without requiring application code changes or image rebuilds, which is incredibly powerful for managing applications in Kubernetes!

---

# Autoscale the hello-world application using Horizontal Pod Autoscaler

Alright, let's set up **Horizontal Pod Autoscaling (HPA)** for your `hello-world` application. This will allow your application to automatically scale its Pods based on CPU utilization, accommodating varying loads efficiently.

---

## Autoscale Your `hello-world` Application with HPA

### Step 1: Add CPU Resource Utilization to `deployment.yaml`

For HPA to work effectively, your containers need to have CPU **requests** and **limits** defined. This helps Kubernetes understand how much CPU a Pod needs and how much it can burst.

1.  **Open `deployment.yaml`:**
    * In the Explorer panel (left sidebar), navigate to `CC201/labs/3_K8sScaleAndUpdate/`.
    * Click on `deployment.yaml` to open it in the editor.

2.  **Add the `resources` section:**
    * Locate the `containers` section within your `template.spec`.
    * Find the `name: hello-world` (or similar) under `containers`.
    * **Carefully add the `resources` block** directly below the `ports` section, ensuring correct indentation.

    The `containers` section of your `deployment.yaml` should now look something like this (ensure your namespace is still in the image path):

    ```yaml
    containers:
    - name: hello-world
      image: us.icr.io/<my_namespace>/hello-world:3 # Ensure your namespace is here
      ports:
      - containerPort: 8080
      resources: # Add this section
        limits:
          cpu: 50m
        requests:
          cpu: 20m
      envFrom:
      - configMapRef:
          name: app-config
    ```
    * `cpu: 50m`: Sets a CPU limit of 50 milli-cores (0.05 CPU core).
    * `cpu: 20m`: Sets a CPU request of 20 milli-cores (0.02 CPU core).

3.  **Save the file.**

### Step 2: Apply the updated Deployment

Apply the `deployment.yaml` file to update your existing Deployment with the new resource definitions.

**Command (in your **original terminal**):**

```bash
kubectl apply -f deployment.yaml
```

**Expected Output:**

```
deployment.apps/hello-world configured
```

### Step 3: Autoscale the `hello-world` Deployment

Now, create the Horizontal Pod Autoscaler (HPA) resource that will automatically manage the scaling of your `hello-world` Deployment.

**Command (in your **original terminal**):**

```bash
kubectl autoscale deployment hello-world --cpu-percent=5 --min=1 --max=10
```

**Explanation:**
* `kubectl autoscale deployment hello-world`: Targets the `hello-world` Deployment for autoscaling.
* `--cpu-percent=5`: The HPA will try to maintain an average CPU utilization of 5% across all Pods. If it goes above, it scales up; if it goes below, it scales down.
* `--min=1`: The minimum number of Pod replicas the HPA will scale down to.
* `--max=10`: The maximum number of Pod replicas the HPA will scale up to.

**Expected Output:**

```
horizontalpodautoscaler.autoscaling/hello-world autoscaled
```

### Step 4: Check the current status of the HorizontalPodAutoscaler

Verify that the HPA has been created.

**Command (in your **original terminal**):**

```bash
kubectl get hpa hello-world
```

**Expected Output:**

You'll see the HPA resource and its initial state. The `TARGETS` might show `<unknown>/5%` or a low percentage if no load is applied yet, and `REPLICAS` will likely be `1`.

```
NAME          REFERENCE                TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
hello-world   Deployment/hello-world   <unknown>/5%    1         10        1          X
```

### Step 5: Ensure `kubectl proxy` is running (New Terminal)

For load generation, ensure your `kubectl proxy` command is still active. If not, open a **new terminal window** and run it:

**Command (in a **NEW terminal window**):**

```bash
kubectl proxy
```

**Expected Output:**

```
Starting to serve on 127.0.0.1:8001
```

### Step 6: Spam the app with requests to increase load (Another New Terminal)

Now, open yet **another new terminal window** (you'll have three terminals open now: original, proxy, and load generator). This command will send a high volume of requests to your application, simulating increased load to trigger the HPA.

**Command (in this **THIRD terminal window**):**

```bash
for i in `seq 100000`; do curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/hello-world/proxy; done
```

**Explanation:**
* This `for` loop will rapidly send 100,000 `curl` requests to your application. Keep this running to generate continuous load.

### Step 7: Observe replicas increase with autoscaling (Original Terminal)

Go back to your **original terminal window**. Use the `watch` command to continuously monitor the HPA status. You should soon see the `REPLICAS` count increase as the CPU utilization rises above the 5% target.

**Command (in your **original terminal**):**

```bash
kubectl get hpa hello-world --watch
```

**Expected Output (will update over time):**

Initially:

```
NAME          REFERENCE                TARGETS        MINPODS   MAXPODS   REPLICAS   AGE
hello-world   Deployment/hello-world   <unknown>/5%   1         10        1          Xm
```

After some load, you'll see the `TARGETS` increase, and then the `REPLICAS` will start increasing:

```
NAME          REFERENCE                TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
hello-world   Deployment/hello-world   100%/5%    1         10        1          Xm
hello-world   Deployment/hello-world   100%/5%    1         10        2          Xm
hello-world   Deployment/hello-world   100%/5%    1         10        3          Xm
... (and so on, up to MAXPODS of 10, or until load drops)
```
You will see that the HPA automatically scales your application by increasing the number of Pod replicas.

* **Stop this command by pressing `CTRL + C`** once you've observed the scaling.

### Step 8: Observe the details of the Horizontal Pod Autoscaler (Original Terminal)

After stopping the `watch` command, run `kubectl get hpa` one more time to see the final scaled state.

**Command (in your **original terminal**):**

```bash
kubectl get hpa hello-world
```

**Expected Output:**

The `REPLICAS` column should reflect the increased number of Pods due to the load.

```
NAME          REFERENCE                TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
hello-world   Deployment/hello-world   XXX%/5%    1         10        X          Xm
```
*(Where `XXX` is the current CPU percentage and `X` is the current number of replicas, which should be greater than 1)*

### Step 9: Stop proxy and load generation commands

Now that you've demonstrated autoscaling, stop the continuous commands running in the other two terminals.

* Go to the terminal running `kubectl proxy` and press `CTRL + C`.
* Go to the terminal running the `for` loop (load generation) and press `CTRL + C`.

---

### Clean Up

Finally, let's clean up the resources you created in this lab.

### Step 10: Delete the Deployment

This will automatically delete the associated Pods and the HPA.

**Command (in your **original terminal**):**

```bash
kubectl delete deployment hello-world
```

**Expected Output:**

```
deployment.apps "hello-world" deleted
horizontalpodautoscaler.autoscaling "hello-world" deleted
```

### Step 11: Delete the Service

Delete the service that was exposing your application.

**Command (in your **original terminal**):**

```bash
kubectl delete service hello-world
```

**Expected Output:**

```
service "hello-world" deleted
```

---

**Congratulations!** You have successfully completed the lab, demonstrating how to scale your application manually with ReplicaSets, perform rolling updates, manage configuration with ConfigMaps, and automatically scale your application using the Horizontal Pod Autoscaler based on CPU load!


# Reading: Transforming Retail - The Impact of Kubernetes and Containerization

This reading provides a comprehensive overview of how Kubernetes and containerization are transforming the retail sector by addressing critical IT infrastructure challenges.

---

## Transforming Retail: The Impact of Kubernetes and Containerization

**Estimated Reading Time:** 20 minutes

**Objectives:**
* Identify key challenges in the retail sector and strategies to address them.
* Recognize the role of Kubernetes and containerization as a transformative solution.
* Describe the impact of Kubernetes and containerization on retail.

---

### Critical Hurdles in the Retail Sector

The retail industry, with its demanding need for seamless in-store and online experiences, faces substantial IT infrastructure challenges, particularly due to fluctuating traffic and the need for rapid innovation.

**Key Challenges:**

1.  **Scalability Issues:**
    * Retail platforms struggle to manage sudden traffic surges during sales (e.g., Black Friday, holiday seasons).
    * Traditional systems often lead to performance degradation and downtime under high load due to inefficient scaling.
2.  **Deployment Bottlenecks:**
    * Introducing new features, updates, or frequent sales offers is slow and cumbersome.
    * Retailers need to deploy changes with minimal disruption to live services, which is challenging with monolithic architectures.
3.  **Resource Utilization:**
    * Difficulty in balancing resource provisioning; leads to either over-provisioning (wasted costs) or underutilization (inefficient use of computing power).
    * Poor resource management directly impacts operational costs.
4.  **Disaster Recovery:**
    * Many retailers lack robust disaster recovery (DR) strategies despite having DR and Business Continuity Plans.
    * This leaves them vulnerable to significant losses during system failures, making business continuity critical.

**Strategic Goals to Address Challenges:**

1.  **Enhance Scalability Performance:** Develop infrastructure that can dynamically scale to fluctuating loads while maintaining optimal performance.
2.  **Accelerate Deployment Cycles:** Establish efficient processes to smoothly introduce new features and updates with minimal downtime.
3.  **Optimize Resource Utilization:** Improve resource management to reduce costs and enhance operational efficiency.
4.  **Strengthen Disaster Recovery:** Create reliable DR plans to minimize downtime and ensure uninterrupted operations.

---

### Transformative Solutions: Leveraging Kubernetes and Containerization

Kubernetes and containerization provide a modern IT infrastructure solution to tackle these retail challenges.

1.  **Transition to Microservices Architecture:**
    * Breaking down monolithic applications into smaller, independent **microservices** enables flexible and scalable development. Each microservice can be developed, implemented, and scaled independently.
    * **Docker** is used to containerize these microservices, ensuring consistency across development, testing, and production environments, eliminating "it works on my machine" issues.

2.  **Kubernetes for Orchestration:**
    * **Orchestration:** Kubernetes automates the deployment, scaling, and management of containerized applications, providing an efficient way to handle complex infrastructure.
    * **Load Balancing and Auto-scaling:** Kubernetes dynamically adapts applications to varying traffic loads, ensuring consistent performance during peak hours and scaling down during off-peak times to reduce costs.

3.  **Implementing CI/CD Pipelines:**
    * **Continuous Integration/Continuous Deployment (CI/CD):** Automating the build, test, and deployment process (using tools like Jenkins, GitLab CI/CD, CircleCI) accelerates development cycles and improves reliability.
    * **Blue-Green Deployments:** Kubernetes supports advanced deployment strategies like blue-green deployments, allowing for seamless updates and immediate rollbacks without impacting users.

4.  **Resource Management and Cost Optimization:**
    * **Dynamic Resource Allocation:** Kubernetes optimizes resource allocation based on real-time demand, significantly improving utilization and reducing wasted compute power.
    * **Monitoring:** Integrating monitoring solutions (e.g., Prometheus and Grafana) provides deep insights into system performance and resource usage, aiding in further optimization.

5.  **Enhancing Disaster Recovery and High Availability:**
    * **Multi-Region Deployments:** Deploying Kubernetes clusters across multiple geographical regions inherently enhances high availability and disaster recovery capabilities by providing redundancy.
    * **Automated Backups:** Tools like Velero enable regular, automated backups of Kubernetes cluster states and persistent volumes, ensuring data integrity and rapid recovery in case of failures.

---

### Aftermath: Kubernetes-Containerization Impact on Retail

The adoption of Kubernetes and containerization has a profound and positive impact on retail operations:

1.  **Improved Scalability and Performance:**
    * Retailers can seamlessly manage traffic surges during sales events (like major holiday sales) without downtime or performance degradation due to Kubernetes' auto-scaling.
2.  **Faster Deployment Cycles:**
    * With CI/CD pipelines, retailers can deploy new features and updates multiple times a day, drastically reducing time-to-market from weeks to minutes, thereby enhancing customer satisfaction.
3.  **Optimized Resource Utilization:**
    * Dynamic resource management leads to significant reductions in operational costs. Retailers save money by scaling down resources during off-peak hours.
4.  **Enhanced Disaster Recovery:**
    * Multi-region Kubernetes clusters and automated backup solutions provide near-zero downtime during outages, ensuring retail platforms maintain uninterrupted service and minimize potential revenue losses during data center failures.

---

### Summary

In essence, the retail sector faces critical IT challenges related to scalability, deployment speed, resource utilization, and disaster recovery, driven by the demand for seamless shopping experiences and handling large traffic spikes. The adoption of Kubernetes and containerization is revolutionizing retail IT infrastructure. By embracing microservices and leveraging Kubernetes' powerful orchestration capabilities, retailers have achieved significant advancements in scalability, deployment speed, resource optimization, and disaster recovery, leading to more resilient, efficient, and cost-effective operations.


# Practice Lab: Autoscaling and Secrets Management

Okay, let's get your environment set up for this project, including verifying `kubectl` and cloning the necessary repository.

---

## Setup the Environment

### Step 1: Open a New Terminal

If you don't already have a terminal open, create a new one:

* **Action:** From the top menu bar, click `Terminal` and then select `New Terminal` from the drop-down menu.

*(If a terminal is already open and ready, you can skip this particular action.)*

### Step 2: Verify `kubectl` version

Before proceeding, it's essential to confirm that `kubectl` (the Kubernetes command-line tool) is installed and correctly configured to communicate with your cluster.

**Command:**

```bash
kubectl version
```

**Explanation:**
* `kubectl`: The command-line tool for running commands against Kubernetes clusters.
* `version`: Displays the client and server versions of Kubernetes.

**Expected Output:**

You should see output similar to this, indicating both a client and server version. The specific version numbers might differ, but the structure should be similar:

```
Client Version: version.Info{Major:"1", Minor:"2X", GitVersion:"v1.2X.X", GitCommit:"...", GitTreeState:"...", BuildDate:"...", GoVersion:"go1.XX.X", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v5.X.X
Server Version: version.Info{Major:"1", Minor:"2X", GitVersion:"v1.2X.X", GitCommit:"...", GitTreeState:"...", BuildDate:"...", GoVersion:"go1.XX.X", Compiler:"gc", Platform:"linux/amd64"}
```
* **`Client Version`**: This refers to the version of the `kubectl` tool installed on your machine.
* **`Server Version`**: This refers to the version of the Kubernetes API server running on your cluster.

Seeing both client and server versions confirms that `kubectl` is installed and connected to a Kubernetes cluster.

### Step 3: Clone the project repository

Now, you'll clone the Git repository that contains the starter code and necessary files for this project.

**Command:**

```bash
git clone https://github.com/ibm-developer-skills-network/k8-scaling-and-secrets-mgmt.git
```

**Explanation:**
* `git clone`: The Git command to download a repository.
* `https://github.com/ibm-developer-skills-network/k8-scaling-and-secrets-mgmt.git`: The URL of the repository to clone.

**Expected Output:**

You will see messages indicating the cloning process:

```
Cloning into 'k8-scaling-and-secrets-mgmt'...
remote: Enumerating objects: XX, done.
remote: Counting objects: XX% (X/X), done.
remote: Compressing objects: XX% (X/X), done.
remote: Total XX (delta X), reused XX (delta X), pack-reused X
Receiving objects: XX% (X/X), XXX KiB | X.X MiB/s, done.
Resolving deltas: XX% (X/X), done.
```
*(The specific numbers and speed will vary based on your connection and the repository size.)*

Once this command completes, you will have a new directory named `k8-scaling-and-secrets-mgmt` in your current working directory, containing all the project files. You are now ready to proceed with the lab exercises!

# Exercise 1: Build and deploy an application to Kubernetes

Alright, let's build, deploy, and verify your `myapp` application on Kubernetes.

---

## Exercise 1: Build and Deploy an Application to Kubernetes

In this exercise, you will create a Docker image from the provided `Dockerfile`, push it to the IBM Cloud Container Registry, and then deploy it to your Kubernetes cluster.

### Step 1: Build the Docker image

First, navigate into the cloned project directory and set your namespace. Then, build your Docker image.

1.  **Navigate to the project directory:**
    **Command:**
    ```bash
    cd k8-scaling-and-secrets-mgmt
    ```
    **Expected Output:** (No direct output, your terminal prompt should change to indicate you're in the directory)

2.  **Export your namespace:**
    **Command:**
    ```bash
    export MY_NAMESPACE=sn-labs-$USERNAME
    ```
    **Explanation:** This sets an environment variable that will be used in subsequent `docker` commands to tag your image correctly for the IBM Cloud Container Registry.
    **Expected Output:** (No direct output)

3.  **Build the Docker image:**
    **Command:**
    ```bash
    docker build . -t us.icr.io/$MY_NAMESPACE/myapp:v1
    ```
    **Explanation:**
    * `docker build .`: Builds a Docker image from the `Dockerfile` in the current directory (`.`).
    * `-t us.icr.io/$MY_NAMESPACE/myapp:v1`: Tags the image with a name (`myapp`) and a version (`v1`) in your IBM Cloud Container Registry namespace.
    **Expected Output:** You'll see the Docker build process, ending with a message similar to:
    ```
    [+] Building ...
    ... (various build steps) ...
    Successfully built <image_id>
    Successfully tagged us.icr.io/sn-labs-<your_username>/myapp:v1
    ```

### Step 2: Push and list the image

Now, push the image you just built to the container registry so your Kubernetes cluster can pull it.

1.  **Push the tagged image to the IBM Cloud Container Registry:**
    **Command:**
    ```bash
    docker push us.icr.io/$MY_NAMESPACE/myapp:v1
    ```
    **Explanation:** This command uploads your locally built and tagged image to the specified remote registry.
    **Expected Output:** You'll see progress indicators as layers are pushed, eventually ending with:
    ```
    The push refers to repository [us.icr.io/sn-labs-<your_username>/myapp]
    ... (layer push details) ...
    v1: digest: sha256:<digest_id> size: <size>
    ```

2.  **List all the images available:**
    **Command:**
    ```bash
    ibmcloud cr images
    ```
    **Explanation:** This command lists all container images in your IBM Cloud Container Registry account.
    **Expected Output:** You should see your newly pushed `myapp:v1` image in the list:
    ```
    Repository                   Tag      Digest         Namespace             Created          Size     Security Status
    us.icr.io/sn-labs-<your_username>/myapp      v1       sha256:<digest_id>   sn-labs-<your_username>   <timestamp>      <size>   No Issues
    ```

### Step 3: Deploy your application

Now, you'll apply the Kubernetes Deployment manifest to deploy your application.

1.  **Open and edit `deployment.yaml`:**
    * In your editor's Explorer pane, open the `deployment.yaml` file located in the `k8-scaling-and-secrets-mgmt` directory.
    * Find the line: `image: us.icr.io/<your SN labs namespace>/myapp:v1`
    * **Replace `<your SN labs namespace>` with your actual namespace** (e.g., `sn-labs-yourusername`). You can confirm your namespace by running `echo $MY_NAMESPACE` in the terminal.
    * **Save the file** after making the change.

2.  **Apply the deployment:**
    **Command:**
    ```bash
    kubectl apply -f deployment.yaml
    ```
    **Explanation:** This command instructs Kubernetes to create the Deployment defined in your `deployment.yaml` file.
    **Expected Output:**
    ```
    deployment.apps/myapp created
    ```

3.  **Verify that the application pods are running and accessible:**
    **Command:**
    ```bash
    kubectl get pods
    ```
    **Explanation:** This command lists the Pods in your current Kubernetes namespace. You're looking for your `myapp` Pod to be in the `Running` state.
    **Expected Output (keep running until `Running`):**
    ```
    NAME                     READY   STATUS              RESTARTS   AGE
    myapp-7c7d678b7b-xxxxx   0/1     ContainerCreating   0          5s
    ```
    After a short while, it should change to:
    ```
    NAME                     READY   STATUS    RESTARTS   AGE
    myapp-7c7d678b7b-xxxxx   1/1     Running   0          45s
    ```

### Step 4: View the application output

To access your application and verify its output, you'll use `kubectl port-forward`.

1.  **Start the application on port-forward:**
    **Command:**
    ```bash
    kubectl port-forward deployment.apps/myapp 3000:3000
    ```
    **Explanation:** This command forwards local port `3000` to port `3000` on the `myapp` Pod, making the application accessible from your local machine.
    **Expected Output:**
    ```
    Forwarding from 127.0.0.1:3000 -> 3000
    Forwarding from [::1]:3000 -> 3000
    ```
    *This command will continue running in the terminal. **Do not close this terminal window yet.***

2.  **Launch the app on Port `3000` to view the application output:**
    * **Action:** Open your web browser (or use `curl` in a *new* terminal) and navigate to `http://localhost:3000`.
    * **Expected Output in Browser:** You should see the message: `Hello from MyApp. Your app is up!`

3.  **Stop the port-forward server:**
    * **Action:** Go back to the terminal where `kubectl port-forward` is running and press `CTRL + C`.
    * **Expected Output:**
    ```
    Handling connection for 3000
    ... (potentially more handling messages) ...
    ^CUser interrupt, bye!
    ```

4.  **Create a ClusterIP service for exposing the application:**
    **Command:**
    ```bash
    kubectl expose deployment/myapp
    ```
    **Explanation:** This creates a Kubernetes Service (of type `ClusterIP` by default) that makes your `myapp` Deployment accessible to other services within your cluster.
    **Expected Output:**
    ```
    service/myapp exposed
    ```

You have successfully built, deployed, and verified your first application on Kubernetes!


# Exercise 2: Implement Vertical Pod Autoscaler (VPA)

Let's proceed with implementing the **Vertical Pod Autoscaler (VPA)** for your `myapp` application. VPA helps you optimize resource allocation for your Pods by automatically adjusting their CPU and memory requests and limits based on actual usage.

---

## Exercise 2: Implement Vertical Pod Autoscaler (VPA)

### Step 1: Create a VPA configuration

You will use the provided `vpa.yaml` file to define the VPA for your `myapp` deployment.

1.  **Explore the `vpa.yaml` file:**
    The content of `vpa.yaml` is designed to target your `myapp` Deployment and automatically adjust its resources.

    ```yaml
    apiVersion: autoscaling.k8s.io/v1
    kind: VerticalPodAutoscaler
    metadata:
      name: myvpa
    spec:
      targetRef:
        apiVersion: "apps/v1"
        kind: Deployment
        name: myapp
      updatePolicy:
        updateMode: "Auto" # VPA will automatically update the resource requests and limits
    ```
    **Explanation:**
    * `apiVersion: autoscaling.k8s.io/v1`: Specifies the API version for VPA.
    * `kind: VerticalPodAutoscaler`: Declares this object as a VPA.
    * `metadata.name: myvpa`: Gives a name to your VPA resource.
    * `spec.targetRef`: Defines which workload (in this case, your `myapp` Deployment) the VPA should monitor and adjust.
    * `spec.updatePolicy.updateMode: "Auto"`: This is the crucial setting that tells VPA to automatically apply its recommendations by updating the Pods' resource requests and limits.

### Step 2: Apply the VPA

Apply the `vpa.yaml` configuration to your Kubernetes cluster.

**Command (in your terminal):**

```bash
kubectl apply -f vpa.yaml
```

**Expected Output:**

```
verticalpodautoscaler.autoscaling/myvpa created
```

### Step 3: Retrieve the details of the VPA

Now, let's check if the VPA has been created and what recommendations it's providing.

1.  **Retrieve the created VPA:**
    **Command:**
    ```bash
    kubectl get vpa
    ```
    **Expected Output (example):**
    ```
    NAME    MODE   RECOMMENDATION      AGE
    myvpa   Auto   cpu: 25m, mem: 256Mi   29s
    ```
    This output shows that `myvpa` is in `Auto` mode and is already providing initial recommendations for CPU and memory. The `AGE` indicates how long it's been running.

2.  **Retrieve the detailed status and current running status of the VPA:**
    **Command:**
    ```bash
    kubectl describe vpa myvpa
    ```
    **Explanation:** The `describe` command provides a more verbose output, showing the full configuration, current status, and detailed resource recommendations.
    **Expected Output (example - specific values may vary):**

    ```
    Name:         myvpa
    Namespace:    default
    Labels:       <none>
    Annotations:  <none>
    API Version:  autoscaling.k8s.io/v1
    Kind:         VerticalPodAutoscaler
    Metadata:
      Creation Timestamp:  2025-06-02T10:00:00Z
    Spec:
      Target Ref:
        API Version:  apps/v1
        Kind:         Deployment
        Name:         myapp
      Update Policy:
        Update Mode:  Auto
    Status:
      Conditions:
        Last Transition Time:  2025-06-02T10:00:00Z
        Status:                True
        Type:                  RecommendationProvided
      Recommendation:
        Container Recommendations:
          Container Name:  myapp
          Lower Bound:
            Cpu:     25m
            Memory:  256Mi
          Target:
            Cpu:     25m
            Memory:  256Mi
          Uncapped Target:
            Cpu:     25m
            Memory:  256Mi
          Upper Bound:
            Cpu:     671m
            Memory:  1.34Gi
    Events:  <none>
    ```

    **Explanation of `kubectl describe vpa myvpa` output:**
    * **`Target Ref`**: Confirms that the VPA is targeting your `myapp` Deployment.
    * **`Update Mode: Auto`**: Reconfirms that VPA will automatically update your Pods.
    * **`Recommendation`**: This section is key. It provides the VPA's calculated resource recommendations for each container it manages (`myapp` in this case):
        * **`Lower Bound`**: The minimum CPU and memory that VPA recommends for the container.
        * **`Target`**: The optimal (recommended) CPU and memory requests for the container, based on its observed usage patterns.
        * **`Uncapped Target`**: The target recommendation without being constrained by any upper limits you might have set in the VPA configuration.
        * **`Upper Bound`**: The maximum CPU and memory that VPA recommends for the container.

These recommendations indicate that the VPA is active and is providing target values based on its initial observation of resource usage (or default values before significant usage is observed). As your application runs and its resource consumption fluctuates, VPA will continue to observe and refine these recommendations, applying them if `updateMode` is "Auto."

# Exercise 3: Implement Horizontal Pod Autoscaler (HPA)

Let's implement the **Horizontal Pod Autoscaler (HPA)** for your `myapp` application. HPA focuses on scaling the *number* of Pod replicas based on observed metrics like CPU utilization, adapting to incoming load.

---

## Exercise 3: Implement Horizontal Pod Autoscaler (HPA)

### Step 1: Create an HPA configuration

You will use the `hpa.yaml` file to define the HPA for your `myapp` deployment.

1.  **Explore the `hpa.yaml` file:**
    The content of `hpa.yaml` defines how your `myapp` Deployment should scale horizontally.

    ```yaml
    apiVersion: autoscaling/v1
    kind: HorizontalPodAutoscaler
    metadata:
      name: myhpa
    spec:
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: myapp
      minReplicas: 1         # Minimum number of replicas
      maxReplicas: 10        # Maximum number of replicas
      targetCPUUtilizationPercentage: 5  # Target CPU utilization for scaling
    ```
    **Explanation:**
    * `apiVersion: autoscaling/v1`, `kind: HorizontalPodAutoscaler`: Standard API definition for HPA.
    * `metadata.name: myhpa`: The name of your HPA resource.
    * `spec.scaleTargetRef`: Specifies that this HPA will control the scaling of the `myapp` Deployment.
    * `minReplicas: 1`: The HPA will never scale down to fewer than 1 Pod.
    * `maxReplicas: 10`: The HPA will never scale up beyond 10 Pods.
    * `targetCPUUtilizationPercentage: 5`: This is the target metric. The HPA will try to keep the average CPU utilization across all `myapp` Pods around 5%. If it goes higher, HPA will scale up; if it goes lower (and more than `minReplicas` are running), it will scale down.

### Step 2: Configure the HPA

Apply the `hpa.yaml` configuration to your Kubernetes cluster.

**Command (in your **original terminal**):**

```bash
kubectl apply -f hpa.yaml
```

**Expected Output:**

```
horizontalpodautoscaler.autoscaling/myhpa created
```

### Step 3: Verify the HPA

Obtain the status of the newly created HPA resource.

**Command (in your **original terminal**):**

```bash
kubectl get hpa myhpa
```

**Expected Output (example):**

You'll see the HPA resource. `TARGETS` might initially show `<unknown>/5%` because no load has been applied yet, and `REPLICAS` will be `1`.

```
NAME    REFERENCE          TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
myhpa   Deployment/myapp   <unknown>/5%    1         10        1          X
```
*(The `AGE` will be short, and `TARGETS` will likely be `<unknown>` or very low because there's no load yet.)*

### Step 4: Start the Kubernetes proxy

To simulate external load, you'll need the `kubectl proxy` running.

* **Action:** Open a **new terminal window** (you should now have two terminals open).
* **Command (in this **NEW terminal window**):**
    ```bash
    kubectl proxy
    ```
* **Expected Output:**
    ```
    Starting to serve on 127.0.0.1:8001
    ```
    *Keep this terminal open and running the proxy.*

### Step 5: Spam and increase the load on the app

Now, open **another new terminal window** (this will be your third terminal). Use this terminal to generate a high volume of requests to your `myapp` application, simulating heavy load.

* **Command (in this **THIRD terminal window**):**
    ```bash
    for i in `seq 100000`; do curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/myapp/proxy; done
    ```
    *This command will run continuously, generating load. Keep this terminal open and running.*

### Step 6: Observe the effect of autoscaling

Go back to your **original terminal window**. Use the `watch` command to continuously observe the HPA. As the load increases, you'll see the `TARGETS` CPU utilization rise, and then the `REPLICAS` count will automatically increase as the HPA scales out your Deployment.

* **Command (in your **original terminal**):**
    ```bash
    kubectl get hpa myhpa --watch
    ```
* **Expected Output (will update over time):**
    You'll initially see something similar to Step 3. As load is applied, the `TARGETS` will change, and the `REPLICAS` will start increasing:

    ```
    NAME    REFERENCE          TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
    myhpa   Deployment/myapp   XX%/5%     1         10        1          Xm
    myhpa   Deployment/myapp   YY%/5%     1         10        2          Xm  <-- Replicas increased!
    myhpa   Deployment/myapp   ZZ%/5%     1         10        3          Xm  <-- Replicas increased again!
    ... (and so on, up to a maximum of 10 replicas, or until the CPU utilization drops)
    ```
    You will observe that your application has been automatically autoscaled by the HPA.

* **Terminate this command by pressing `CTRL + C`** once you've seen the scaling in action.

### Step 7: Observe the details of the HPA

Run `kubectl get hpa` one more time to see the final state after autoscaling has occurred.

* **Command (in your **original terminal**):**
    ```bash
    kubectl get hpa myhpa
    ```
* **Expected Output:**
    The `REPLICAS` column should now show a higher number than `1`, indicating that the HPA successfully scaled your application.

    ```
    NAME    REFERENCE          TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
    myhpa   Deployment/myapp   XXX%/5%    1         10        Y          Xm
    ```
    *(Where `XXX` is the current CPU percentage and `Y` is the increased number of replicas.)*

### Step 8: Stop the proxy and load generation commands

It's crucial to stop the continuous commands running in your other two terminal windows.

* Go to the terminal running `kubectl proxy` and press `CTRL + C`.
* Go to the terminal running the `for` loop (load generation) and press `CTRL + C`.

You have successfully demonstrated horizontal pod autoscaling, allowing your application to dynamically adjust to varying loads!

---



# Exercise 4: Create a Secret and update the deployment

Now let's enhance the security of your application by using **Kubernetes Secrets** to manage sensitive information like usernames and passwords, keeping them separate from your application code.

---

## Exercise 4: Create a Secret and update the Deployment

### Step 1: Create a Secret

First, let's create the Kubernetes Secret that will store your sensitive credentials.

1.  **Explore the content of the file `secret.yaml`:**
    This file defines a Secret named `myapp-secret` with a base64-encoded username and password.

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: myapp-secret
    type: Opaque
    data:
      username: bXl1c2VybmFtZQ== # base64 for 'myusername'
      password: bXlwYXNzd29yZA== # base64 for 'mypassword'
    ```
    **Explanation:**
    * `apiVersion: v1`, `kind: Secret`: Standard Kubernetes Secret definition.
    * `metadata.name: myapp-secret`: The name of your Secret.
    * `type: Opaque`: A generic secret type for arbitrary user-defined data.
    * `data`: Contains the key-value pairs where the values are **base64-encoded**.
        * `username: bXl1c2VybmFtZQ==`: Base64 encoding of `myusername`.
        * `password: bXlwYXNzd29yZA==`: Base64 encoding of `mypassword`.

### Step 2: Update the Deployment to utilize the Secret

Now, you need to modify your `deployment.yaml` file to tell your `myapp` Pods to consume these secret values as environment variables.

1.  **Open `deployment.yaml`:**
    * In your editor's Explorer pane, open the `deployment.yaml` file.

2.  **Add the `env` section:**
    * Locate the `containers` section for `myapp`.
    * **Add the following `env` block** directly below the `resources` section (or `envFrom` if you used that in a previous step, ensuring correct indentation).

    ```yaml
          resources:
            limits:
              cpu: 50m
            requests:
              cpu: 20m
          env: # Add this new section
          - name: MYAPP_USERNAME
            valueFrom:
              secretKeyRef:
                name: myapp-secret
                key: username
          - name: MYAPP_PASSWORD
            valueFrom:
              secretKeyRef:
                name: myapp-secret
                key: password
    ```
    **Explanation of new lines:**
    * `env`: Defines environment variables for the container.
    * `- name: MYAPP_USERNAME`: Declares an environment variable named `MYAPP_USERNAME`.
    * `valueFrom`: Specifies that the value for this environment variable comes from a reference.
    * `secretKeyRef`: Indicates that the reference is to a Kubernetes Secret.
    * `name: myapp-secret`: Points to the specific Secret named `myapp-secret`.
    * `key: username`: Specifies which key within the `myapp-secret` (i.e., `username`) should be used as the value for `MYAPP_USERNAME`.
    * The same logic applies to `MYAPP_PASSWORD` and its `password` key.

3.  **Save the file.**

### Step 3: Apply the Secret and Deployment

First, apply the Secret, and then apply the updated Deployment. Kubernetes needs the Secret to exist before the Deployment tries to consume it.

1.  **Apply the Secret:**
    **Command (in your terminal):**
    ```bash
    kubectl apply -f secret.yaml
    ```
    **Expected Output:**
    ```
    secret/myapp-secret created
    ```

2.  **Apply the updated Deployment:**
    **Command (in your terminal):**
    ```bash
    kubectl apply -f deployment.yaml
    ```
    **Explanation:** This will trigger a rolling update of your `myapp` Deployment. The new Pods will be created with the `MYAPP_USERNAME` and `MYAPP_PASSWORD` environment variables populated from the `myapp-secret`.
    **Expected Output:**
    ```
    deployment.apps/myapp configured
    ```

### Step 4: Verify the Secret and Deployment

Let's confirm that your Secret is present and your Deployment is in a healthy state.

1.  **Retrieve the details of `myapp-secret`:**
    **Command:**
    ```bash
    kubectl get secret
    ```
    **Explanation:** This command lists all Secrets in your current namespace.
    **Expected Output:** You should see `myapp-secret` listed.
    ```
    NAME                  TYPE     DATA   AGE
    myapp-secret          Opaque   2      Xs
    default-token-xxxxx   kubernetes.io/service-account-token   1      Xh
    ```
    * `DATA 2` indicates that it contains two key-value pairs.*

2.  **Run the following command to show the status of the deployment:**
    **Command:**
    ```bash
    kubectl get deployment
    ```
    **Explanation:** This command shows the current status of your Deployments.
    **Expected Output:** Your `myapp` Deployment should show `1/1` or `X/Y` (depending on HPA scaling) under `READY` and `UP-TO-DATE`, indicating it's healthy.
    ```
    NAME    READY   UP-TO-DATE   AVAILABLE   AGE
    myapp   1/1     1            1           Xm
    ```

You have successfully created a Kubernetes Secret and configured your Deployment to consume its values as environment variables, enhancing the security and flexibility of your application!



---

# Summary & Highlights: Managing Applications with Kubernetes

---

## Summary & Highlights: Managing Applications with Kubernetes

Congratulations on completing this module! You've covered some of the most crucial aspects of managing applications effectively within a Kubernetes environment. Here's a recap of the key takeaways:

* **ReplicaSets for Scaling:** You learned that a **ReplicaSet** is fundamental for ensuring your application maintains a desired number of running **Pods**. It continuously monitors and adjusts the actual state to match the desired state, creating or deleting Pods as needed.

* **Autoscaling for Dynamic Resource Management:**
    * **Autoscaling** allows your applications to dynamically adjust resources based on demand, optimizing performance and cost efficiency.
    * You explored different types of autoscalers, including **Horizontal Pod Autoscaler (HPA)**, which scales Pods out (or in) based on metrics like CPU/memory utilization, and **Vertical Pod Autoscaler (VPA)**, which adjusts individual Pods' CPU and memory *requests and limits*.

* **Rolling Updates and Rollbacks:**
    * **Rolling updates** are a core Kubernetes feature for deploying application changes in a controlled, automated manner. This minimizes downtime by gradually replacing old Pods with new ones.
    * You saw how to perform both rolling updates and **rollbacks**, allowing you to revert to a previous stable version quickly if a new deployment introduces issues. These can employ strategies like all-at-once or one-at-a-time (gradual replacement).

* **Configuration and Secrets Management:**
    * **ConfigMaps** are used to provide non-sensitive configuration data to your applications, separating configuration from code. This allows for easier updates without rebuilding images.
    * **Secrets** are specifically designed for securely storing and providing sensitive information (like passwords or API keys) to your applications. They ensure sensitive data isn't hardcoded.

* **Service Binding:**
    * **Binding an external Service** to your deployment automatically provides the necessary credentials for your application to consume that service.
    * This process manages configuration and credentials for backend services (like databases or external APIs) while ensuring sensitive data remains protected and automatically available to your application code.

You've gained practical experience with essential Kubernetes concepts that enable robust, scalable, and maintainable application deployments. Great job!



# Cheatsheet

Here's a comprehensive cheat sheet for managing applications with Kubernetes, summarizing the commands and concepts you've learned:

-----

## **Cheat Sheet: Managing Applications with Kubernetes**

This cheat sheet covers essential `kubectl` commands and core Kubernetes concepts for deploying, scaling, updating, and managing your applications.

-----

### **I. Core Concepts**

  * **Pod:** The smallest deployable unit in Kubernetes, encapsulating one or more containers, storage, and network resources.
  * **Deployment:** A higher-level abstraction that manages the desired state for your Pods. It automatically creates and manages **ReplicaSets** to ensure a specified number of Pod replicas are running.
  * **ReplicaSet:** Ensures a stable set of replica Pods are running at any given time. It works to match the actual state to the desired state (e.g., if a Pod dies, it's replaced).
  * **Service:** An abstract way to expose an application running on a set of Pods as a network service. It enables consistent access to your Pods (e.g., via a stable IP address and DNS name).
      * **`ClusterIP`**: Default Service type, exposes the Service on a cluster-internal IP. Only reachable from within the cluster.
      * **`NodePort`**: Exposes the Service on each Node's IP at a static port. Makes the Service accessible from outside the cluster.
      * **`LoadBalancer`**: Exposes the Service externally using a cloud provider's load balancer.
  * **ConfigMap:** Used to store non-sensitive configuration data in key-value pairs, separate from application code. Can be consumed as environment variables or mounted as files.
  * **Secret:** Similar to ConfigMaps but designed for sensitive information (passwords, tokens, keys). Values are base64-encoded. Can be consumed as environment variables or mounted as files.
  * **Horizontal Pod Autoscaler (HPA):** Automatically scales the number of Pod replicas (horizontally) based on observed CPU utilization, memory utilization, or custom metrics.
  * **Vertical Pod Autoscaler (VPA):** Automatically adjusts the CPU and memory *requests and limits* for containers running in a Pod (vertically) based on observed resource usage.
  * **Rolling Update:** A strategy for deploying new versions of an application by gradually replacing old Pod instances with new ones. Ensures minimal downtime.
  * **Rollback:** The process of reverting a Deployment to a previous version if a new update introduces issues.

-----

### **II. Environment Setup & Basics**

| Command                    | Description                                                        | Common Usage / Example                                                |
| :------------------------- | :----------------------------------------------------------------- | :-------------------------------------------------------------------- |
| `kubectl version`          | Displays `kubectl` client and Kubernetes server versions.          | `kubectl version`                                                     |
| `git clone <repo_url>`     | Clones a Git repository.                                           | `git clone https://github.com/user/repo.git`                          |
| `cd <directory>`           | Changes current directory.                                         | `cd k8-scaling-and-secrets-mgmt`                                      |
| `export MY_NAMESPACE=...`  | Sets an environment variable.                                      | `export MY_NAMESPACE=sn-labs-$USERNAME`                               |
| `docker build . -t <image>`| Builds a Docker image from a Dockerfile in the current directory.  | `docker build . -t us.icr.io/$MY_NAMESPACE/myapp:v1`                  |
| `docker push <image>`      | Pushes a Docker image to a container registry.                     | `docker push us.icr.io/$MY_NAMESPACE/myapp:v1`                        |
| `ibmcloud cr images`       | Lists images in your IBM Cloud Container Registry.                 | `ibmcloud cr images`                                                  |
| `kubectl proxy`            | Runs a local proxy to the Kubernetes API server for local access.  | `kubectl proxy` (runs continuously, usually in a separate terminal)   |
| `kubectl port-forward <resource>/<name> <local_port>:<container_port>` | Forwards a local port to a port on a Pod.                          | `kubectl port-forward deployment.apps/myapp 3000:3000`                |
| `curl -L localhost:8001/api/v1/namespaces/<namespace>/services/<service_name>/proxy` | Accesses a service via `kubectl proxy`.                            | `curl -L localhost:8001/api/v1/namespaces/sn-labs-$USERNAME/services/myapp/proxy` |

-----

### **III. Deployment & Service Management**

| Command                                     | Description                                                                 | Common Usage / Example                                                |
| :------------------------------------------ | :-------------------------------------------------------------------------- | :-------------------------------------------------------------------- |
| `kubectl apply -f <file.yaml>`              | Applies a configuration defined in a YAML file (create or update).          | `kubectl apply -f deployment.yaml`                                    |
| `kubectl get pods`                          | Lists Pods in the current namespace. Add `-o wide` for more details.        | `kubectl get pods` \<br\> `kubectl get pods -o wide`                  |
| `kubectl get deployment <name>`             | Lists Deployment(s). Add `-o wide` for more details.                        | `kubectl get deployment` \<br\> `kubectl get deployment myapp -o wide`|
| `kubectl expose deployment/<name>`          | Creates a Service to expose a Deployment. Default type is `ClusterIP`.      | `kubectl expose deployment/myapp`                                     |
| `kubectl delete deployment <name>`          | Deletes a Deployment. This also deletes associated Pods and ReplicaSets.    | `kubectl delete deployment hello-world`                               |
| `kubectl delete service <name>`             | Deletes a Service.                                                          | `kubectl delete service hello-world`                                  |

-----

### **IV. Scaling Applications**

| Command                                     | Description                                                                 | Common Usage / Example                                                |
| :------------------------------------------ | :-------------------------------------------------------------------------- | :-------------------------------------------------------------------- |
| `kubectl scale deployment <name> --replicas=<num>` | Manually scales a Deployment to a specified number of replicas.             | `kubectl scale deployment hello-world --replicas=3`                   |
| `kubectl autoscale deployment <name> --cpu-percent=<target> --min=<min> --max=<max>` | Creates an HPA to automatically scale a Deployment based on CPU usage.      | `kubectl autoscale deployment myapp --cpu-percent=5 --min=1 --max=10` |
| `kubectl get hpa <name>`                    | Lists Horizontal Pod Autoscaler(s). Add `--watch` to monitor live changes. | `kubectl get hpa` \<br\> `kubectl get hpa myhpa --watch`              |

-----

### **V. Updates & Rollbacks**

| Command                                     | Description                                                                 | Common Usage / Example                                                |
| :------------------------------------------ | :-------------------------------------------------------------------------- | :-------------------------------------------------------------------- |
| `kubectl set image deployment/<name> <container_name>=<new_image>` | Updates the image of a container within a Deployment (triggers rolling update). | `kubectl set image deployment/hello-world hello-world=us.icr.io/$MY_NAMESPACE/hello-world:2` |
| `kubectl rollout status deployment/<name>`  | Shows the status of a rolling update or rollback.                           | `kubectl rollout status deployment/hello-world`                       |
| `kubectl rollout undo deployment/<name>`    | Rolls back a Deployment to its previous revision.                           | `kubectl rollout undo deployment/hello-world`                         |
| `kubectl rollout restart deployment/<name>` | Restarts all Pods in a Deployment (useful for ConfigMap/Secret changes).    | `kubectl rollout restart deployment hello-world`                      |

-----

### **VI. Configuration & Secrets**

| Command                                     | Description                                                                 | Common Usage / Example                                                |
| :------------------------------------------ | :-------------------------------------------------------------------------- | :-------------------------------------------------------------------- |
| `kubectl create configmap <name> --from-literal=<key>=<value>` | Creates a ConfigMap from literal key-value pairs.                           | `kubectl create configmap app-config --from-literal=MESSAGE="Hello!"` |
| `kubectl get configmap`                     | Lists ConfigMaps.                                                           | `kubectl get configmap`                                               |
| `kubectl describe configmap <name>`         | Shows detailed information about a ConfigMap.                               | `kubectl describe configmap app-config`                               |
| `kubectl get secret`                        | Lists Secrets.                                                              | `kubectl get secret`                                                  |
| `kubectl describe secret <name>`            | Shows detailed information about a Secret (values are base64-encoded).      | `kubectl describe secret myapp-secret`                                |
| `kubectl delete configmap <name>`           | Deletes a ConfigMap.                                                        | `kubectl delete configmap app-config`                                 |

-----
