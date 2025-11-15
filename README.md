# Dart Frog Task API

A simple, production-ready RESTful API for managing tasks (CRUD operations), built using the Dart Frog minimal backend framework.
This project demonstrates core backend architectural principles: **Layered Architecture** (Routes, Service, Repository) and **Dependency Injection** using Dart Frog's built-in Provider middleware.

---

## ✨ Features

* **RESTful Endpoints:** Full CRUD operations for Task resources.
* **Layered Architecture:** Clear separation of concerns (HTTP, Business Logic, Data Access).
* **Dependency Injection (DI):** Uses `provider` middleware for managing the `TaskService` and `TaskRepository`.
* **Precise Error Handling:** Returns appropriate HTTP Status Codes (e.g., `201`, `400`, `404`) and descriptive JSON error payloads.
* **In-Memory Storage:** Uses a simple list (`TaskRepository`) for state management, making it easy to test and demonstrate.

---

## 🛠️ Prerequisites

Ensure you have the following installed on your system:

1. **Dart SDK:** Version 3.0 or higher.
2. **Dart Frog CLI:**

```bash
    dart pub global activate dart_frog_cli
```

---

## 🚀 Getting Started

Clone the repository and run the necessary package fetch command:

```bash
git clone https://github.com/mirzamahmud/learn-dart-backend.git

cd learn-dart-backend

dart pub get

```