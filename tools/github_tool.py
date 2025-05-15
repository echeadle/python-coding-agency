class GitHubTool:
    def clone_repo(self, repo_url: str, target_dir: str):
        # Clone repo using Git CLI
        import subprocess
        subprocess.run(["git", "clone", repo_url, target_dir], check=True)

    def commit_and_push(self, message="Auto-commit from agent"):
        import subprocess
        subprocess.run(["git", "add", "."], check=True)
        subprocess.run(["git", "commit", "-m", message], check=True)
        subprocess.run(["git", "push"], check=True)
