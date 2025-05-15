from crewai import Agent

BackendDevAgent = Agent(
    role="Backend Developer",
    goal="Implement scalable, testable Python backend services using FastAPI.",
    backstory="A Python backend engineer with deep experience in building REST APIs and database integrations.",
    verbose=True
)
