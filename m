References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-12-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d5a5d7b8-662f-ef51-4081-027fcb8cefd8@...2080...>
Date: Sat, 30 Jan 2021 00:16:58 +0100
MIME-Version: 1.0
In-Reply-To: <20210125125628.30364-12-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RL0eDJCarDcSF1TtePrryN5zbswJeUnUY"
Subject: Re: [Openvpn-devel] [PATCH v2 11/11] Add example script
 demonstrating TOTP via auth-pending
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RL0eDJCarDcSF1TtePrryN5zbswJeUnUY
Content-Type: multipart/mixed; boundary="CkbUwCqqlH2hrvzeL867ASRTXUivXYc7B";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <d5a5d7b8-662f-ef51-4081-027fcb8cefd8@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 11/11] Add example script demonstrating
 TOTP via auth-pending
References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-12-arne@...1227...>
In-Reply-To: <20210125125628.30364-12-arne@...1227...>

--CkbUwCqqlH2hrvzeL867ASRTXUivXYc7B
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 25/01/2021 13:56, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                         |   9 +++
>   doc/man-sections/script-options.rst |   3 +
>   sample/sample-scripts/totpauth.py   | 107 ++++++++++++++++++++++++++++
>   3 files changed, 119 insertions(+)
>   create mode 100755 sample/sample-scripts/totpauth.py
>=20
> diff --git a/Changes.rst b/Changes.rst
> index 188bd8ab..d64c6d83 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -19,6 +19,15 @@ Pending auth support for plugins and scripts
>       be used to parse a client response to a ``CR_TEXT`` two factor chal=
lenge.
>=20=20=20
>       See ``sample/sample-scripts/totpauth.py`` for an example.
> +<<<<<<< HEAD
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Deprecated features
> +-------------------
> +``inetd`` has been removed
> +    This was a very limited and not-well-tested way to run OpenVPN, on T=
CP
> +    and TAP mode only.
> +>>>>>>> 239e8cfd (Add example script demonstrating TOTP via auth-pending)

Ehm .... ;-)


[...snip....]
> diff --git a/sample/sample-scripts/totpauth.py b/sample/sample-scripts/to=
tpauth.py
> new file mode 100755
> index 00000000..95ac3529
> --- /dev/null
> +++ b/sample/sample-scripts/totpauth.py
> @@ -0,0 +1,107 @@
[...snip...]
> +
> +import pprint

This shouldn't be needed.

> +
> +# Example script demonstrating how to use the auth-pending API in
> +# OpenVPN. This script is provided under MIT license to allow easy
> +# modification for other purposes.
> +#
> +# To use this script add the following lines in the openvpn config
> +
> +# client-crresponse /path/to/totpauth.py
> +# auth-user-pass-verify /path/to/totpauth.py via-file
> +# auth-user-pass-optional
> +# auth-gen-token
> +
> +# Note that this script does NOT verify username/password
> +# It is only meant for querying additional 2FA when certificates are
> +# used to authenticate
> +
> +secrets =3D {"styx": "OS6JDNRK2BNUPQVX",
> +           "apate": "IXWEMP7SK2QWSHTG"}

Perhaps replace one of these user names with 'Test-Client', which is=20
what our client.crt contains.


This does actually work reasonably well, BUT ... there are some things=20
which could be improved in the documentation here.

Currently, both OpenVPN 2 and OpenVPN 3 Linux (which I tested) does not=20
support crtext based auth out-of-the-box.  But it's possible to=20
workaround that with OpenVPN 2.x. (I've tested v2.5.0 and git master).=20
I used this config:

   client
   remote 127.0.0.1
   dev tun
   ca sample/sample-keys/ca.crt
   key sample/sample-keys/client.key
   cert sample/sample-keys/client.crt
   nobind
   explicit-exit-notify 3
   management ./mngmt.sock unix
   management-hold
   management-query-passwords
   setenv IV_SSO crtext

Then I used 'nc -U mngmt.sock' to connect to the management interface=20
and issued the 'hold release' command and the 'cr-response' command with=20
a base64 encoded TOTP value.  I did update the toptpauth.py script to=20
use 'Test-Client' instead of one of the predefined user names.

So while this does work fine, it's not a straight forward way to test it=20
out.  And it requires client hackery (even though I bet this is not an=20
issue using your Android app ;-)).

I don't think we need to update with more scripts or stuff like that,=20
just mentioning more clearly that the client must support 'crtext' and=20
it is possible with OpenVPN 2.x enabling the management interface and=20
setting the IV_SSO env variable properly.

Otherwise, this generally looks good - but we should improve docs a bit=20
more and fix those minor issues while at it.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--CkbUwCqqlH2hrvzeL867ASRTXUivXYc7B--

--RL0eDJCarDcSF1TtePrryN5zbswJeUnUY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmAUl2sACgkQhs+UTJZx
/fKFPg//VHN0MBn84q05kg9L1t4YWK+HJl9bz1JRrLMFN5Q4ltrJH/W31JSMx+27
Ey5sfNXKRDKYkyjvWpm+lk+LrbuviAKsCiZiBYPiCw+2UsWf/Tiu91BPs8t8/h+U
wljKndww2614ggFI4ExwoLzB/AEEuQuxAKFV4RG2AbVAlUfnHY61JcAzLtfrD0Ey
PU9N6uDcTHPjYiScK/t/74nnBk6Zfe37o8/DOefTsEeJJaJl1XazRoHuIOGY+yMe
ngT+vkXtd6l68NICPWNyKzibcAnAf2GK124WNG1cXaHp7r0/KF+shAmo3kJzJcfQ
4x9SZ5COn0Pgwjqme3X6MHS9arjIeweRl7Z14mMlP9+qefW5yUZ+fmd7+JdALi7k
9OFDKXnjrW5OkStAtViD9HllyhXx4nZwrqsTh8AAyqZVjAuvpdAuOORVUGXLPA8S
ohmKK5NCthF5VKN7wgmF5AXeBwZPURPy6R6hlU/RJzhhRIaLWSXVU4VsIyt/YEbx
thfBV9zTo3sgXWmlZ9by8OUCYUJsOi6GXUdBkxRRx3Biz++bLlp14bKduRrt8LCb
dR8q8Esb1m26qtae83NNmO+mBAT2zNaspDFF2GRfw8xcBBZmDFIYRTBNu0dGp12L
rtjLzb0gbfK3rKgZ4/Uyfsl7sWPgubs9pPRhXX32a+x2H56VW48=
=fRZP
-----END PGP SIGNATURE-----

--RL0eDJCarDcSF1TtePrryN5zbswJeUnUY--

