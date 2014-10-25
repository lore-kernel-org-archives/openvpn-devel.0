Date: Sat, 25 Oct 2014 12:54:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141025105409.GJ396@...1296...>
References: <1414230851-5350-1-git-send-email-steffan@...1856...>
	<201410251041.s9PAfotc012557@...1295...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3vG/4P2kj9ZtXmMR"
Content-Disposition: inline
In-Reply-To: <201410251041.s9PAfotc012557@...1295...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove unused variables
	from ssl_verify_openssl.c extract_x509_extension()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--3vG/4P2kj9ZtXmMR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Oct 25, 2014 at 12:41:50PM +0200, Gert Doering wrote:
> ACK.
>=20
> Your patch has been applied to the release/2.3 branch.

... and to master.  Given the comment on IRC I wasn't sure if that was only
2.3-specific (like the first patch) or "both branches" (this one :) ).

> commit 6e469f46e94b2bd0fc1509f2bfbda4d6b5374b14  (2.3)
  commit 86fe01897b9ec3f30c23395cc757f0e0b1393b03  (master)

so, untypical sequence, applied to 2.3 and cherry-picked to master, but=20
in the end, it's a trivial and obviously-correct cleanup.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3vG/4P2kj9ZtXmMR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEuBUakuBuNlUUl1AQKQrgP/ehfMzC1sKbs2+2eQKBBjP6l+Gk8Ra7J3
SkO1psG2eDCbUUkzI4CAMi2sVsG5oIOLugAw75qOt3GR+bqUuQiIODqBGRnZb6A2
hXWxhoOcgsLh3dWHDE6x7jWoHnciMqh0dg07NZeg1zyELFiPGZPnQaM5OtyLc+0U
99hxm5AbMiI=
=l1+Q
-----END PGP SIGNATURE-----

--3vG/4P2kj9ZtXmMR--

