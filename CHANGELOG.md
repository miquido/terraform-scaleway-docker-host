# [2.0.0](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/compare/v1.3.1...v2.0.0) (2026-11-23)


* feat!: terraform-docker-host v2 (Ofelia fork, working scheduled backups), vm_user, snapshot restore ([b38cf73](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/b38cf7361bac5fc6f1017eec8b5a0a26589354fe))
* feat!: vm_user defaults to ubuntu, optional /home/dynamic symlink for the transition ([dfae9f2](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/dfae9f296373ebe8ef09738940fa5b0e1f858b33))


### BREAKING CHANGES

* built on terraform-docker-host v2.2.2 (see previous commit); the login user is ubuntu
(/home/ubuntu) unless vm_user is set. legacy_dynamic_home_symlink keeps /home/dynamic working.

Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>
* built on terraform-docker-host v2.2.2. A running host only gets the new cloud-init
when its VM is replaced. vm_user defaults to dynamic to keep /home/dynamic; the compose runner image
defaults to v1.4.2. New inputs: vm_user, enable_autoheal, postgres_ingress_cidr_blocks,
data_volume_snapshot_id.

Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>

## [1.2.1](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/compare/v1.2.0...v1.2.1) (2026-08-20)


### Bug Fixes

* **cicd:** default validate-terraform ([a27ad23](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/a27ad23307c73c562de1af0e9c109cc2fd309962))

# [1.2.0](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/compare/v1.1.0...v1.2.0) (2026-07-27)


### Features

* logs + static pages basic auth ([1e88fd7](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/1e88fd71b86fe1e8976d76d83bba9dc0fd6eb72a))

# [1.1.0](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/compare/v1.0.2...v1.1.0) (2026-07-01)


### Features

* update docker_compose_runner_image ([048a760](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/048a760578fc87cb0eede5d97f352b21213e4676))

## [1.0.2](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/compare/v1.0.1...v1.0.2) (2026-06-23)


### Bug Fixes

* README ([9763a19](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/9763a196ec012f9925beeee8b90123972a6eb1e2))
* terraform lock ([a2ae97e](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/a2ae97ec83b8fd9bcd24611f9f57e691e9446448))

## [1.0.1](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/compare/v1.0.0...v1.0.1) (2026-06-23)


### Bug Fixes

* remove explicit gitlabUrl from releaserc to fix asset link URL ([71cd824](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/71cd824e6c7e4d2495570390aa871acf317013e1))

# 1.0.0 (2026-06-23)


### Features

* metrics ([8ab6b20](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/8ab6b207266553ebc8a5dc366aae44800ba663c5))
* run prune on schedule ([222a771](https://gitlab.miquido.com/miquido/terraform/scaleway-docker-host/commit/222a7710da10f79c43ac64e691705600e22098df))
