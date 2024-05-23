deploy:
	nix build .#darwinConfigurations.Xaviers-MacBook-Pro.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#Xaviers-MacBook-Pro
