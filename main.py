from workflows.project_pipeline import pipeline

if __name__ == "__main__":
    spec = {
        "project_name": "User Management API",
        "tech_stack": "FastAPI, PostgreSQL, Docker",
        "features": ["user registration", "login", "CRUD operations"]
    }

    result = pipeline.invoke({"project_spec": spec})
    print("✅ Project completed.")
    print(result)
