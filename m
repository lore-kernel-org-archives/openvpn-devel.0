References: <20200401215052.3489613-1-wgh@...2548...>
 <79cc0c02-63cf-d668-e71b-1e4343228567@...1227...>
 <1de06e6d-72a0-97d0-b9aa-0be2ab716677@...2548...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bd48b82f-1baa-aec8-7f6a-d3f3853dfc9f@...1227...>
Date: Thu, 2 Apr 2020 16:25:13 +0200
MIME-Version: 1.0
In-Reply-To: <1de06e6d-72a0-97d0-b9aa-0be2ab716677@...2548...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MRwMWaSSyTRMkhVhT3QBoq0K5gszoijRU"
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Fix --crl-verify not loading
 multiple CRLs in one file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: WGH <wgh@...2548...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MRwMWaSSyTRMkhVhT3QBoq0K5gszoijRU
Content-Type: multipart/mixed; boundary="RNVerBtBAsHlnu4wWwAIE6XxtHZiaMBqz"

--RNVerBtBAsHlnu4wWwAIE6XxtHZiaMBqz
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>> Feature-ACK but some changes to the code required.
> Thank you for the feedback! How should I send a new patch version? As a r=
eply (with [PATCH v2]) to this thread, or as an independent message? I'm ne=
w to contributing patches through e-mail.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X509_CRL *crl =3D PEM_read_=
bio_X509_CRL(in, NULL, NULL, NULL);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (crl =3D=3D NULL)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uns=
igned long err =3D ERR_get_error();
>>
>> I think we should use ERR_peek_error here, so we do not drop the error
>> message if the error is something else.
>=20
> backend_tls_ctx_reload_crl doesn't return an error (as it's void), and it=
s caller never checks OpenSSL error stack. So as this function is, I think =
it should handle all errors itself, and leave the error stack clear.

Yes. But your patch throws that error code away. If there an error that
is not PEM_R_NO_START_LINE it will be silenty discarded. That is my
problem with using ERR_get_error there.

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!X509_STORE_add_crl(sto=
re, crl))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg=
(M_WARN, "CRL: cannot add %s to store", crl_file);
>>
>> Same here.
>=20
> I can do this, but at the same time I'd like to note that output

Yeah. I think I my comment about ERR_get vs ERR_peek was a bit
misleading. I wanted to say that you should only consume error there if
it is the header error.

> becomes worse:
>=20
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:04:24 2020 Diffie-Hellman initializ=
ed with 2048 bit key
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:04:24 2020 OpenSSL: error:0909006C:=
PEM routines:get_name:no start line
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:04:24 2020 OpenSSL: error:0908F066:=
PEM routines:get_header_and_data:bad end line
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:04:24 2020 CRL: cannot read CRL fro=
m file combined_crl.pem
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:04:24 2020 CRL: loaded 1 CRLs from =
file combined_crl.pem
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:04:24 2020 Failed to extract curve =
from certificate (UNDEF), using secp384r1 instead
>=20
> The first error comes god knows where from, and the second error is
> actually related to CRL (I corrupted the END X509 CRL line on purpose).
> It's hard to figure out what the errors printed by crypto_msg are
> actually related to.

That is a very recent regression. It should not have been there. See
this (not yet commited) fix: https://patchwork.openvpn.net/patch/1071/

After reviewing your patch and writing that fix, I also realised how
similar the two pieces of code are. You can probably almost copy and
paste the (new) tls_ctx_add_extra_certs to the crl loading function.


> Compare with how it was in current edition of the patch:
>=20
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:07:13 2020 Diffie-Hellman initializ=
ed with 2048 bit key
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:07:13 2020 OpenSSL: error:0909006C:=
PEM routines:get_name:no start line
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:07:13 2020 CRL: cannot read CRL fro=
m file combined_crl.pem: error:0908F066:PEM routines:get_header_and_data:ba=
d end line
> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:07:13 2020 CRL: loaded 1 CRLs from =
file combined_crl.pem
>=20


Yeah but *always* having a scary error that translates to "No more crls
found in the file" is not very user friendly since most people will not
understand that this is to be expected.

Arne


--RNVerBtBAsHlnu4wWwAIE6XxtHZiaMBqz--

--MRwMWaSSyTRMkhVhT3QBoq0K5gszoijRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6F9ckACgkQFRhsZwKx
RFRdbg//Qj1jehRHndCx2KSuQWUnBDI2MPDwWD4aUL2wzUQFml2/R+gq+gs+mqJ7
MdPUhcAdLnoZHcPqC1bcEMkiuFRlavC45MSQrmWQ/6m81HvMSSdWUsSh1yk+ezB3
V29fdLVH4B/eOKvcx7yH1yBNc68YFAQd4WHzfe1KRCAco1mlUk/KzQn6jLuTEQmB
FghEC0LK/fehuV3E7+dNJZIzvYCSpRgr9/Ou4SWKLNQPBItjEcrLZAHCsXdpnkRB
3mvxbskdsbZcGaOnd8cmmu7H15SPBbBamrlBU60l+StZ7Wt1pBASOtWAzYsfWh0Q
kpjN76RzBedHonwkv1B35K6LerSz2QJ0LXOwNg4bVFubZBCMYdRra8M+pzJUg2zq
eDrYO0zdmue/5RNOdnGDHLAiRZqUJwnK7wNK30Vi7ZkHxAQ+k8DEQd4TfBXhsMCb
5m2Jxw/By9Saz/lXLqW7cwArUQ+5OR0i3oae1zfT44BAqIJHzDqhLfdzC5q4JGZX
FWewAbFVIHMFfay1HuoSNb2fdzA9fMJZcEIzgQeLSmyBKHGeCjBdD2Tmjs/cIuCz
/mZ/mBXC96h9vY118O49vWBlcsIxyxcHRfNgiNH0MkY0ICE90eHx3S4Yv6wgwMwx
M8VAIcamS9ZCekYAcLXcm2kxgBbo5LXe97mCXR2dK92zz9A4HwU=
=ipL/
-----END PGP SIGNATURE-----

--MRwMWaSSyTRMkhVhT3QBoq0K5gszoijRU--

