# Inception Project - System Administration with Docker

## Overview
The Inception project aims to expand your knowledge in system administration, focusing on Docker-based infrastructure setup. You will configure and virtualize multiple services in Docker containers.

## Table of Contents
1. [Preamble](#preamble)
2. [Introduction](#introduction)
3. [General Guidelines](#general-guidelines)
4. [Mandatory Part](#mandatory-part)
5. [Bonus Part](#bonus-part)

---

## Preamble
This document outlines the requirements and guidelines for the Inception project, which involves setting up a system infrastructure using Docker.

---

## Introduction
This project aims to familiarize you with Docker in a system administration context. You will be required to set up a virtualized environment containing various services like NGINX, WordPress, MariaDB, and more, all running within their own Docker containers.

---

## Mandatory Part

### Objective
Set up a small infrastructure composed of different services using Docker. The following must be achieved:

1. **NGINX Container:**
   - Must support TLSv1.2 or TLSv1.3.
   - It will be the entry point to your infrastructure via port 443.

2. **WordPress + PHP-FPM Container:**
   - This container will run WordPress without NGINX.
   - PHP-FPM must be configured.

3. **MariaDB Container:**
   - This container will run MariaDB without NGINX.
   - The database must have two users: one administrator (with specific restrictions on the username) and a regular user.

4. **Volumes:**
   - Two volumes must be created:
     - One for the WordPress database.
     - One for the WordPress website files.

5. **Network:**
   - A custom Docker network must be set up to connect your containers.

6. **Crash Recovery:**
   - Containers must be set to restart automatically in case of failure.

### Specific Rules
- **Network Configuration:** Using `network: host`, `--link`, or `links:` is prohibited. You must configure the network in the `docker-compose.yml` file.
- **Entrypoint Considerations:** Avoid using infinite loops (`tail -f`, `sleep infinity`, etc.) in entrypoints or scripts.
- **WordPress Database:** The WordPress database must not contain any weak or common administrator usernames.
- **Environment Variables:** Store sensitive data (like database credentials) in a `.env` file.
- **Domain Configuration:** Set up a custom domain pointing to your local IP address (e.g., `yourlogin.42.fr`).

#### `.env` Example

```bash
DOMAIN_NAME=yourlogin.42.fr
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_USER=your_user
MYSQL_PASSWORD=your_password
```

---

## Bonus Part

### Objective
Enhance your infrastructure with additional services. The bonus part is only evaluated if the mandatory part is completed and functioning perfectly. 

### Bonus Services
1. **Redis Cache for WordPress:**
   - Set up a Redis cache to manage WordPress caching.

2. **FTP Server:**
   - Set up an FTP server for managing WordPress files.

3. **Static Website:**
   - Create a simple static website (using any language other than PHP, such as HTML, CSS, or JavaScript).

4. **Adminer:**
   - Set up Adminer for easy database management.

5. **Additional Services:**
   - Add any other useful services of your choice (e.g., a monitoring service, security tools, etc.).

---

## Additional Resources
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
