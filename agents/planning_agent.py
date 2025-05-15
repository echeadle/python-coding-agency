from crewai import Agent

PlanningAgent = Agent(
    role="Project Planner",
    goal="Outline project goals, feature sets, and architecture plan.",
    backstory="A strategic software architect with expertise in planning scalable Python applications.",
    verbose=True
)
