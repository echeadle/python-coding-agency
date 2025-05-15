class DockerTool:
    def build_image(self, tag="agent-app"):
        import subprocess
        subprocess.run(["docker", "build", "-t", tag, "."], check=True)

    def run_container(self, tag="agent-app"):
        import subprocess
        subprocess.run(["docker", "run", "-p", "8000:8000", tag], check=True)
