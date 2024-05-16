deploy:
	nix build .#darwinConfigurations.xavier-mbp.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#xavier-mbp
