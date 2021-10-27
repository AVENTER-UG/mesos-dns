.PHONY: deploy
deploy: 
	@echo "====> deploying to github"
	rm -rf /tmp/book
	git worktree add -f /tmp/book gh-pages
	rm -rf /tmp/book/*
	cp -rp * /tmp/book/
	cd /tmp/book && \
		bundle exec jekyll build && \
		cp -prf _site/* docs/
		git add -A && \
		PRE_COMMIT_ALLOW_NO_CONFIG=1 git commit -m "deployed on $(shell date) by ${USER}" && \
		git push origin gh-pages
