# Dream Vacation Destinations App

A simple app to manage a list of dream vacation countries with basic info, containerized with Docker. 

## Setup

1. Install Docker and Docker Compose.
2. Clone the repo: `git clone <repository-url> && cd dream-vacation-destinations`
3. Create `.env` file:
4. Run: `docker-compose up --build`
5. Open: `http://localhost:{port}`

## Project Overview
- **Front and Backend code**:  Sourced from  [Dream-Vacation-App:](https://github.com/obusorezekiel/Dream-Vacation-App).
- **View Country Details**: Displays capital, population, and region information for each country.
- **Remove Countries**: Users can remove countries from their list.
- **Production-Ready Setup**: The project is designed to be scalable and maintainable, following industry-standard practices for deployment and CI/CD.

## 🚀 Usage

### 1. Clone the repo

```bash
git clone https://github.com/your-username/Dream-Vacation-App.git
cd Dream-Vacation-App
```

### 2. Create a `.env` file at the root:

```env
DB_NAME=yourdatabasename
DB_USER=yourusername
DB_PASSWORD=yourpassword
DB_PORT=5432

BACKEND_PORT=3001
NODE_ENV=production

FRONTEND_PORT=3000

COUNTRIES_API_BASE_URL=https://restcountries.com/v3.1

DATABASE_URL=postgresql://postgres:<password>@db:5432/<dbname>
```

### 3. Start the application

```bash
docker-compose up --build
```

* Frontend: [http://localhost:3000](http://localhost:3000)
* Backend: [http://localhost:3001](http://localhost:3001)
* PostgreSQL: localhost:5432

---

## 📤 Pushed Docker Images

* **Frontend**: `docker.io/your-username/dream-vacation-frontend`
* **Backend**: `docker.io/your-username/dream-vacation-backend`

---

## ✅ Features

* Multi-stage Docker builds for optimized frontend
* Distinct services for clear separation of responsibilities
* Environment setup using .env file at the root
* Suitable for local and production Docker deployments
* Persistent PostgreSQL data with Docker volumes


## 📤 My Docker Hub Pushed Images In My Repositories

### Backend Repository
![Backend Docker Hub](Assets/backend.png)
*Caption: Dream Vacation Backend repository on Docker Hub*

### Frontend Repository
![Frontend Docker Hub](Assets/frontend.png)
*Caption: Dream Vacation Frontend repository on Docker Hub*

### All Repositories Overview
![Repositories Overview](Assets/backend-frontend%20hub.png)
*Caption: Overview of all my repositories under my Docker Hub.*

### Running Application
![Running App](Assets/app-view.png)
*Caption: Dream Vacation Destinations app running locally, showing Canada and Nigeria details.*

---

## 🔄 CI/CD with GitHub Actions
This project implements automated CI/CD pipelines using GitHub Actions to build and push Docker images to Docker Hub.

### Workflow Configuration

The CI/CD pipeline is configured on the `github-actions` branch with separate workflows for frontend and backend:

#### Frontend Workflow (`.github/workflows/frontend.yaml`)
- **Triggers**: Push to `github-actions` branch when files in `frontend/` directory change
- **Actions**:
  - Builds Docker image from `frontend/Dockerfile`
  - Pushes to Docker Hub as `dejosemario1/dream-vacation-frontend`
  - Generates automatic tags based on branch and commit SHA
  - Uses Docker layer caching for faster builds


#### Backend Workflow (`.github/workflows/backend.yaml`)
- **Triggers**: Push to `github-actions` branch when files in `backend/` directory change
- **Actions**:
  - Builds Docker image from `backend/Dockerfile`
  - Pushes to Docker Hub as `dejosemario1/dream-vacation-backend`
  - Automated tagging and metadata extraction


### GitHub Actions Features
- ✅ **Path-based triggering**: Workflows only run when relevant files change
- ✅ **Docker Hub integration**: Automatic image building and pushing
- ✅ **Secure secrets management**: Docker credentials stored as GitHub secrets
- ✅ **Caching**: Docker layer caching for improved build performance
- ✅ **Multi-platform support**: Ready for arm64/amd64 builds
- ✅ **Manual triggering**: `workflow_dispatch` for on-demand runs

### Setting up CI/CD
1. **Fork this repository**
2. **Add Docker Hub secrets** in repository settings:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_TOKEN`: Your Docker Hub access token
3. **Push changes** to the `github-actions` branch
4. **Watch workflows** run automatically in the Actions tab

---

## 📤 Pushed Docker Images

* **Frontend**: `docker.io/dejosemario1/dream-vacation-frontend`
* **Backend**: `docker.io/dejosemario1/dream-vacation-backend`


---

## ✅ Features

* Multi-stage Docker builds for optimized frontend
* Distinct services for clear separation of responsibilities
* Environment setup using .env file at the root
* Suitable for local and production Docker deployments
* Persistent PostgreSQL data with Docker volumes
* **Automated CI/CD pipelines with GitHub Actions**
* **Docker Hub integration for seamless deployments**

## 📤 My Docker Hub Pushed Images In My Repositories

### Backend Repository
![Backend Docker Hub](Assets/backend-build-image.png)
*Caption: Dream Vacation Backend repository on Docker Hub after the new build*

### Frontend Repository
![Frontend Docker Hub](Assets/frontend-build-image.png)
*Caption: Dream Vacation Frontend repository on Docker Hub after the new build*

### Github Actions After Build is Complete
![Github-actions Overview](Assets/github-actions.png)
*Caption: Overview of my github actions after the build.*


### Branch Strategy
- **`main`**: Production-ready code
- **`github-actions`**: CI/CD development and testing

## 🔧 Technical Stack

- **Frontend**: React.js, Docker
- **Backend**: Node.js, Express.js, Docker
- **Database**: PostgreSQL
- **CI/CD**: GitHub Actions
- **Container Registry**: Docker Hub
- **Infrastructure**: Docker Compose.