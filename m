References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-4-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <22f635b0-8fe4-524e-17a8-3876aa026c20@...2080...>
Date: Sat, 12 Nov 2016 12:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <1478636302-9678-4-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="34K9Fu6X1DnKmGOGuO65rSRhRqGQUsoIb"
Subject: Re: [Openvpn-devel] [PATCH 3/5] Add missing includes in error.h
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--34K9Fu6X1DnKmGOGuO65rSRhRqGQUsoIb
Content-Type: multipart/mixed; boundary="I6N3qFgWB8apQ32uGEn1sbHuExkWbP6Uu";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <22f635b0-8fe4-524e-17a8-3876aa026c20@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/5] Add missing includes in error.h
References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1478636302-9678-4-git-send-email-steffan.karger@...1435...>

--I6N3qFgWB8apQ32uGEn1sbHuExkWbP6Uu
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 08/11/16 21:18, Steffan Karger wrote:
> error.h depends on these, but is apparently never used by files that do
> not include them.  When implementing the --tls-crypt unit tests, I ran
> into this.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/error.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/openvpn/error.h b/src/openvpn/error.h
> index ced2fdf..1d791bb 100644
> --- a/src/openvpn/error.h
> +++ b/src/openvpn/error.h
> @@ -27,6 +27,9 @@
>=20=20
>  #include "basic.h"
>=20=20
> +#include <errno.h>
> +#include <stdbool.h>
> +
>  /* #define ABORT_ON_ERROR */
>=20=20
>  #ifdef ENABLE_PKCS11
>=20

This one is easy! :)  Without this patch, the following patch will not
build, so ACK.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--I6N3qFgWB8apQ32uGEn1sbHuExkWbP6Uu--

--34K9Fu6X1DnKmGOGuO65rSRhRqGQUsoIb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYJwJZAAoJEIbPlEyWcf3yAycP/2qo91JFt3QcE/l5GAK3gGfb
uS16I9kzO/ZvZ7oKFJcTVEUV1h6fc1cB9amM/mr4by5Vr9Akxp+aC1JW3why76jS
mmxgHS+SAcVbRsJcLf8Sx3/Kv7iz6KZQNNAUWyqxNZeWdh8OS0oUY4E8lJ9FrTg9
MCjAkf9m4RxzJtuCTUhzyPA9nPVpfI9Kq4S3SNqqzbn4Fe3DMOvCyYZJ4q3B0IHh
X4gfF8QKSYAhH8oWqRiWwODOaO7zN77oC6zQ4JB3SU/XLcePHE9hX2y+NIZ6Nduz
qIBc2YJwu7SuMP6f2IH/jNnGTfKOsaSMQL3z4oFClaRNCb7ctcoZ5ugXnyoEYNLp
bnslN20MGBogmM+uLbUee5e2jh+KQGC6wu04qV+SwURqiKIgPMeMACDB+IBmKSig
zqf51eICP++AGylnuowtKsg/Jz88/luMsb4nRojKnErOv13XYaox9gMnaRo5RL44
m7BCCd0I0DKZwCa/MNfyKrgmyM3cVprhluPrQBSqL54iAPQyxZc9dkv1cO0K8uff
gMTTZde56986W3/1qs74TgiCDuyV6cGQmK7Zmg6Md8aM+fKCWBuD7ppB9tw14y4t
vqrZGk2BMV3aX8D2ZalmsBZMzc3SKBhonsWBaMlfxh3Gto4j1JFNXSmQRF828w/I
qQ8HQ9B7G/97vjlCzO/e
=fo8/
-----END PGP SIGNATURE-----

--34K9Fu6X1DnKmGOGuO65rSRhRqGQUsoIb--

