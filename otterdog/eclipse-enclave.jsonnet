local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('ecd.enclave', 'eclipse-enclave') {
  settings+: {
    description: "",
    members_can_change_project_visibility: false,
    name: "Eclipse Enclave project",
    packages_containers_internal: false,
    packages_containers_public: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  secrets+: [
    orgs.newOrgSecret('DEPLOY_TOKEN') {
      value: "pass:bots/ecd.enclave/github.com/api-token-hd7681",
    },
    orgs.newOrgSecret('SCP_KEY') {
      value: "pass:bots/ecd.enclave/projects-storage.eclipse.org/id_ed25519",
    },
    orgs.newOrgSecret('SCP_PASSPHRASE') {
      value: "pass:bots/ecd.enclave/projects-storage.eclipse.org/id_ed25519.passphrase",
    },
    orgs.newOrgSecret('SCP_USERNAME') {
      value: "pass:bots/ecd.enclave/projects-storage.eclipse.org/username",
    },
  ],
  _repositories+:: [
    orgs.newRepo('enclave') {
      allow_merge_commit: true,
      allow_update_branch: false,
      description: "Sandbox for running AI coding agents autonomously: isolated, network-restricted, host-safe",
      has_discussions: true,
      has_wiki: false,
      homepage: "https://www.eclipse.dev/enclave",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      topics+: [
        "agentic-ai",
        "ai-agents",
        "claude-code",
        "cli",
        "developer-tools",
        "docker",
        "sandbox",
        "security"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('enclave-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      description: "Hosting enclave-website",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      homepage: "https://www.eclipse.dev/enclave",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 0,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "gh-pages",
            "main",
            "master"
          ],
          deployment_branch_policy: "selected",
        },
        orgs.newEnvironment('pull-request-preview') {
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
} + {
  # snippet added due to 'https://github.com/eclipsefdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}