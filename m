Date: Thu, 9 Mar 2017 22:20:24 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170309142024.GA476@...2253...>
References: <11de8219-d64d-a9d0-4fa7-a8c63a8d17ff@...1435...>
	<1489068043-25668-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <1489068043-25668-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix windows-build format specifiers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, Mar 09, 2017 at 03:00:43PM +0100, Steffan Karger wrote:
> A number of printf-like functions used incorrect format specifiers for
> Windows builds, which could potentially lead to incorrect values being
> printed / used when calling executables.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: add OVPN_PRI_SKT define to print socket type across platforms
>=20
>  src/openvpn/init.c    |  2 +-
>  src/openvpn/route.c   | 12 ++++++------
>  src/openvpn/socket.c  |  7 ++++---
>  src/openvpn/syshead.h |  2 ++
>  src/openvpn/tun.c     |  4 ++--
>  5 files changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 033318d..2a9a398 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1585,7 +1585,7 @@ do_open_tun(struct context *c)
>  #ifdef _WIN32
>      /* store (hide) interactive service handle in tuntap_options */
>      c->c1.tuntap->options.msg_channel =3D c->options.msg_channel;
> -    msg(D_ROUTE, "interactive service msg_channel=3D%u", (unsigned int) =
c->options.msg_channel);
> +    msg(D_ROUTE, "interactive service msg_channel=3D%"PRIuPTR, (uintptr_=
t) c->options.msg_channel);

A little comment about the style (codestyle maniac here!).
Should this:

msg_channel=3D%"PRIuPTR

be:

msg_channel=3D%" PRIuPTR

?

the " is closing the const char and therefore a space would be needed betwe=
en it and the
next constant.

This appears several times in the patch and therefore I thought it was worth
mentioning it.

Cheers,


--=20
Antonio Quartulli

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYwWSkAAoJEJ6F1zG2JyOsKA8P/2c5spbjlsXWDVv6zmU44PGx
LIGxNqMU/wFLVYXf6LblUW0O1u1loMzygeQwIBjvJdTIh/FrfAmyZ9cRnfV9OUZi
leJgYzVuEUdPwBZIQDQ/qZn/ybNSI/O/q2fBK7tkU7HNBo87RsnerDQlU9BQyQL2
3hWAIlpkeOIfC2BvKZs2fcWh9P8bIaTPCPjqOOneVfoQz1P4K5oIRgAsmTT8RqT7
3W/ICmpdX/iyyycpLMrfOFOFB587q6tzB2QhsKxPcvhYvgZz6iPxlMNCFt63HOEp
vxrM0obTO6T20NfdrcITcVdhLUZ50hbSRiuQ9bKjJuxNSpkDBDXGkWcA4rv3PlEE
Ct0x3DTN7JqZ9rZV2QvjP2rwFm/e5kvlwQMp3HuAfo1wCCLifkU6M+cnIXNw120f
0nXrZf6upRjRkDOXnjgg9AMwyXxwOC8vbPsBdr7noDFAZ5eFINMCfDnaqtMKe26b
6axLx9EZC8OcZSHAu2dqOmR9jhmZ8EB50gwmbm1w7DFzB/OB+TG2V3Z3h/U2l0s/
/A0BLjhQiLFZovh6SuAPSUtSHMz03gh1OnIHsUKI5vypEl0Y8Q8eWV2wXnryc0cX
1IudRxfJ/a9koA1Z2PNuoXUxpw9xFgtRwnZGCsoAZOdL8xbt7d1d5c6Cvcp4NfOu
+a3YQFcz1AZpe/zRGf4Z
=pezb
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

