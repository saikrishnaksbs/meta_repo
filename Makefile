# List of repositories to include
REPOS = R1 R2 R3 R4
GITHUB_USER = saikrishnaksbs
META_REPO_DIR = $(shell pwd)

.PHONY: all update build push ci sync-submodules

all: update build push

# Dynamically add submodules if missing
sync-submodules:
	@for repo in $(REPOS); do \
		if [ ! -d "$$repo" ]; then \
			git submodule add --force https://github.com/$(GITHUB_USER)/$$repo.git; \
		fi; \
	done
	git submodule update --init --recursive
	git add .
	git commit -m "Updated submodules" || true
	git push origin main

# Pull latest changes from all submodules
update: sync-submodules
	git submodule foreach git pull origin main

# Build Docker image
build:
	docker build -t ghcr.io/$(GITHUB_USER)/your-image-name:latest .

# Push Docker image to GHCR
push:
	echo "${GHCR_TOKEN}" | docker login ghcr.io -u $(GITHUB_USER) --password-stdin
	docker push ghcr.io/$(GITHUB_USER)/your-image-name:latest

# Full CI Pipeline
ci:
	$(MAKE) update
	$(MAKE) build
	$(MAKE) push
