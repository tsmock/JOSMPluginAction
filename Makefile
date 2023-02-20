%_clean::
	rm -rf actions/$*/node_modules
	rm -rf actions/$*/dist
	rm -rf actions/$*/package-lock.json

%_outdated::
	cd actions/$* && \
	npm outdated

%_make::
	cd actions/$* && \
	if [ ! -d "node_modules" ]; then npm install; fi && \
	npm run prepare

%_test::
	cd actions/$* && \
	if [ ! -d "node_modules" ]; then npm install; fi && \
	npm install --no-save prettier npm-check && \
	npm run all && \
	npx prettier --check src && \
	npx npm-check

%_prettier::
	cd actions/$* && \
	if [ ! -d "node_modules" ]; then npm install; fi && \
	npm install --no-save prettier && \
	npx prettier --write src

all: prettier josm_build_make josm_plugin_clone_make josm_plugin_dependencies_make setup-ant_make pmd_make checkstyle_make

clean: josm_build_clean josm_plugin_clone_clean josm_plugin_dependencies_clean setup-ant_clean pmd_clean checkstyle_clean

prettier: josm_build_prettier josm_plugin_clone_prettier josm_plugin_dependencies_prettier setup-ant_prettier pmd_prettier checkstyle_prettier

outdated: josm_build_outdated josm_plugin_clone_outdated josm_plugin_dependencies_outdated setup-ant_outdated pmd_outdated checkstyle_outdated

check: outdated josm_build_test josm_plugin_clone_test josm_plugin_dependencies_test setup-ant_test pmd_test checkstyle_test

test: all check
