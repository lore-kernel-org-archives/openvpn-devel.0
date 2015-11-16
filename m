References: <562EB0A1.8010403@...2070...>
	<56307DAA.30700@...2070...> <563083B1.2020908@...2070...>
	<CAKuzo_hhRVGfPkEaE93oqGO89baPD1=9qVFYZ2=yQSuHC7Fs9g@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <5649B56C.6050506@...2070...>
Date: Mon, 16 Nov 2015 13:52:28 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hhRVGfPkEaE93oqGO89baPD1=9qVFYZ2=yQSuHC7Fs9g@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dc8jMHUlGGUuBUgj5qNNrSjdldh52ktax"
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
--Dc8jMHUlGGUuBUgj5qNNrSjdldh52ktax
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 16.11.2015 09:17, Selva Nair wrote:
> Hi,
>
> Here are some comments on the code -- there is one apparent memory leak (=
see below).
>
>
> the word "external" is not required nor appropriate as it blocks all, isn=
't it?

I'm not a native speaker. If you say that, probably you're right.

>=20=20
>
> This error/warning is unnecessary and confusing. If the user does not wan=
t to block-outside-dns, why say "can't block"? And why the "without configu=
red DNS
> server" remark?

That's a garbage. There used to be a check for configured 'dhcp-option DNS'=
 and I forgot to remove that. Thanks.

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



--Dc8jMHUlGGUuBUgj5qNNrSjdldh52ktax
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWSbVuAAoJEFzXIC7viPdyTnMQAKi5JJ6Uw/x5Jee9vLFQ8AEw
7dOIbfRHbCUHv5IM9mzM+0sDkt7y/xoKYIs3DT1ECG3V1p6hlexHj0mYGB6smaKZ
BLqnl9vDQ9Vn9eAH1eqkrJy0yueQqNhjZGtmMRUVwJANVZRYbrR21Z5OsiuUm8dS
U+4IqZoph/KDSKzwPMquuFlU0EySV5TciyLHoq9HQ8Lza/jsOgCM8EcHYUDyMX+e
ZgeGES9i6Y9t3VYVZFznRPPfc2FspLd80iW2CRDyucQ/qNDL2lGB1QMSU+VxAu6q
Rqjc4iI1UnlIZzeguyHVqblBnQip+u7vn2wiXw1zgJU7GknwKDMPLTdiCAQ8Of9y
98CpWKeWDpHP6vinYylBf9EqSFaQ99WYWZDpsGsc81fRtz+HT67DkVOTXSHu54be
MSrrJspjmaTDFDaiuiQUJITka3ZCD/jelf4hPBLM/x4D7IDzneHN4LsNO9mWFT5h
4iBtGfTX2M7pvprKknobHSToppALvuz3l1Q/C+uSJl2LiQqgblc/okxlsbgl3d9T
NkK5VHRHM4BvLGi47P1b5AjDBt5DJe2GD3N3owR8PdJFVmphjXPXuRMlXrmtG8QP
rBak6Ych73+MyNgNk6jG6PYAHQOEYRJg5l4b1LtCL07DEmU/YR2u/12Tgskt0noN
ga0CVOUyQNVjqd0fuuX0
=Gp35
-----END PGP SIGNATURE-----

--Dc8jMHUlGGUuBUgj5qNNrSjdldh52ktax--

