References: <20181008214923.11058-3-arne@...1227...>
 <20181010152918.27762-1-arne@...1227...>
 <20200811095850.GG75094@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <063e94d6-2e6a-6f6d-9c2b-b3e9fdb3af70@...1227...>
Date: Tue, 11 Aug 2020 13:04:13 +0200
MIME-Version: 1.0
In-Reply-To: <20200811095850.GG75094@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9u09hE05ro1wqXc09hVFsg2qCbBsiEtyU"
Subject: Re: [Openvpn-devel] [PATCH v3 3/3] Implement the nopadding option
 to management-external-key for mbed TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9u09hE05ro1wqXc09hVFsg2qCbBsiEtyU
Content-Type: multipart/mixed; boundary="ygYVau1ASy7YQ60SHZsVLTGMwhye90LQ5"

--ygYVau1ASy7YQ60SHZsVLTGMwhye90LQ5
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 11.08.20 um 11:58 schrieb Gert Doering:
> Hi,
>=20
> On Wed, Oct 10, 2018 at 05:29:18PM +0200, Arne Schwabe wrote:
>> Although mbed TLS does not have a TLS 1.3 API yet and we do not really
>> know how mbed TLS will handle querying for TLS 1.3 signatures, being
>> able to use the same API with OpenSSL and mbed TLS is a nice feature.
>>
>> Since mbed TLS does not expose a way to do pkcs1 padding, copy the
>> trimmed down version of the pkcs1 copy to the OpenVPN source code.
>=20
> What's the state of this patch?
>=20
> The other parts (management-external-key, TLS 1.3, adjusted padding)
> have gone in, but this one got left dangling.
>=20

Let's just close it for now. When mbed TLS gets TLS 1.3 support, we can
revisit this.

Arne


--ygYVau1ASy7YQ60SHZsVLTGMwhye90LQ5--

--9u09hE05ro1wqXc09hVFsg2qCbBsiEtyU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8yey0ACgkQFRhsZwKx
RFSXTA//YrzMk4GW07eDdCKqX4NYhoxL60AsId8aOTQH1u6AZ1q2sQQ4fVbbSOlk
ZA9kARBt3krCHQW4Mr4OIf03XbvT+2UQMCBHnJzdM3/BKWzrQcxHPsWiAxQLi3mC
1/KuPyWb5TaWVWtKxtiQ+SLvrPO4MV+Qpkun3oGusFxMoKDiqei5AkyDffreGfzQ
fxE4egVwS1EKCT3i5NinPhj/1OxXaErtz+5FF+nvYIrwNrGsy0MTKFzPqq5//wSk
g9q6iG2y248eQ811C5DTIMvZqq63W9x+nuanMyUyQz1wTrHWncoeoALE772uIzdG
cdmUrvmsM+kdUkjBWsGoQv8lvcKbukrBiXxkQeirP2RsXVm+MoSF5CBlNMZud4lo
5MIpZRXbJz/j5ytmCqhprcTRNo15apIE6bFKKFCyDm3hfPx+3nowMtq0Frh+2cEL
eWW4xee4paL/CedVPLL0qP8/KsqP91HXaKIecrWXo+hlbshfEeNBJE6b1/as9Wds
Wx2MoJ/3RdsFLIX/9n9myexOmuITCf0lYq4rmV4T7J6gWVK3CniWUK2Fhg2kAZSz
14gcbhygnzrQPaqEeGxpKQAzGvBWezmGJoI+VRlU+rG0MHO3tchgM40XXU+6kslp
ogHAsd1czltAf1AzRxRSRCiGWnlNrpGb1LLDUeBzdEl5oth98sg=
=o+z/
-----END PGP SIGNATURE-----

--9u09hE05ro1wqXc09hVFsg2qCbBsiEtyU--

