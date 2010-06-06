Date: Mon, 7 Jun 2010 00:42:42 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20100606224242.GA13584@...33...>
References: <20100604224938.GA19956@...1375...>
	<201006052336.37559.dave_br@...1278...>
	<915E9EDC-6AC1-4CAE-963C-0CBBFA3315F5@...1348...>
	<201006060058.21798.dave_br@...1278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <201006060058.21798.dave_br@...1278...>
Subject: Re: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--DocE+STaALJfprDB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 06 Jun 2010, Davide Brini wrote:

> Some systems don't install bash or a POSIX sh in /bin, so it may also be=
=20
> necessary to create symlinks on those systems. I think it's the easiest=20
> tradeoff, and should be done anyway, because on such systems many other=20
> #!/bin/sh or #!/bin/bash scripts are likely to break anyway.

While the assertion that you're starting from is true (installation
locations of sh), OpenVPN shouldn't be a tool that requires
administrators to pollute their installations with symlinks.

I've posted a patch that forgoes the getconf part (I'm not sure
currently if Solaris /bin/sh likes $(...) notation or insists on `...`),
and just does a blunt check for /usr/xpg4/bin/sh.

It's also a blunt hit in another place, it tries export FOO=3Dbar in a
subshell, which fails on Solaris 10's /bin/sh - and for instance pkitool
relies on that syntax later when assigning OPENSSL.  However I have no
other offenders to test than Solaris 10.

As a side note, not sure if it was mentioned already, I've only superficial=
ly
glanced at the whole long thread, Ubuntu uses dash (Debian Almqvist
shell) for /bin/sh for efficiency reasons.

Finally, it appears that zsh can also emulates certain other shells, I'd
recently received a FreeBSD bug report against some other (non-openvpn)
software where someone was using zsh as bash replacement (for scripts
that are documented to use bash and aren't easily fixed).

The fun never ends ;-)



--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkwMJGIACgkQvmGDOQUufZUUiACg8C0JGCpNYy/cYYME72yr2t3J
0XgAoJ7qkOyIT8tKw1S0LZSPGIbPDHrh
=CNoD
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

