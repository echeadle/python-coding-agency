from crewai import Task
from agents.planning_agent import PlanningAgent
from agents.backend_dev_agent import BackendDevAgent

planning_task = Task(
    description="Define project scope, architecture, and tech stack.",
    expected_output="A clear specification of the service including endpoints and design decisions.",
    agent=PlanningAgent
)

coding_task = Task(
    description="Implement backend code based on the planned specification.",
    expected_output="A FastAPI service with all planned endpoints and models.",
    agent=BackendDevAgent
)
