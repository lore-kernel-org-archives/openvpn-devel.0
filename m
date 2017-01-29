Date: Sun, 29 Jan 2017 23:43:04 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170129154304.GG12187@...2182...>
References: <1485673091-7600-1-git-send-email-chipitsine@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <1485673091-7600-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Resolve several travis-ci issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Ilya,

my 2-meta-cents here: when sending multiple versions of the same patch to t=
he
mailing list, I'd recommend to change the subject to "[PATCHvX]" where X is
the patch version.

This way it is easier to identify which patch comes before and which after.

Not sure what the maintainers think about this, but I stumbled on the wrong
version a couple of times today before realizing that the newer was another=
 one.

Git can do this for you by specifying "-v X" (i.e. -v 2" to the git format-=
patch
command.

Cheers!

--=20
Antonio Quartulli

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYjg2FAAoJEJ6F1zG2JyOsQn4QAKQJX3RFef7k7UPav+f7teVh
hXNyQJBWargprrbXIw+EH6h4flL/ASjz9s6+QDW/Pcse/vGQppotPTMqRAlOgm/8
4IBpmBlZg6HK15Z0O2DdICtNwDOf7249d9cCrvmey+QShf6djqU5gFptfrQOyLb5
xutG2wevnOuZIufPPtzAEYKy8aHyZChyQoa1EFpsxwP2uK2F/sxRuNTPpn9u5wbG
YyDP1VhCtqGI0A5i9XVmslNtMgzHhC7MqHrUIaURbQ5p1sH/dadJT7Na7mU6ur8/
BYI8SDYe+7zwQeTbnKBZRzdlKOM61LwLqH6geVpAaazJ13RaEQWCwlFai/6MaQpr
vAqp2pXIyHjXAQiYWgad/zNH6k8N9WaXT8WXFounfbRhXjcr4eAryd1Cgv6ZL2mg
MFvg/xoY/Ea2Vgxtg+NiGC5zrimRRRnoZkwmJcnkjemDS+KVSBo64x4Kqex/kSpt
f2PM0twZxjuqhv+smDy1lBUZXGGzRvE/CzvcxayxTruUCsZ4aSRineqe04a6v+ms
wEHU2CQa6efWvKHhOreo9+cFzzgasoQUNYxjL4Zl+vkPSiibAYJaVSq0xSZYZhk4
gojD7ZE8Zf0j+WcxQEfNXYgAFaQwRIiaQZNoX9mhWfeiv0EFixGPu344fPciDSzS
mwIeT60XJGARXptTD0Kn
=bYZZ
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--

