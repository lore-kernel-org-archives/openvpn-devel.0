References: <20161026120631.15946-1-a@...2181...>
	<30247351-24a3-4314-40c5-bfb5e82f84b0@...1435...>
	<20161026124019.GE8925@...2182...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <2f3f0e84-38f8-3940-d9d5-5e8c99c10696@...1435...>
Date: Wed, 26 Oct 2016 14:48:43 +0200
MIME-Version: 1.0
In-Reply-To: <20161026124019.GE8925@...2182...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g0SpKnMRj1i89vAfaGc7bKL2rSI5fjGbR"
Subject: Re: [Openvpn-devel] [PATCH] don't mix settings when crl-verify
 option appears more than once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--g0SpKnMRj1i89vAfaGc7bKL2rSI5fjGbR
Content-Type: multipart/mixed; boundary="V7HduH0MJQXDbnUrRfeVIBK1sUpmDqDhO";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <2f3f0e84-38f8-3940-d9d5-5e8c99c10696@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] don't mix settings when crl-verify option
	appears more than once
References: <20161026120631.15946-1-a@...2181...>
	<30247351-24a3-4314-40c5-bfb5e82f84b0@...1435...>
	<20161026124019.GE8925@...2182...>
In-Reply-To: <20161026124019.GE8925@...2182...>

--V7HduH0MJQXDbnUrRfeVIBK1sUpmDqDhO
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 26-10-16 14:40, Antonio Quartulli wrote:
> I was planning to do the rest of the refactoring in a second patch.
>=20
> At this point I think it would make sense to reject this patch and wait f=
or a
> full patchset set where I will:
>=20
> 1) "fix" every inline option to be sure that we don't carry around bogus
> settings
> 2) switch any *_inline field to bool
> 3) refactor the code to avoid strcmp()

Yes, consider your patch rejected ;)

For me the proposed changes would be fine as a single patch - this is
strongly related and not very complex.  In particular 2 and 3 should
probably go together.

-Steffan



--V7HduH0MJQXDbnUrRfeVIBK1sUpmDqDhO--

--g0SpKnMRj1i89vAfaGc7bKL2rSI5fjGbR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEKYwAAoJEEEwndWOY1w5QYYH/iRGBY/Sa8ogIDLJddNC565q
xcjOmcteZ7VYaSwv+J8Jhq9FrIv92/wAD7BlVpVkwcUiwkdeNLnlrdYWBOCThnPr
Hp5uRvR9DWqcdtgVF4ED8MhD9dtBnXCM9GLOr7KPO0u8h2MYHm8cuI0/o5CC7M9U
QlNdBLKdRnS/ugHbVFq9jR3RoI2zWkR215EIos8juZMYmMMeS2yfzajuCSHZZ6K3
DeTiMh/J0K85Yf9xt8G/id6hVtW+lT2NtM3n++cYHXXQTxg1D7Bfna5EBXSMd1MJ
YjWMRRnSsZp9afCyBAsoaIUT90gdxNxAXK3t1b0CScOvaFbuoVB1TTh6OWx1O2k=
=IIsz
-----END PGP SIGNATURE-----

--g0SpKnMRj1i89vAfaGc7bKL2rSI5fjGbR--

