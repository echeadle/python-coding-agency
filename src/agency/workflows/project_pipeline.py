from langgraph.graph import StateGraph
from agency.agents.planning_agent import PlanningAgent
from agency.agents.backend_dev_agent import BackendDevAgent
from agency.agents.code_review_agent import ReviewAgent
from agency.agents.qa_agent import QATestAgent
from agency.agents.devops_agent import DevOpsAgent

graph = StateGraph()

graph.add_node("plan", PlanningAgent.run)
graph.add_node("code", BackendDevAgent.run)
graph.add_node("review", ReviewAgent.run)
graph.add_node("test", QATestAgent.run)
graph.add_node("deploy", DevOpsAgent.run)

graph.set_entry_point("plan")
graph.add_edge("plan", "code")
graph.add_edge("code", "review")
graph.add_edge("review", "test")
graph.add_edge("test", "deploy")

pipeline = graph.compile()
