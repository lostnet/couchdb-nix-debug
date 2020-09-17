with import <nixpkgs> {};
	couchdb3.overrideDerivation ( oldAttrs: {
		buildInputs = [erlang icu icu.dev openssl spidermonkey_68 (python3.withPackages(ps: with ps; [ requests black ])) curl curl.dev elixir];
		postPatch = oldAttrs.postPatch + ''
			substituteInPlace configure --replace '1.8.5' '68'
			patchShebangs dev/run
			patchShebangs test/
		'';
		configureFlags = oldAttrs.configureFlags ++ [ "-c" ];
		installPhase = "";
})
