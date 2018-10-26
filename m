Reply-To: openvpn-devel@lists.sourceforge.net
References: <1538995612-17450-1-git-send-email-lstipakov@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5abb34c1-22c7-ffd8-80eb-06250175ccff@...2080...>
Date: Fri, 26 Oct 2018 16:10:00 +0200
MIME-Version: 1.0
In-Reply-To: <1538995612-17450-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bpqizsNi4athsX9k1Yt6obxWxLezmceLG"
Subject: Re: [Openvpn-devel] [PATCH] Fix various compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bpqizsNi4athsX9k1Yt6obxWxLezmceLG
Content-Type: multipart/mixed; boundary="zWHPi2uqQGDsumdmkl48TFLup3HStgGuu";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Lev Stipakov <lstipakov@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <5abb34c1-22c7-ffd8-80eb-06250175ccff@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix various compiler warnings
References: <1538995612-17450-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1538995612-17450-1-git-send-email-lstipakov@...277...>

--zWHPi2uqQGDsumdmkl48TFLup3HStgGuu
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/10/18 12:46, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> This patch fixes "unused variable/unreferenced format parameter"
> warnings in different places, kudos to Visual Studio compiler
> for discoveing some of those.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/forward.c |  2 +-
>  src/openvpn/init.c    |  2 +-
>  src/openvpn/init.h    |  2 +-
>  src/openvpn/mtcp.c    |  2 +-
>  src/openvpn/mudp.c    |  2 +-
>  src/openvpn/multi.c   | 28 +++++++++++++---------------
>  src/openvpn/multi.h   |  8 ++++----
>  src/openvpn/openvpn.c |  2 +-
>  src/openvpn/tun.c     | 11 ++++-------
>  src/openvpn/tun.h     |  2 +-
>  src/openvpn/win32.c   |  3 +--
>  11 files changed, 29 insertions(+), 35 deletions(-)

I was about to pull this in, based on Simons ACK ... but below is something=
 I
think we could do better.

> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 8440f31..ae4d1d2 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2936,7 +2934,7 @@ multi_process_drop_outgoing_tun(struct multi_contex=
t *m, const unsigned int mpp_
>   */
>=20=20
>  void
> -route_quota_exceeded(const struct multi_context *m, const struct multi_i=
nstance *mi)
> +route_quota_exceeded(const struct multi_instance *mi)
>  {
>      struct gc_arena gc =3D gc_new();
>      msg(D_ROUTE_QUOTA, "MULTI ROUTE: route quota (%d) exceeded for %s (s=
ee --max-routes-per-client option)",
> @@ -3373,7 +3371,7 @@ init_management_callback_multi(struct multi_context=
 *m)
>  }
>=20=20
>  void
> -uninit_management_callback_multi(struct multi_context *m)
> +uninit_management_callback_multi(void)
>  {
>      uninit_management_callback();
>  }

Is there any reasonable reason we keep this simple wrapper function?  The
users of it is very limited and I struggle to see the value of it.  Can't we
just wipe this out out?  This has been unchanged since the initial BETA21 S=
VN
branch dating back to 2005.  I struggle to see us changing anything drastic=
 in
this context.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--zWHPi2uqQGDsumdmkl48TFLup3HStgGuu--

--bpqizsNi4athsX9k1Yt6obxWxLezmceLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJb0yA4AAoJEIbPlEyWcf3yDkkP/iMA4ADPN+FGG6GygPCf5+Bp
6KdZ0FaciCLdMaaY9lb/MexLYBGjZN6B7PJjmRw7+XxKmJbuuCwZx11XpjbVOj9J
lXr94MOVIrac7WwDz/mZfNjNiAZdpHIULunDfhwJxzotHFDWrSwOJUkI8HJS5ma0
7yqoM+txY+EbJZSVp6nEH+zmWcZrdwOJnfxPelie3g2+UDRkvcEAQOwi+tL6lgPM
anlg6g140MnBc6ZBf6hHvgVDh1nUHnjnIwU3BL/uqJFQhqvKQIsMVPR9110Hvcgs
CvMVS9kd2L7mlgaNE0nLsHOJ4WaNNPxx9GgV36QaIJzrR6qC5Kwv1g7wsN5dotsl
vIJPuAdDgfcnLxIQ78qCtrWzXFmoAxfcMJAx17obuRPRPgM7Y7eBcUeA5XhBRs9Z
xpEfuiXJlUWVHSZdVoXxfqW0NsqqPSUL2HDGa2etvrJjQLxs65WO3VtO01u50qNw
f3CeXY4Hzt08/8DUlLzBbU93KHbnU9yNIOoKGLpK2hrgd9Ysc5Si6HhjoBruzAHj
ExR0oQlMKTSZQR3hAvDWROOST3T5I6kceyQZN8ypLSbMs+tQ1pv7SW5/eX96F2r5
yz3Kx757vND30mkn4UyOBcAvYEf8yYnwiKcCh4ILW/rwhDkvSf1HZzYog0ei/uQp
hLgsaLezUXM2OgmxMZwS
=VetK
-----END PGP SIGNATURE-----

--bpqizsNi4athsX9k1Yt6obxWxLezmceLG--

