References: <20200717112953.6699-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <152c54e4-beae-7ea4-a91e-60fbd269c1e7@...2080...>
Date: Fri, 17 Jul 2020 14:06:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200717112953.6699-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="G1Eg3zPTERsp7aPHkiNxqTEJ6a2fOhjE6"
Subject: Re: [Openvpn-devel] [PATCH] Convert cc_check_return to switch/case
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
--G1Eg3zPTERsp7aPHkiNxqTEJ6a2fOhjE6
Content-Type: multipart/mixed; boundary="7lOlRfpxFFltSJMKvUW07BTiujxFiol5o";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <152c54e4-beae-7ea4-a91e-60fbd269c1e7@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Convert cc_check_return to switch/case
References: <20200717112953.6699-1-arne@...1227...>
In-Reply-To: <20200717112953.6699-1-arne@...1227...>

--7lOlRfpxFFltSJMKvUW07BTiujxFiol5o
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/07/2020 13:29, Arne Schwabe wrote:
> The return false/return true is the result of
> running uncrustify.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 97b7df16..1fdf6ce5 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2229,22 +2229,16 @@ static inline bool
>  cc_check_return(int *cc_succeeded_count,
>                  enum client_connect_return ret)
>  {
> -    if (ret =3D=3D CC_RET_SUCCEEDED)
> +    switch (ret)
>      {
> -        (*cc_succeeded_count)++;
> -        return true;
> -    }
> -    else if (ret =3D=3D CC_RET_FAILED)
> -    {
> -        return false;
> -    }
> -    else if (ret =3D=3D CC_RET_SKIPPED)
> -    {
> -        return true;
> -    }
> -    else
> -    {
> -        ASSERT(0);
> +        case CC_RET_SUCCEEDED: (*cc_succeeded_count)++;
> +            return true;
> +
> +        case CC_RET_FAILED: return false;
> +
> +        case CC_RET_SKIPPED: return true;
> +
> +        default: ASSERT(0);

Code style police .... Even though it is not clearly defined, but based on =
the
example here
<https://community.openvpn.net/openvpn/wiki/CodeStyle#Casesinaswitchstateme=
ntshouldbreakorexplicitlyfallthrough>
...

... it should be more like:

   switch (ret)
   {
        case CC_RET_SUCCEEDED:
            (*cc_succeeded_count)++;
            return true;

        case CC_RET_FAILED:
            return false;

        case CC_RET_SKIPPED:
            return true;

        default:
            ASSERT(0);
   }


I generally find this approach more readable.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--7lOlRfpxFFltSJMKvUW07BTiujxFiol5o--

--G1Eg3zPTERsp7aPHkiNxqTEJ6a2fOhjE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfEZQqAAoJEIbPlEyWcf3yQzEP/iKpbbJ16vtuGwHHkzpsRUcD
O5eGj3du6Ov+MebyoHc+t9qSYFdOuVJgb7sY5COMgM709AmExPm67GkMkKLr29Go
JIKZ1Wzt2XsSL2WOjmOVh9OxPvaq7Q4vTyOilWDqNU63UU5sDzKGj7i/GKIH31zN
GGt3hhrWXmYoX9yd4jrJFB/qmX905wm0ZrPAtthqXn4bapFeSLfsnrvrYbR0BPsM
aKfciLreWecEesmz35DpsKQWwkoTrg5A9NKtShtf2YofRoqwGjvxZlxTuYjdx9pa
BPMQXnXNRxVjHtHk6Bs5riPSKh4in7evNSuV46sWpIk046/r2hRAyHQFBp6zaIi2
BW/G8u/82v8+Jqmok9WSLuzK5N9molKYzpS5SFf1KQt6h3GQxnl/iUTVEthvWFHh
ECXYdB6YL7OzscMBJvyMXOKqMsW+7EE7s8fmAwzIZY5W4ItlYgZ2zdol4z5F1CWv
jqY22PZfqs6oulXEA/psBTEkv0HivAgHjj2q4AYWBCweRK8VmzijMQeqO0PFtDGs
sA09aKnVBdl3wfCGL0Ckc6ju0Ox55PnIFvjHD1E5BV1RZGgwpbIgE6nYXa5zM8h1
FmIF5UaogyaL7ROUytz80JuPcO5kIMGBHVPmpvACI+qsNy9CIPhTMfIE4hFP0dPJ
oLvxxIKuUsU5hMkFHZPt
=nQsh
-----END PGP SIGNATURE-----

--G1Eg3zPTERsp7aPHkiNxqTEJ6a2fOhjE6--

