Date: Tue, 20 Feb 2018 11:00:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220100026.GI69387@...1296...>
References: <20180201154521.7642-1-steffan@...1856...>
 <201802200941.w1K9f8NK054824@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UYE1pkz89qwWeywf"
Content-Disposition: inline
In-Reply-To: <201802200941.w1K9f8NK054824@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Enable stricter compiler
 warnings by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--UYE1pkz89qwWeywf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 20, 2018 at 10:41:08AM +0100, Gert Doering wrote:
> Your patch has been applied to the master and release/2.4 branch.
>=20
> Tested on FreeBSD 10, Linux and, indeed, AIX 7 :-) - Linux/gcc is nicely
> clean, FreeBSD/clang finds a few that are silly and want fixing...

Yeah.  Right.  And it blows up on centos-6 and opensolaris-10.

Now I can't claim that I understand this...  David double-checked this
macro and m4/ stuff, so "everything should have been good", but it
isn't.

CentOS 6:

checking lz4.h usability... no
checking lz4.h presence... no
checking for lz4.h... no
                usable LZ4 library or header not found, using version in sr=
c/com
+pat/compat-lz4.*
checking git checkout... yes
./configure: line 24067: syntax error near unexpected token `newline'
./configure: line 24067: `AX_CHECK_COMPILE_FLAG('
make: *** [config.status] Error 2


OpenSolaris blows up at the same point, but with less detail=20
("unexpected (" or something like this)

Now what...?

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--UYE1pkz89qwWeywf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJai/G6AAoJEB2Cnv7KVigSUq8L/3E0BeCAngYdl3rA16e6RcM9
6UOE5zZ2y7U1RSX8hf997zh+eGhLfEY6nGWrq3jQBhJ8n6KIbygni8f81IOgYACT
4BHUMtZVesXolPZCrw1MO9lYYUb2jPK3GoD7VInpvpHB7wgetb96HIX+z1vaFCZh
0cBCxwYUM6cBXtW7qDux7ZrKLLYYdrPwMj0mfyIcKO1KRcZepZlC9xozPHfGr3L1
KBRdOFEq0EVtqmbpJqXocLztkninAXSQ3jTkNfXyFvDThm83mLX0eaELYpqn0BLf
0Un28OJ6BdzUPV4oZpWWZa+p7flkX1UEVp07b8OQq0BBZfRgNh8yMtnxwwPvcAPC
HDz8HpiGsdFV4S1u0pqqA9GuAuyU3TD5umcKzr7a+SBsKnHVs7vzfrXRDMHgD0iH
urJjvo/v4xAb6Jcae93mPQ2meMW48P2n+veOOTFXHmdSnzvVL8rXSD2uonilI1e0
Ep4OMRQhZWgKtEtzysD+jF1EFaj5zzwOX8JUAcBkDw==
=+Kmr
-----END PGP SIGNATURE-----

--UYE1pkz89qwWeywf--

