References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-2-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <62dac7a4-3536-0f6f-1600-2d938428d3b5@...2181...>
Date: Wed, 11 Jul 2018 10:01:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180704175404.22371-2-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wlmjEu6pummPcj34WONg8CYa7RKJfhI2G"
Subject: Re: [Openvpn-devel] [PATCH v2 2/9] Move execve/run_script helper
 functions to run_command.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wlmjEu6pummPcj34WONg8CYa7RKJfhI2G
Content-Type: multipart/mixed; boundary="ecB3fqdVBwtldaqoTKo1fw37VZZpLVMqg";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <62dac7a4-3536-0f6f-1600-2d938428d3b5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/9] Move execve/run_script helper
 functions to run_command.c
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-2-steffan@...1856...>
In-Reply-To: <20180704175404.22371-2-steffan@...1856...>

--ecB3fqdVBwtldaqoTKo1fw37VZZpLVMqg
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/07/18 01:53, Steffan Karger wrote:
> To avoid having to include misc.c - which is a dependency mess - in the
> tls-crypt unit tests, move the command execution helper functions to a new
> run_command.c module.
>=20

one thing less into misc.c :-)

After having witnessed the dependency mess in the unit-test, I am
definitely "pro"-this-patch as it simplifies quite a bit the dep-hell.

> While at it, abstract away the script_security global variable.

I like the idea of getting rid of a process-wide global variable,
however I think that script_security should simply be a member of the
options object or of one of the contexts, rather than just hanging on
its own.

However, I'd postpone that to another patch. Your change here is already
a step forward.

>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---

[CUT]


> +/* contains an SSEC_x value defined in platform.h */
> +static int script_security_level =3D SSEC_BUILT_IN; /* GLOBAL */

Maybe this "GLOBAL" thing could be removed as this variable now exists
only within this file?

> +
> +int script_security(void)
> +{
> +    return script_security_level;
> +}
> +
> +void script_security_set(int level)
> +{
> +    script_security_level =3D level;
> +}
> +


[CUT]


Other than that little nitpick, the patch looks good.

Checked with "git show --color-moved" and I could verify that the code
has only been moved (slightly adjusted to avoid long lines) and that the
access to the security_script variable has been substituted with
getter/setter functions.

So, with or without the nitpick:

Acked-by: Antonio Quartulli <a@...2181...>

Cheers,

--=20
Antonio Quartulli


--ecB3fqdVBwtldaqoTKo1fw37VZZpLVMqg--

--wlmjEu6pummPcj34WONg8CYa7RKJfhI2G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltFZQ0ACgkQB6U8WA7y
zXThNhAAvPJhCD+7ifzJ/25RzrrNWKF5hZbGoWIhth5QH8EBTa5rMmrHlqyvfqMm
ZcN/dWxUR20sfp2hVyLNOQWNpuwR8B3LTRuQShb+3UBEpBPsMDd7ihkUnsSaVhUp
XCgBPDRogZOHBHn8GQhHV7lYogpgg/ky+gtB9qe5+h++3gODc4rghq6moHkzNFrY
W92EWKNy9mC2hPWfS0Tmy3oK8ZYY9UgobQ1wTn02UEdlClR3MGwLapF9AGFkHM0l
FNud1XQzTtS8bz/KMXFJDePPeg1TCnkFUiw2ZHP+xowohG63tINJfUuDzl0zBe3W
dnzrVh1IgcOW3dTx/HmYhg12zs5vQgr2kcEBZDeMugqP66PIVBBR/5ORU0fuS0cQ
PA0bgBDhqchux1Uw2+cRVFUAudNPcU9Jsf9t09rCVrefCKDiU4ueIQcAzwSB/HsA
e+bTXIkjVpXZWA3sIPnWj8OemTMYNaDkJKX7gdKiOcwRsIo5NMupaZgBztNiwAi4
UjaB+ljUr+n/NKbVf3Nj55DJf0hyh6ImWud7KE5N8NrzW0FTucxT7O3gGZiFXhPE
Vp2M797Q1EC+JkB4MQsmIzvMp2KFCcAhQOihU+40nggs/3biXPQKi4wnxcPUx6Ro
gqF3UI4uLJ74uRXkYD0J1bvs8jErHTyLiuTG43QZ7nDjSkvVlB0=
=Q8hE
-----END PGP SIGNATURE-----

--wlmjEu6pummPcj34WONg8CYa7RKJfhI2G--

