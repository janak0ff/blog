---
layout: post
title: "setup jenkins-server with gitlab"
date: 2025-05-18 13:27 +0545
categories: ["CI/CD"]
tags: ["jenkins"]
author: sudiplun
excerpt: 
---

## **1. Prerequisites**

- Jenkins installed and running
- GitLab project/repo
- GitLab personal access token (optional but useful)
- Jenkins user with admin permissions
- GitLab plugin installed in Jenkins

---

## **2. Install Required Plugins in Jenkins**

Go to **Jenkins Dashboard > Manage Jenkins > Plugins**:

- Install:
  - **GitLab Plugin**
  - **Git plugin**
  - **GitLab Hook Plugin**
  - (Optional: **Pipeline** plugins for scripted pipelines)

---

## **3. Configure Jenkins Credentials**

Go to **Jenkins > Manage Jenkins > Credentials**:

- Add a credential:
  - **Kind:** Username and Password (for GitLab HTTP access) or **SSH Key** (if using SSH)
  - **Username:** GitLab username
  - **Password:** GitLab personal access token or password
  - Or use **SSH Username with Private Key** if using SSH access

---

## **4. Configure GitLab Connection in Jenkins**

- Go to **Manage Jenkins > Configure System**
- Scroll to **GitLab** section
- Click **Add GitLab Server**
  - Provide a name
  - GitLab host URL: e.g., `https://gitlab.com`
  - Add credentials you created earlier
  - Test connection

---

## **5. Create Jenkins Job or Pipeline**

- **Freestyle Project:**
  - Go to Jenkins Dashboard > New Item > Freestyle Project
  - Under **Source Code Management**, select **Git**
    - Add your GitLab repo URL
    - Choose the right credentials

  - Under **Build Triggers**:
    - Check **Build when a change is pushed to GitLab** (requires GitLab Hook Plugin)

- **Pipeline Project (Optional):**
  - Use a `Jenkinsfile` in the repo or define pipeline script inline
  - Use `git` block in the pipeline to check out the repo

---

## **6. Set Up GitLab Webhook**

- Go to your **GitLab repo > Settings > Webhooks**
  - **URL:** `http://<jenkins-server>:<port>/project/<job-name>`
    - e.g., `http://jenkins.example.com/project/my-job`

  - Select **Trigger**:
    - Usually **Push events**, or **Merge Request events**, depending on your need

  - **Secret Token:** Optional, but can be added for security (Jenkins can verify it)
  - Click **Add Webhook**

---

## **7. Test the Setup**

- Make a change in your GitLab repo (e.g., push a commit)
- The webhook should trigger and Jenkins should start the job automatically

---

## **Optional: Troubleshooting Tips**

- Check **Jenkins logs** if the job is not triggered
- Use **GitLab > Webhook Logs** to see the response from Jenkins
- Ensure Jenkins is publicly accessible if GitLab is hosted externally
- Check firewall settings and ports

---

`content are AI generated`

**TIP!!!** `:wq` to quit vim
