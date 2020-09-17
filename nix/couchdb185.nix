with import <nixpkgs> {};
      let
	spidermonkey_185=(spidermonkey_1_8_5.overrideDerivation ( oldSpider: { postPatch= oldSpider.postPatch + "substituteInPlace ./Makefile.in --replace 'filter-out powerpc sparc' 'filter x86_64'";}));
      in
        couchdb3.overrideDerivation ( oldAttrs: {
		buildInputs = [erlang icu icu.dev openssl spidermonkey_185 (python3.withPackages(ps: with ps; [ requests black ])) curl curl.dev elixir];
		postPatch = ''
		  substituteInPlace src/couch/rebar.config.script --replace /usr/include/js ${spidermonkey_185}/include/js
		  patchShebangs bin/rebar
		  patchShebangs dev/run
		  patchShebangs test/
                '';
		configureFlags = oldAttrs.configureFlags ++ ["-c"];
#		installPhase = oldAttrs.installPhase + "make check";
		installPhase = "make elixir";
	})
