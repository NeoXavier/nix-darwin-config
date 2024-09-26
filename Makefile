deploy-arm:
	nix build .#darwinConfigurations.xavier-aarch64.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#xavier-aarch64

deploy-intel:
	nix build .#darwinConfigurations.xavier-x86.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#xavier-x86
