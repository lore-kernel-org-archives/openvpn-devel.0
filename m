Date: Wed, 14 Dec 2016 10:09:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161214090932.GC78624@...1296...>
References: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
	<1481705478-29735-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EIrXVFSPgsocVIgL"
Content-Disposition: inline
In-Reply-To: <1481705478-29735-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Disable async_push if plugins are
 disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--EIrXVFSPgsocVIgL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 14, 2016 at 10:51:18AM +0200, Lev Stipakov wrote:
> +/*
> + * Disable async-push if plugins are disabled
> + */
> +#if !defined(ENABLE_PLUGIN) && defined(ENABLE_ASYNC_PUSH)
> +#undef ENABLE_ASYNC_PUSH
> +#endif
> +

That one gets a NAK from me, for the reasons given.

As long as we *have* --enable/--disable options in configure, they should
be validated *there* and not silently ignored.

David's argument about "configure is for finding system dependent things
and compiler settings" has some merits, but then we should get rid of all
compile-time --enable/--disable settings.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EIrXVFSPgsocVIgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYUQxLAAoJEB2Cnv7KVigSN3UL/RyUUbjfJEJN+IVpvkce1bUI
8nSdeVo2mw1ReYfZ473CD1PklN3ORL0KuFvnTagb4BWOGKAu5n6Q3cCKlmxupGcj
1bTdQdZc8zDqeeuGKMqaj66v+KYnAKMzCcYOoeDmde4O8agtfwWZo5s+Qa5JR734
I8nkhJXTqx2BRMOlGfTjYFgHfPL2mqwkZKMZDm3SEBUeWVqM/t/0v3B8P+BIfvxN
ONu6GiGHlRGq+wqTjrPmY30OENshPiOaeYhST5GxYFVKySW+PVxZ2TWX+Q+IfQEy
+Wxq2N+DglnALQgRCRd1T1E4oyIBSxuv0TEaYa2sa9V01rYaw1wjd/AjVlNVlc6u
CHkgwzLpa7A4PHeyIxHmSL5Ze0Z4dEXHUNr18zWZDoHu/96aZBZiSm23kyB4G1kn
5WD4BrDwPbbg8hZ8kwQNuYMhFUsWauz0KJM7i8wWj9ol7hEGUhByYzvZ2V6u1m6U
e/LHdZC9ebDjiPrbiARHf0F3QqUOl9Qm5Y5IdwdMDQ==
=K4hJ
-----END PGP SIGNATURE-----

--EIrXVFSPgsocVIgL--

