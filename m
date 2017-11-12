References: <ed338010-2918-fb1d-27e0-116712651b87@...2181...>
 <20171112172237.8285-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f9760ec2-2bfe-9ecc-012c-32addfab634c@...2181...>
Date: Mon, 13 Nov 2017 01:32:28 +0800
MIME-Version: 1.0
In-Reply-To: <20171112172237.8285-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Sd8pNIeLuRAqCeC6SKJadkRTBnctFOoTn"
Subject: Re: [Openvpn-devel] [PATCH v2] Use P_DATA_V2 for server->client
 packets too
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
--Sd8pNIeLuRAqCeC6SKJadkRTBnctFOoTn
Content-Type: multipart/mixed; boundary="mS5PgewaIqAm7ipe46VmVVk8jRe31Tp7N";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <f9760ec2-2bfe-9ecc-012c-32addfab634c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use P_DATA_V2 for server->client
 packets too
References: <ed338010-2918-fb1d-27e0-116712651b87@...2181...>
 <20171112172237.8285-1-steffan@...1856...>
In-Reply-To: <20171112172237.8285-1-steffan@...1856...>

--mS5PgewaIqAm7ipe46VmVVk8jRe31Tp7N
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/11/17 01:22, Steffan Karger wrote:
> P_DATA_V2 introduced the peer-id.  This allows clients to float, but as a
> side-effect 32-bit aligns the encrypted data.  That alignment improves
> performance particularly on cheaper/older CPUs.  So although servers don't
> actually have a peer-id, still use the V2 packet format (with a zero-id)
> for server->client traffic too.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>

Code looks good and this time I trust the tests performed by Steffan :)

Acked-by: Antonio Quartulli <a@...2181...>



--=20
Antonio Quartulli


--mS5PgewaIqAm7ipe46VmVVk8jRe31Tp7N--

--Sd8pNIeLuRAqCeC6SKJadkRTBnctFOoTn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloIhawACgkQB6U8WA7y
zXQgbBAAmNdUnx+hNBI5pGHP+eZPFqfD2tHopXlJetg5h1vKIDd/QbDitnqP9EVz
Hn+KVzz+Lc1NLX+cl+lmwFtgUnND2ppRMAksTy9Ehkbk+uZgmgn+7yX/mmY/LkcS
lxnT/dSkKtxcaYQ980Hc9jt+mnteCdLIyfGTgnPoLT85YBBqA9qf7WrnuQ+pcMsb
qDtEsTe+ooJWSnEGeI8t6jhvUoreSzYf9pWzCtUguS/M8v7pAzB1mEjzXuz0bngI
NFQ8mHiteqC/Jz2MXe407+auaxbb6NzCbeSt6h1JCg/uc24H/+HypUXUmxmhwOnD
G7cVhTJfDmiB2B34/bPfiNgD1t6svlEyoPMf5D89we6SA3i+fRq+vmAnXj1A2A3d
P+d/LPj3QYh+kBTnS6qIKx5ePK4ieE/DHGwZ9EMmx8fAK9F40HFCbY8T5ATbZiNe
fZEQOC/3jgqs9ntvLelGWLfk79ajMUtolX3UQoc/24n4eCTMTk3FHK18tXXVW/7v
ZthBFk5arsfyg/8Av4FxqQSRTmDy8kLEYuJYaDHxY7r9DZJ0VbXAnNBRve9crgF3
S5mfm5HQjdi1yiZCE4eOKqau4jpS8izZTunKLBv+D0FMQLhwbxqGlC3HxaEpKOnD
+xfdzr1ZjcjoVhWoLhvzpoxokq1x1XhtAUgCEHB0KTcogt7bP3M=
=Z9yk
-----END PGP SIGNATURE-----

--Sd8pNIeLuRAqCeC6SKJadkRTBnctFOoTn--

