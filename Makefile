ENV_NAME ?= default_env

create-env:
ifeq ($(ENV_NAME), default_env)
	@echo "Error: ENV_NAME is not set. Please specify a ENV_NAME">&2
	@exit 1
endif
	cp -r envs/example envs/$(ENV_NAME)
