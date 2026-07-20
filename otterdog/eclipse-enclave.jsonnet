local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('ecd.enclave', 'eclipse-enclave') {
  settings+: {
    description: "",
    members_can_change_project_visibility: false,
    members_can_change_repo_visibility: false,
    members_can_create_teams: false,
    members_can_delete_repositories: false,
    name: "Eclipse Enclave project",
    packages_containers_internal: false,
    packages_containers_public: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  _repositories+:: [
    orgs.newRepo('enclave') {
      allow_update_branch: false,
      allow_merge_commit: true,
      delete_branch_on_merge: true,
      description: "Sandbox for running AI coding agents autonomously: isolated, network-restricted, host-safe",
      has_discussions: true,
      has_wiki: false,
      homepage: "https://www.eclipse.dev/enclave",
      topics+: [
        "ai-agents",
        "claude-code",
        "sandbox",
        "docker",
        "agentic-ai",
        "developer-tools",
        "cli",
        "security"
      ],
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('DEPLOY_TOKEN') {
          value: "pass:bots/ecd.enclave/github.com/publish-token",
        },
        orgs.newRepoSecret('DEPLOY_PREVIEW_TOKEN') {
          value: "pass:bots/ecd.enclave/github.com/preview-token",
        },
      ],
    },
    orgs.newRepo('enclave-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "main",
      delete_branch_on_merge: true,
      description: "Hosting enclave-website",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      homepage: "https://www.eclipse.dev/enclave",
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 0,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "gh-pages"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('enclave-website-previews') {
      default_branch: "previews",
      description: "Hosting PR previews for enclave-website",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "previews",
      gh_pages_source_path: "/",
      has_issues: false,
      has_projects: false,
      has_wiki: false,
      web_commit_signoff_required: false,
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "previews"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
  ],
}
