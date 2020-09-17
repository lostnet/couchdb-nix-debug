with import <nixpkgs> {};
      couchdb3.overrideDerivation ( oldAttrs: {
		buildInputs = [erlang icu icu.dev openssl spidermonkey_68 (python3.withPackages(ps: with ps; [ requests black ])) curl elixir];
		postPatch = oldAttrs.postPatch + ''
                  substituteInPlace configure --replace '1.8.5' '68'
		  substituteInPlace src/couch/rebar.config.script --replace '"-DHAVE_CURL"' "\"-DHAVE_CURL -I${pkgs.curl.dev}/include\""
		  substituteInPlace src/couch/rebar.config.script --replace '"-DHAVE_CURL -lcurl"' "\"-DHAVE_CURL -L${pkgs.curl.out}/lib -lcurl\""
		  patchShebangs dev/run
		  patchShebangs test/
                '';
		configureFlags = oldAttrs.configureFlags ++ ["-c"];
#		installPhase = oldAttrs.installPhase + "make check";
		installPhase = "make elixir";
	})
