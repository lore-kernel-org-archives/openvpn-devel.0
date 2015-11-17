References: <562EB0A1.8010403@...2070...>
	<56307DAA.30700@...2070...> <563083B1.2020908@...2070...>
	<CAKuzo_hhRVGfPkEaE93oqGO89baPD1=9qVFYZ2=yQSuHC7Fs9g@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <564BA7BE.1030703@...2070...>
Date: Wed, 18 Nov 2015 01:18:38 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hhRVGfPkEaE93oqGO89baPD1=9qVFYZ2=yQSuHC7Fs9g@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xB10DGvIsIPPFGjbnQoCtQmaVMT74TdES"
Subject: Re: [Openvpn-devel] [PATCH v2] Add Windows DNS Leak fix using WFP
 ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xB10DGvIsIPPFGjbnQoCtQmaVMT74TdES
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Fixed all the issues you mentioned, please try v3-master.
Still can't reproduce the problems you and Lev have. Set TAP adapter DNS to=
 static addresses, works fine. Played a bit with static DNS also on internet
interface, also works as expected.
Tested with W10, can't run W7 yet.

On 16.11.2015 09:17, Selva Nair wrote:
> Hi,
>
> Here are some comments on the code -- there is one apparent memory leak (=
see below).
>
>
> the word "external" is not required nor appropriate as it blocks all, isn=
't it?
>=20=20
>
> This error/warning is unnecessary and confusing. If the user does not wan=
t to block-outside-dns, why say "can't block"? And why the "without configu=
red DNS
> server" remark?
>
> in win32.c
> +
> +    ret =3D ConvertInterfaceIndexToLuid(index, &tapluid);
> +    if (ret =3D=3D NO_ERROR)
> +        dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
> +
>
> Is it safe to ignore the ret !=3D NO_ERROR case? May be it is...
>
>
> openvpnblob is allocated here, but not freed anywhere. Need to free it be=
fore return.
>
> Finally, to nitpick,
> There are a couple of unused variables
> Some local vars could be eliminated (rpcStatus, dwFwAPIRetCode, ret)
> FIREWALL_NAME defined as const, but passed to non-const
> ZeroMemory --> CLEAR
> CopyMemory --> memcpy
>
> Regards,
>
> Selva



--xB10DGvIsIPPFGjbnQoCtQmaVMT74TdES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWS6e+AAoJEFzXIC7viPdy0dwQAMYnBxrSi0oTdNtgqA4fCngJ
TLWSA81As/KvvTrFlzSSuEPrHD646RydJmb4pRfw2FA56fe1vBGEbiNAUXY/DxVj
uKLt1uXXyciNANj6DDBpRmC2/exIDvO89pjSt+ZaiNWwQgbaI8Hy9qGGx+iR2Ekh
AOi/jkwwB7Yv7s/l+0eo58srHL0pWQr4LCubwfWaNEk7/V7mVczIBv5Ra/D5vxuB
GE3m2NQFglMzQupVTX7Aw3Qf2WLSoYO6az0hA4ertWGMMSTEd1nLgKURgHMA8q00
vOUxfhMSyW3z7AT6UzwHMqF/U+n/aOt6XeGqnqjMkAvDv3ZosRXyplDN77UmW6uZ
EPxiN3B2ZS4R8YGhkmVcCSZJgxBB/vwKQHdF6aRc/ycsWgfXnCirPqj7FThU52n0
fN7k+gCf5KGCnWFNctwJHNWNANCgKR8BLoNtKwz+uccs+rLQHMJVxRd7NMqOMVwV
huxQjQ53sYSUCGrM8KppwllClRdQQHplzgs/K/ekUUkSIHYu4yM/lhY+CpqfRLJb
3ZdheA9B98ASxf2Dfk52iUdx/TGhIuJy78WofpZ62Stbv60THs7oQHsKsMw/2lML
2iDJnP0lZ4LQKqVn2JFuwBusnuEKM6jZ4tNDkYR8QaOOdrurco4rfENM38sj9Ma7
PDc8pyOcLTFVSH67LGLc
=7jGR
-----END PGP SIGNATURE-----

--xB10DGvIsIPPFGjbnQoCtQmaVMT74TdES--

