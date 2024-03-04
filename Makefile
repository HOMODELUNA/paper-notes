
deploy_ipfs:
	ruby unused/a.rb
	ipfs add --hash=blake2b-256 -r book --to-files /web-archive/notes