with import <nixpkgs> {};
      spidermonkey_1_8_5.overrideDerivation ( oldAttrs: {
                postPatch= oldAttrs.postPatch + "substituteInPlace Makefile.in --replace 'filter-out powerpc sparc' 'filter x86_64'";
	})
