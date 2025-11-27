# Blue-Green Deployment

Blue-Green Deployment is a release management strategy that reduces downtime and risk by running two identical production environments — **Blue** (live) and **Green** (idle). Traffic is switched between them during deployments, ensuring seamless user experiences.

---

## 🚀 Benefits

- **Minimal downtime**: Updates are deployed to the idle environment while users continue using the live one.
- **Reduced risk**: If issues occur, traffic can be quickly redirected back to the stable environment.
- **Seamless user experience**: Transitions are smooth and disruption-free.
- **Quick rollback capability**: Rolling back is as simple as routing traffic back to the previous environment.
- **Improved testing**: The green environment mirrors production, allowing realistic pre-release validation.
- **Continuous delivery support**: Fits well into DevOps pipelines for frequent and reliable releases.
- **Zero-downtime upgrades**: Ideal for mission-critical systems where availability is paramount.
- **Confidence in deployment**: Teams deploy with less fear since rollback is straightforward.
- **Better monitoring and validation**: Traffic can be gradually shifted to validate performance under real load.

---

## ⚖️ Trade-offs

- Requires maintaining **two identical environments**, which increases infrastructure costs.
- Demands **precise coordination** to ensure smooth traffic switching.
- May not be suitable for systems with **large stateful databases** unless replication strategies are in place.

---

## 📊 Workflow Overview

1. **Blue environment**: Current production environment serving users.
2. **Green environment**: Idle environment where the new version is deployed and tested.
3. **Switch traffic**: Once validated, traffic is routed from Blue → Green.
4. **Rollback (if needed)**: Instantly redirect traffic back to Blue if issues arise.

---

## 🔗 Related Strategies

- **Canary Deployment**: Gradually roll out changes to a subset of users.
- **Rolling Deployment**: Update servers in batches without maintaining two full environments.

---

## ✅ Conclusion

Blue-Green Deployment is a powerful technique for achieving **zero-downtime releases** and **risk-free rollbacks**, making it a cornerstone of modern DevOps practices.


# 🚀 Blue-Green Deployment with Custom Nginx

This project demonstrates a **Blue-Green Deployment** strategy using Docker and Kubernetes.  
We build two versions of a simple Nginx web application — **Blue** and **Green** — each serving a slightly different HTML page to identify the environment.

---


---

## 🛠️ Steps

### 1. Prepare HTML Files
- **index-blue.html** → Displays "Welcome (BLUE)" message.
- **index-green.html** → Displays "Welcome (GREEN)" message.

### 2. Create Dockerfiles
- **Dockerfile.blue**
  ```dockerfile
  FROM nginx:alpine
  COPY index-blue.html /usr/share/nginx/html/index.html

- **Dockerfile.blue**
  ```dockerfile
  FROM nginx:alpine
  COPY index-blue.html /usr/share/nginx/html/index.html

### Build Docker Images

# Build Blue image
```bash
docker build -f Dockerfile.blue -t thapak010189/nginx-web:blue .
```
# Build Green image
```bash
docker build -f Dockerfile.green -t thapak010189/nginx-web:green .
```
---

### Push Images to Docker Hub
```bash
docker push thapak010189/nginx-web:blue
docker push thapak010189/nginx-web:green
```
### Run Containers Locally ( optional)

# Run Blue version
```bash
docker run -d -p 8080:80 thapak010189/nginx-web:blue
```

# Run Green version
```bash
docker run -d -p 9090:80 thapak010189/nginx-web:green
```

----
## Visit http://localhost:8080 → Blue environment

## Visit http://localhost:9090 → Green environment