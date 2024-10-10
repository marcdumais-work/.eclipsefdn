local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local custom_branch_protection_rule(pattern) = 
  orgs.newBranchProtectionRule(pattern) {
    required_approving_review_count: 0,
  };

// for trace-related repos
local custom_branch_protection_rule_trace(pattern) = 
  orgs.newBranchProtectionRule(pattern) {
    dismisses_stale_reviews: true,
    is_admin_enforced: true,
    required_approving_review_count: 1,
    requires_status_checks: false
  };

orgs.newOrg('eclipse-cdt-cloud') {
  settings+: {
    description: "",
    name: "Eclipse CDT Cloud",
    web_commit_signoff_required: false,
    workflows+: {
      default_workflow_permissions: "write",
    },
  },
  secrets+: [
    orgs.newOrgSecret('OPEN_VSX_TOKEN') {
      value: "pass:bots/ecd.cdt-cloud/open-vsx.org/token",
    },
    orgs.newOrgSecret('VS_MARKETPLACE_TOKEN') {
      value: "pass:bots/ecd.cdt-cloud/marketplace.visualstudio.com/token",
    },
  ],
  _repositories+:: [
    orgs.newRepo('cdt-amalgamator') {
      allow_update_branch: false,
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule('main'),
      ],
    },
    orgs.newRepo('cdt-cloud') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "Components for web-based C/C++ tools",
      has_discussions: true,
      homepage: "https://www.eclipse.org/cdt-cloud",
      topics+: [
        "clangd",
        "cloud-ide",
        "cpp",
        "debugging-tools",
        "eclipse-cdt",
        "eclipse-theia",
        "embedded",
        "theia-extension",
        "vscode"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('cdt-cloud-blueprint') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      description: "CDT Cloud Blueprint is a template for building custom web-based C/C++ tools. It is made up of existing open source components and can be easily downloaded and installed on all major operating system platforms.",
      homepage: "",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('cdt-gdb-adapter') {
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "CDT GDB Debug Adapter",
      homepage: "",
      topics+: [
        "cdt",
        "debug",
        "gdb"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule('main'),
      ],
    },
    orgs.newRepo('cdt-gdb-vscode') {
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "CDT GDB Visual Studio Code Extension",
      homepage: "",
      topics+: [
        "cdt",
        "gdb",
        "visual-studio-code-extension"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule('main'),
      ],
    },
    orgs.newRepo('clangd-contexts') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "API for management of clangd configuration files in C/C++ projects using contexts.",
      has_wiki: false,
      homepage: "",
      topics+: [
        "clangd",
        "cpp",
        "theia",
        "vscode-extension"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('NPM_AUTH_TOKEN') {
          value: "pass:bots/ecd.cdt-cloud/npmjs.com/token",
        },
      ],
    },
    orgs.newRepo('theia-trace-extension') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse Theia trace viewer extension using the Trace Server Protocol (TSP), through the tsp-typescript-client. Also the home for reusable JavaScript libraries: traceviewer-base, traceviewer-react-components",
      homepage: "",
      topics+: [
        "theia-traceviewer",
        "tsp-typescript-client",
        "tsp",
        "traceviewer-base",
        "traceviewer-react-components",
        "timeline-chart",
        "theia-extension",
        "trace",
        "trace-viewer",
        "trace-visualization",
        "javascript",
        "typescript",
        "npm",
        "eclipse-theia",
        "eclipse",
        "eclipse-foundation"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('GH_COMMITTER_TOKEN') {
          value: "********",
        },      
        orgs.newRepoSecret('NPM_AUTH_TOKEN') {
          value: "pass:bots/ecd.cdt-cloud/npmjs.com/token",
        },
      ],
      branch_protection_rules: [
        custom_branch_protection_rule_trace('master'),
      ],
    },
    orgs.newRepo('timeline-chart') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "A timeline / gantt chart library for large data (e.g. traces)",
      topics+: [
        "timeline-chart",
        "trace",
        "trace-visualization",
        "javascript",
        "typescript",
        "npm",
        "eclipse",
        "eclipse-foundation"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('GH_COMMITTER_TOKEN') {
          value: "********",
        },
        orgs.newRepoSecret('NPM_AUTH_TOKEN') {
          value: "pass:bots/ecd.cdt-cloud/npmjs.com/token",
        },
      ],
      branch_protection_rules: [
        custom_branch_protection_rule_trace('master'),
      ],
    },
    orgs.newRepo('trace-server-protocol') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Specification of the Trace Server Protocol (TSP)",
      topics+: [
        "trace-server-protocol",
        "tsp",
        "trace",
        "trace-visualization",
        "eclipse",
        "eclipse-foundation"
      ],
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      homepage: "https://eclipse-cdt-cloud.github.io/trace-server-protocol/",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule_trace('master'),
      ],
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('tsp-python-client') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Client-side implementation, in Python, of the Trace Server Protocol (TSP)",
      topics+: [
        "tsp-python-client",
        "trace-server-protocol",
        "tsp",
        "trace",
        "trace-visualization",
        "python",
        "eclipse",
        "eclipse-foundation"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule_trace('master'),
      ],
    },
    orgs.newRepo('tsp-typescript-client') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Client-side implementation, in typescript, of the Trace Server Protocol (TSP)",
      topics+: [
        "tsp-typescript-client",
        "trace-server-protocol",
        "tsp",
        "trace",
        "trace-visualization",
        "javascript",
        "typescript",
        "npm",
        "eclipse",
        "eclipse-foundation"
      ],
      homepage: "",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('GH_COMMITTER_TOKEN') {
          value: "********",
        },
        orgs.newRepoSecret('NPM_AUTH_TOKEN') {
          value: "pass:bots/ecd.cdt-cloud/npmjs.com/token",
        },
      ],
      branch_protection_rules: [
        custom_branch_protection_rule_trace('master'),
      ],
    },
    orgs.newRepo('vscode-clangd') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "main",
      description: "Fork of the VS Code extension for clangd with added support for multiple projects",
      homepage: "https://eclipse.dev/cdt-cloud",
      topics: [
        "clangd", 
        "vscode-extension",
      ],
      delete_branch_on_merge: true,
      forked_repository: "clangd/vscode-clangd",
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          is_admin_enforced: true,
          required_approving_review_count: 1,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('vscode-memory-inspector') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: true,
      description: "vscode memory inspector",
      homepage: "https://open-vsx.org/extension/eclipse-cdt/memory-inspector",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "read",
      },
    },
    orgs.newRepo('vscode-peripheral-inspector') {
      aliases: ['vscode-svd-viewer'],
      allow_merge_commit: false,
      allow_rebase_merge: false,
      allow_squash_merge: true,
      delete_branch_on_merge: true,
      description: "vscode peripheral inspector",
      homepage: "https://open-vsx.org/extension/eclipse-cdt/peripheral-inspector",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "read",
      },
    },
    orgs.newRepo('vscode-trace-extension') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Trace viewer extension for Eclipse Theia applications and VSCode compatible applications, that uses the Trace Server Protocol (TSP)",
      has_discussions: true,
      homepage: "",
      topics+: [
        "vscode-trace-extension",
        "trace-server-protocol",
        "tsp",
        "trace",
        "trace-viewer",
        "trace-visualization",
        "vscode-extension",
        "vscode",
        "eclipse-theia",
        "traceviewer-base",
        "traceviewer-react-components",
        "timeline-chart",
        "tsp-typescript-client",
        "javascript",
        "typescript",
        "visual-studio-marketplace",
        "open-vsx",
        "eclipse",
        "eclipse-foundation"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule_trace('master'),
      ],
      secrets: [
        orgs.newRepoSecret('GH_COMMITTER_TOKEN') {
          value: "********",
        },
      ],      
    },
    orgs.newRepo('vscode-trace-server') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "main",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Extension to start and stop a trace server used by the vscode-trace-extension. This extension can run in Eclipse Theia and VSCode compatible applications",
      homepage: "",
      topics+: [
        "vscode-trace-server",
        "trace-server",
        "trace-compass",
        "tsp",
        "trace-server-protocol",
        "tsp-typescript-client",
        "vscode-extension",
        "trace-viewer",
        "vscode-trace-extension",
        "vscode",
        "eclipse-theia",
        "javascript",
        "typescript",
        "visual-studio-marketplace",
        "open-vsx",
        "eclipse",
        "eclipse-foundation"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule_trace('main'),
      ],
      secrets: [
        orgs.newRepoSecret('GH_COMMITTER_TOKEN') {
          value: "********",
        },
      ],            
    },
    orgs.newRepo('vscode-websocket-adapter') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: true,
      description: "vscode websocket adapter",
      has_wiki: false,
      homepage: "https://open-vsx.org/extension/eclipse-cdt/websocket-adapter",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "read",
      },
    },
    orgs.newRepo('vscode-serial-monitor') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: true,
      description: "vscode serial monitor",
      homepage: "https://open-vsx.org/extension/eclipse-cdt/serial-monitor",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "read",
      },
    },
    orgs.newRepo('website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('GH_ACTION_TOKEN') {
          value: "pass:bots/ecd.cdt-cloud/github.com/api-token",
        },
      ],
    },
    orgs.newRepo('website-publish') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "The acutal published webiste content",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('trace-viewer-examples') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "This repository contains various example applications that integrate trace viewing capabilities. The applications are not meant to be very polished but can serve as a base to develop such",
      homepage: "",
      topics+: [
        "trace-viewer",
        "theia-traceviewer",
        "vscode-trace-extension",
        "tsp-typescript-client",
        "tsp",
        "traceviewer-base",
        "traceviewer-react-components",
        "timeline-chart",
        "theia-extension",
        "vscode-extension",
        "trace",
        "trace-visualization",
        "eclipse-theia",
        "eclipse",
        "eclipse-foundation"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule_trace('master'),
      ],
    },
  ],
}
