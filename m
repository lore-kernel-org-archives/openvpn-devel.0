Date: Sun, 11 Dec 2011 21:37:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111211203701.GH18948@...1296...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<1323357860-2506-1-git-send-email-davids@...1347...>
	<20111209080212.GC18948@...1296...>
	<4EE2289D.3090507@...1114...>
	<CAOazyz1Y8cXmm1py=V-6+N2tBQx1OS42Hq5buVSH4UJYxRHQYg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuJpT0rwbUevm2bB"
Content-Disposition: inline
In-Reply-To: <CAOazyz1Y8cXmm1py=V-6+N2tBQx1OS42Hq5buVSH4UJYxRHQYg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename()
	over to platform provided basename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--IuJpT0rwbUevm2bB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 09, 2011 at 08:19:31PM +0200, Alon Bar-Lev wrote:
> In my opinion, in order to avoid confusion there can be two options:
>=20
> 1. Use library functions as much as possible, providing the minimum
> common ground
> in compatibility layer if missing. This ensure applying fixes and
> functionality from
> various upstreams.
>=20
> 2. Use own implementation everywhere, taking responsibility and
> control over the implementation
> and maintenance.
>=20
> Mix is only confusing, and leads to even more errors.

In this two either-or extremes, this doesn't make sense.=20=20

Of course nobody wants to reimplement all library functions (except=20
djb, maybe, but we do not want to go there), but given some functions=20
with sufficiently vague or messy calling semantics, having a better=20
defined local implementation can improvide the code a lot.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IuJpT0rwbUevm2bB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTuUUbakuBuNlUUl1AQKi/QP+NLUATSL1v8oC/C/5WTgKIwKPbyilJCdc
mE9BJ5QvKkBxYjabE3/Z8RPmKGCCtu7z9co9Tm5hRd7kBTNvOFHwxXFepqLDsGI9
KP/ZYoGtKXzDGiUssE3Jtetzgub2S72h/DbAN1SdXYXEyWj4tIxQkNIqo/F+xjEF
UCxLp7BjZgw=
=Trbq
-----END PGP SIGNATURE-----

--IuJpT0rwbUevm2bB--

