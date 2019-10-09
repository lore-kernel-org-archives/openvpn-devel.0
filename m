References: <20191009095200.9337-1-gert@...1296...>
 <20191009095200.9337-2-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5d0baa86-bf8a-0abc-6e41-866575b6beaa@...2181...>
Date: Wed, 9 Oct 2019 13:11:04 +0200
MIME-Version: 1.0
In-Reply-To: <20191009095200.9337-2-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CaT99sX0qPX0A3TTv4OIlWOnDx1t1c5ow"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix IPv6 routes on tap interfaces
 on OpenSolaris/OpenIndiana
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CaT99sX0qPX0A3TTv4OIlWOnDx1t1c5ow
Content-Type: multipart/mixed; boundary="ce2XYcc4VWMJOmEVFK8O7f4Wf4YJOAXOu";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <5d0baa86-bf8a-0abc-6e41-866575b6beaa@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix IPv6 routes on tap interfaces on
 OpenSolaris/OpenIndiana
References: <20191009095200.9337-1-gert@...1296...>
 <20191009095200.9337-2-gert@...1296...>
In-Reply-To: <20191009095200.9337-2-gert@...1296...>

--ce2XYcc4VWMJOmEVFK8O7f4Wf4YJOAXOu
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/10/2019 11:52, Gert Doering wrote:
> The "route add" code always used "metric 0" on OpenSolaris, because
> (on tun interfaces) it was required to make the route work on
> "non-ethernet" interfaces (connected, no NDP).
>=20
> This breaks routes via tap interfaces on recent Solaris versions
> (tested on OpenIndiana 2019) - there, routes only work if metric
> is !=3D 0 (or just not set).  Otherwise it tries to map the gateway
> address to a local address and fails.
>=20

I have no means to test the code so I only stared at it and ensured it
was affecting the SOLARIS platform code only. It does what the commit
says and it makes sense in the solaris-nonsense-world.

Gert has performed some live tests on his new OpenIndiana 2019 host
(where the problem was observed) and ensured it worked fine.

Acked-by: Antonio Quartulli <antonio@...515...>


> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/route.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 3183fb47..97e90e56 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -2043,8 +2043,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct =
tuntap *tt,
>                  r6->netbits,
>                  gateway );
>=20=20
> -    /* on tun/tap, not "elsewhere"? -> metric 0 */
> -    if (!r6->iface)
> +    /* on tun (not tap), not "elsewhere"? -> metric 0 */
> +    if (tt->type =3D=3D DEV_TYPE_TUN && !r6->iface)
>      {
>          argv_printf_cat(&argv, "0");
>      }
>=20

--=20
Antonio Quartulli


--ce2XYcc4VWMJOmEVFK8O7f4Wf4YJOAXOu--

--CaT99sX0qPX0A3TTv4OIlWOnDx1t1c5ow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOj/Eejms5Fxtp0v4pNfqZUlHtXIFAl2dwEkACgkQpNfqZUlH
tXJYkRAAnloLAz9V2xua7fAg+f0r3kh+lWjl4iaC5LqBcv/noB2aVZjxGAyE8EAJ
4Z5bWTxzuFykq/W8YiNuNUauJGGqr1475Z49hHkhTmYONJRfZDtyDHBYen1VgKJd
Ax+57NLOFP8xbj3kohyfjaR5oLypXyIUwKptmZKYNQihfsSzW27htf1xrwdrb22Y
g+67tcRwjbmnZGQ177voShxBC9YsFEGLyArx4HXZJMawuLL/kyH3Rjemxmcb6fjZ
hyo0bPS4MCVsmkqHTOiK07odfpQuGUIelggMvhUMMGxw7M0Rj4EbxdX9T6A1/LBF
yIHrivKAhSiHlkq66rHFR9FNvtvChb04T2CkF2Lk2n73DPoB/ehtjat2MVTrDHwv
ZW/xzE30jL1wSEvBNBmRCpKa/RpJ289OJO2EI8hQjB8lYi9xFNZa+4zJ/WQ/fPUH
rm8r4FVb7BWj5DBjLYVzdsWCjCe+tsAjTO3ZmDYAWsvW4EfXv+BOF/1WIWjnl/hr
ssttS3krkIfZB0f9gFttCeIrFyvjRrUBUm85BKnCAh3jhePAbhW0f5uwlUX3os8T
w9e3gc439cq5I5DNn7dAHCR3VLtAONunMom/RYI+Detn8Iaya1mQavoGXNwX/FPB
dr14pS1l46ftHhYTrDf7x2exVC1TMX6IWVpEbcHhijrIHBRBPFQ=
=nEvF
-----END PGP SIGNATURE-----

--CaT99sX0qPX0A3TTv4OIlWOnDx1t1c5ow--

