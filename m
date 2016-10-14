References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-5-git-send-email-davids@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7904fb91-3d07-46cf-e4d2-c03512209662@...2080...>
Date: Fri, 14 Oct 2016 13:32:09 +0200
MIME-Version: 1.0
In-Reply-To: <1476388771-16492-5-git-send-email-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TT1W0vTlqQWk0ofOAMc7BSfbvdrv3Pk0L"
Subject: Re: [Openvpn-devel] [PATCH 4/5] auth-gen-token: Push generated
 auth-tokens to the client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TT1W0vTlqQWk0ofOAMc7BSfbvdrv3Pk0L
Content-Type: multipart/mixed; boundary="4rW3IcfQ7kAojKvicm2oHrXRqGEQJ9oCK";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <7904fb91-3d07-46cf-e4d2-c03512209662@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] auth-gen-token: Push generated
	auth-tokens to the client
References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-5-git-send-email-davids@...515...>
In-Reply-To: <1476388771-16492-5-git-send-email-davids@...515...>

--4rW3IcfQ7kAojKvicm2oHrXRqGEQJ9oCK
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/10/16 21:59, David Sommerseth wrote:
> If --auth-gen-token has been enabled and a token has been generated,
> ensure this token is pushed to the client using the 'auth-token' option.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/misc.c       | 5 +++++
>  src/openvpn/push.c       | 9 ++++++++-
>  src/openvpn/ssl_common.h | 2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 225f0bf..b74ac9d 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -2073,6 +2073,11 @@ sanitize_control_message(const char *src, struct g=
c_arena *gc)
>  	  skip =3D 4;
>  	  redact =3D true;
>  	}
> +      else if (!check_debug_level(D_SHOW_KEYS) && (c =3D=3D 'a' && !strn=
cmp(src, "auth-token ", 11)))
> +	{
> +	  skip =3D 10;
> +	  redact =3D true;
> +	}

This magic here should probably be explained in the commit message.  It
basically removes the auth-token value from the log file, unless --verb
is set to 7 or higher and debug logging have not been disabled
(configure --disable-debug).

--=20
kind regards,

David Sommerseth


--4rW3IcfQ7kAojKvicm2oHrXRqGEQJ9oCK--

--TT1W0vTlqQWk0ofOAMc7BSfbvdrv3Pk0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYAMI6AAoJEIbPlEyWcf3yXo0P/06OOsG8DI+a9UM3qd0RWc56
qJhTkd/URnqQ4OcVWLCqDjuKa55I2lM5czg69/J2Ou+JMEcTrC+3lXHmrukLOccl
Y3a5QhjGdhJmVcAW67VqP2RZeYeKlDVzb7/KGwhseA/erlSbAyrIcfcju80O6uzy
d+6Hs1dUto6Xqt+0kjZ+pKI7Ek1yDo92h55yMUU82Sm3VlNDJWE1yoRprmOBHXTE
h5/aC8cA2jzzcovGlwJJgKPlgVNHoNyMAOA9ot1/zJY+jvroXCXrqX6xTPQZZFR+
Qw4qynrDPGW7mvN4KDfyAq4+mdn5gdb9uaVOnuYPHA0A5Od0ipVX53pKhbGRgoLV
jxjH7kOPB8pJ1xeYpgRBpta01mIJPua9LATT+miqVCoeYpoBmv1cbRCwGYc0wG8S
EKhcmmY3DsPNcHYEPr3qvPR9KvDWUwXAmLqQJA2bJs9lK5cIbnKtwDLqHCo0Urdc
+GlSpskU+Yab+Wa72xl4JiwSQUw3DyBdDkKRJG16lYiHl5AfiJNFZ2yFAjnH78ph
Lv0mkYzh5Yd3G/wPFWHBdUktwehS1RgGjHRvlemeQYHvagrHM+LIKrdzBN5M8NYR
97hbexI23i9eDrynByP1S2crq/7hnNphG8o9+LFTWQa0A/D8KhqMtZV1OzULQqZb
a6fpUPW3QzbUgYLjMtcE
=88DH
-----END PGP SIGNATURE-----

--TT1W0vTlqQWk0ofOAMc7BSfbvdrv3Pk0L--

