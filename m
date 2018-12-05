From: Arne Schwabe <arne@...1227...>
References: <20181007215837.489-1-arne@...1227...>
 <20181031165222.5997-1-arne@...1227...>
 <CAA1Abx+ghos2h8qatMhon+ojAUX18MKTbz+W_3T4TfVOGXLTww@...278...>
Message-ID: <5b5ee028-92f9-3f0a-f50d-95d6280b8792@...1227...>
Date: Wed, 5 Dec 2018 15:09:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAA1Abx+ghos2h8qatMhon+ojAUX18MKTbz+W_3T4TfVOGXLTww@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rqajDqYWMGgqiLLHlmQgw6CwKclrWWVGA"
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Make tls_version_max return the
 actual maximum version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rqajDqYWMGgqiLLHlmQgw6CwKclrWWVGA
Content-Type: multipart/mixed; boundary="MJICHegQaV135yvkg1FdgsGfuEa6Clrxh";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Steffan Karger <steffan@...1856...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <5b5ee028-92f9-3f0a-f50d-95d6280b8792@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Make tls_version_max return the
 actual maximum version
References: <20181007215837.489-1-arne@...1227...>
 <20181031165222.5997-1-arne@...1227...>
 <CAA1Abx+ghos2h8qatMhon+ojAUX18MKTbz+W_3T4TfVOGXLTww@...278...>
In-Reply-To: <CAA1Abx+ghos2h8qatMhon+ojAUX18MKTbz+W_3T4TfVOGXLTww@...278...>

--MJICHegQaV135yvkg1FdgsGfuEa6Clrxh
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 05.12.18 um 11:51 schrieb Steffan Karger:
> Hi,
>=20
> On Wed, 31 Oct 2018 at 17:53, Arne Schwabe <arne@...1227...> wrote:
>> Before OpenSSL 1.1.1 there could be no mismatch between
>> compiled and actual OpenSSL version. With OpenSSL 1.1.1 we need
>> runtime detection to detect the actual best TLS version supported.
>>
>> Allowing this runtime detection also allows removing some of the
>> TLS 1.3/OpenSSL 1.1.1 #ifdefs
>>
>> Without this patch tls-min-version 1.3 or-highest will actually
>> downgrade to TLS 1.3 in the "compiled with 1.1.0 and linked against
>> 1.1.1" scenario.
>=20
> "Downgrade to TLS 1.2", I guess?
>=20
> But more fundamental: do want to support runtime-upgrading the TLS
> library? Are we sure that this is the only place where this will
> create unexpected behaviour? Does it even make sense to upgrade a
> dependency to a version that contains all sorts of API/ABI changes and
> then expect that you do not have to recompile? Honest questions; I
> don't understand why one would want or do this.

I think on some installation, especially when the user compiled OpenVPN
him/herself, we just need to live with the fact that the OpenSSL library
got upgraded from OpenSSL 1.1.0 to OpenSSL 1.1.1.

But one art of decting the newer library here is that we can bail out on
some of the corner cases instead of continuing, like refusing external
auth if the OpenSSL libary is too new.

I still think is an unsupported scenario and we might add an warning
message aka like

"Detected OpenSSL 1.1.1 but compiled against OpenSSL 1.1.0, recompile to
use all OpenSSL 1.1.1 features"

Arne




--MJICHegQaV135yvkg1FdgsGfuEa6Clrxh--

--rqajDqYWMGgqiLLHlmQgw6CwKclrWWVGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlwH3BoACgkQFRhsZwKx
RFRSaRAArvP3z9W6SNVyGgB3DOy18Aaa+Ag3TdXFrTKdtEzrVDq2PEKVt60KEzDN
V2rVI5HYZf+QBvqc0CZohbziIeUJAqIXugm5n9/BsSTgwFpW9yuf1MJoosnaxGz2
RE+o0tjGRY9PILiK8EgkjfoX1ITdid3yBSV0uSfQaJ4kxXMIKyXsUAYTekDEt1o2
rMBUhAuyiLvM5K10LHm2oZ/eqbsOLGsdgqcIQ10zrcNxH2PhyZXkn3oOqqjFUnrp
SBIXQA222bhBsyCpyrmxYWIb65Oxs43jgA9TWHPIFelOrSeRDLzS8U3r5+NRnXaM
uc+s5GWA3VwD46ZganTEvErzywY2LoL3I2EYa6ppF1QoFgrLqJtEYT+qHFwOdWw8
wBnWwOPPHlHZSAdIr2cDB8jJucwWqjl/RiH4WqUMYQAFGUMEuiuXtFpeHmxAPhIm
E9lEox4v1eJHVDN6SsS3L9dE1OA1oh+B4ThqGUE4x4LwHFGjuGppPiDqq2wRyHzM
Yp77Rs8tcXBB3f1+kUPztcEopnvKFWifvnoRMUNtDJuanKWIkER8etGezbxB1Gtl
iAK7dm64HySXcLu7c+c9KJYNt9zb1OUZN4bBnVb0jofLdBI93yPmQBWrX7rMIMQF
OxHVshX/mDEOtuRAMvtWLYtJwgs7/1x8hvqo3YJ4bg+1uGdguR0=
=Ex56
-----END PGP SIGNATURE-----

--rqajDqYWMGgqiLLHlmQgw6CwKclrWWVGA--

