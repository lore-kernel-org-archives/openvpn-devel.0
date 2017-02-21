From: David Sommerseth <openvpn@...2080...>
Message-ID: <6d9ebf8e-aa9b-1e2c-1743-e67c278ddbe2@...2080...>
Date: Tue, 21 Feb 2017 15:57:54 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] Updates to the git repositories
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


Hi,

Since the early days of the OpenVPN git era, we have done pushes
to both a stable (openvpn.git) repository and a testing
(openvpn-testing.git) repository.  In the early days, this made
a lot of sense.

But life moves on, evolves and things changes.

Since the v2.3 release we have not really used any of the
"features" we used the openvpn-testing.git repository for.  In
fact, openvpn.git and openvpn-testing.git have in most cases
been a replica of the master branch.  So this makes little sense
to carry on further.

In the developers meeting of December 21, 2016 [1] we decided to
decommission the openvpn-testing.git ... the plan of "early
January 2017" have dragged, but this happens now.

As of today we have stopped pushing new commits to
openvpn-testing.git.  In the coming weeks, that repository will
be completely deleted from sourceforge.net.

To ensure all can verify that the repository content have not
been tampered with, we do push the OpenVPN code to three
different public repositories (in addition to our own private
repositories)

  - github
    git://github.com/OpenVPN/openvpn.git
    https://github.com/OpenVPN/openvpn.git

  - gitlab
    https://gitlab.com/openvpn/openvpn.git

  - sourceforge.net
    git://git.code.sf.net/p/openvpn/openvpn
    https://git.code.sf.net/p/openvpn/openvpn

The master branch and all the release/* branches should have the
same commit reference, as well as all tags should be identical.

In addition, all the git pushes I do are also GPG signed git
commits.  My git signing key is the same I use in my e-mails to
this mailing list (0x57DB9DAB613B8DA1).  To verify the GPG
signatures, you can add --show-signature to 'git log' and
'git show'.  In addition you can use 'git verify-commit' to
verify specific commits.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYrFVyAAoJEIbPlEyWcf3yQQYP/2I2IhT3fXhSZCAKjrfZfKah
1ymuSGfJMeef+PRpmPn5kzz1b4swOib73oBB+j8pPC6NSjjoomNnS19GgVt6yhqg
Rnz99MLMts2Mmk2cgmL2kKPShKk8Hh09cDTok7QOC36KfSzy1vpoerhDHaMP1jt0
DNA0cm8CgVd11AYt/YWtl8Yw2c07jJaXAomVMteejIY8FKtyk9QH6cVNk3/BLb6L
bwbNf6wjESNGWm7dSVvA+pNKMnCU9okefYlV/CAg+sraKZfWp+5wdyP4rY+WX90b
io0HsmjNVvChTBuHgGVJRiUbxDgr83aVSIVsfWZIesMA/ciq8FgQJwssLoVZPjna
Bzip3BFA7YwmSfa1T2DcOiYI7IfpsdNFL+AvdSqsTgdo2K/dlMbW3u8/dK9PHNLQ
+CFcXPmJBJYY6D7o+t8B08/N0KypPBwu1+9tkoiemCkF4u16Fhiy5debnVGpOeCL
F+TJAzClNjZsxByuWMYWf1AEcU6S8q7x77Mhj/shglXLxHzq3CcDsR45cb8nB3Jt
mQBPgGdUAM2mtBeFxSreL+dv8Tw7e05GcubTLeN6t78D2xvXZyhLxU7z2GBHJ98V
AkXmK9gO1yTSGMpSdIscZWc++M4g0za5O4bOjtv0X9GX/QlT0sk/WunBRewqzrNJ
yZKgVAfRh/hQUVfNTwzC
=3DXDRY
-----END PGP SIGNATURE-----

