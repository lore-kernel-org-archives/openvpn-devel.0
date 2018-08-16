References: <20180815061240.5027-1-a@...2181...>
 <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
 <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
 <20180816113743.GV74536@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6b8bf9f1-9580-e3e1-46de-3958ad7cc8df@...2181...>
Date: Thu, 16 Aug 2018 20:05:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180816113743.GV74536@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9DJLgbDVJAZ06hFnxgA6p0iPEqjH2A8Qe"
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9DJLgbDVJAZ06hFnxgA6p0iPEqjH2A8Qe
Content-Type: multipart/mixed; boundary="77GPryBDpfRVvCUhWjbmeIuJRelu1OZgh";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: Matthias Andree <matthias.andree@...68...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6b8bf9f1-9580-e3e1-46de-3958ad7cc8df@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
References: <20180815061240.5027-1-a@...2181...>
 <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
 <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
 <20180816113743.GV74536@...1296...>
In-Reply-To: <20180816113743.GV74536@...1296...>

--77GPryBDpfRVvCUhWjbmeIuJRelu1OZgh
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/08/18 19:37, Gert Doering wrote:
>> Imho we should just get this patch through and then try to get rid of
>> the whole #ifdef PLUGIN_DEF_AUTH logic at once.
>=20
> If the idea is to get rid of PLUGIN_DEF_AUTH, then let's do so, not
> add extra #ifdef  :-)

Good! Let's focus on that then :)

>=20
>=20
> Anyway.  Trying to understand the logic here - PLUGIN_DEF_AUTH is always
> defined if ENABLE_DEF_AUTH is set, which seems to be the default setting.
>=20
> So, questions
>=20=20
>  - is there actually some benefit in --disable-def-auth?  code size,=20
>    performance, platform compatibility?
>=20
>  - why do we have it in the first place?
>=20

to me this feels like the classic pattern of "let's introduce this new
feature, but let's add a compile time option in case people have
troubles with it or don't want it for some reason".
I have seen this often also in newer code (like ovpn3).

>  - can we get rid of it?
>=20

Does any distro package openvpn with --disable-def-auth selected? If
not, I guess we can get rid of it.

But maybe David knows something we don't :-)


Cheers,



--=20
Antonio Quartulli


--77GPryBDpfRVvCUhWjbmeIuJRelu1OZgh--

--9DJLgbDVJAZ06hFnxgA6p0iPEqjH2A8Qe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlt1aJYACgkQB6U8WA7y
zXTxdQ//f8Dn5TvnKIOGAoO4+Vv7Zl9N5Z+PQXSebv68vtvYBWuvLCP514PEib3y
6olRahpjqKPXkgRZP2Uf68wDP0mrzSVWY02uNvNdz2Ktlp/phhscdQBcjP4dx+Tt
R1wYyCdCZJarMHFX9pRNle0o9OYm//Cvd3mFFFKrrEU0n/OLRrxhQraSotMj5WHr
vSGSR++Ce2HcXyr1k1Z58nucUsaDcdh4opzq3QDcwQKcBx1xW4vjjDLUhElteQDd
2mjHOyM7djHz7Izh0pcQ/4Hrgm05NQ1VyllovEOuySj6PYHUQJrEL/qzAdWszYTO
L/NnfA3V4R3cIEBFRIcNeTuR2oIWBo+kdc+3ixQL0+BGUNFbl/pp9tnCsoIWfz4F
Np+QHp/alG8E9lkrmEFmtAi0BbJ+nKN3Jz+TQa67ZQ1GQsqLSt18YTCh1Vxyajed
Q5Yuo5jPQ5cwiXQUUgMotytOTZI5VOeMjdftR6HJyIchpYw9vRL6kaxjvBC69riA
6FgKxBZoefc9+O3w3Nyo8VInvxkXPBQrB1rztQR9Uc5mMlneU5O72SZEIGr8hx3Q
/2fKrubR1zK2TrSyuU03EKQUhPOfFNSi0EkdlJYUTR1pNbQUw4PhJzL86wTVYF1Q
QhlUJhOXORz5PpJPQ9iaHB6OyXTUAFErQ/fVQ1aU0xl9g2dN4k4=
=plyq
-----END PGP SIGNATURE-----

--9DJLgbDVJAZ06hFnxgA6p0iPEqjH2A8Qe--

