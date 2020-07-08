References: <20200707121615.15736-1-arne@...1227...>
 <20200707121615.15736-4-arne@...1227...>
 <E1jt72j-0005K4-BF@...2487...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9a266f84-70c4-6e54-3af4-96982d16709d@...1227...>
Date: Wed, 8 Jul 2020 15:31:25 +0200
MIME-Version: 1.0
In-Reply-To: <E1jt72j-0005K4-BF@...2487...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wp1XyzWmXXfL6URhGFRZ5nHruC0ZqBYWj"
Subject: Re: [Openvpn-devel] [PATCH 2/3] Cleanup: Remove unused code of old
 poor man's NCP.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wp1XyzWmXXfL6URhGFRZ5nHruC0ZqBYWj
Content-Type: multipart/mixed; boundary="LZux6dsqO7SET85DAOjN5vKUVMiEKCEPp"

--LZux6dsqO7SET85DAOjN5vKUVMiEKCEPp
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 08.07.20 um 12:10 schrieb Steffan Karger:
> Hi,
>=20
> As discusses in #openvpn-devel on IRC, this patch breaks interop with
> clients that don't pull, but that will be restored in a follow-up
> refactoring (before 2.5 rc1). I can live with that, but I think this
> should be mentioned in the commit message.

I can fix that by reordering the commits but I will that this moves
generation of keys for this corner case.

Arne



--LZux6dsqO7SET85DAOjN5vKUVMiEKCEPp--

--wp1XyzWmXXfL6URhGFRZ5nHruC0ZqBYWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8Fyq0ACgkQFRhsZwKx
RFQH2g/9FuGVw0uS9KwycV4KxrwWp+zFs68Hpr8nPkCxoWKVCj8dBOOlQTegq+tc
O93guD4UuoD47tnss9A5lXXyFgK+1K8BUAkkdS1MPir8G9gabTxtNw/veIH3rqBv
tCWeVy50e75xTr/kEmbFQcwtOpDS2K2YTZ+A/ZlDCYC8o8ug4v6U4Bms03HY1qTs
0lgTeiRS2CKMH8LrDePIPu1M4ojum6k53tgjQRhw4oZwHOMRMDcObay1v0faqoOD
t5ay6KQVR1/oOsjFsl8kwrzD0q/jjy5gs7lxtjzfXmfyP6KwpjjakXcNs9vINCCX
Xq5jX+AJAs4FWFYoL//gt7F8GG9zZViQZVafROGANVf7WoBQJVixWWKC0HvnRnXb
kiWbX5ynOFXSAFH8RWbg+yku0+eROrNBkgNCRPy6tsjQErAqfyShZ7dDmcYUXVjE
CGmgZGChmn1g8h7ClngSv+ojQDFQuPBDwkpyno38utuiAgq7bJ/yuZm7XXCpc4Qw
5M3x2s7DGFMLkazNhfm06+wz83kHIXDs0t2HFkMsOTUG67OWKb3zc7q7T7CquhyD
x8IvdygZNXQqgMFsIOL+eQx4LjLQow4BBPDI/T6/eSydedQry2XkRnD5XMPMBDg4
v/MsZDltoSOWaRufncUEt0+Kawd3uKlsuxi6J6Cy5d7c3kndv6U=
=0RGv
-----END PGP SIGNATURE-----

--wp1XyzWmXXfL6URhGFRZ5nHruC0ZqBYWj--

