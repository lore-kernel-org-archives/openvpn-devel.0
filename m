References: <20200725235023.22441-1-arne@...1227...>
 <202007261340.06QDeI0c097796@...2054...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <35a88fe9-9f72-983a-97ec-ee554bec91c1@...1227...>
Date: Sun, 26 Jul 2020 16:19:21 +0200
MIME-Version: 1.0
In-Reply-To: <202007261340.06QDeI0c097796@...2054...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Jv1MhoSrpZ8tmrmSw8GbpTGw0JKyHAgwS"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Include utun device number
 in utun error messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jv1MhoSrpZ8tmrmSw8GbpTGw0JKyHAgwS
Content-Type: multipart/mixed; boundary="F736GEPy7BKGaU3hR0N1yvpmNGxT2gtB7"

--F736GEPy7BKGaU3hR0N1yvpmNGxT2gtB7
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 26.07.20 um 15:40 schrieb Gert Doering:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> I've left out the stray uncrustify fixes - not that I disagree with
> them, but they should go to their own patch.  Sorry for not cleaning
> that up while merging the corresponding patch.
>=20
> Code change looks good.  Not tested anything (only test compiled on MacOS=
).
>=20
> I wonder if we could just skip print the error message for this
> particular call (connect()) if the return is EBUSY?  Or maybe
> "skip if utunnumber < 10 && EBUSY"?
>=20

since you can also specify that you want utun9 that would break that.
More realistically we should just skip the interfaces that are already
present in the system.  Baiscally if 'does interface utunX exist?' =3D>
skip on trying the first working one.

Arne


--F736GEPy7BKGaU3hR0N1yvpmNGxT2gtB7--

--Jv1MhoSrpZ8tmrmSw8GbpTGw0JKyHAgwS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8dkOoACgkQFRhsZwKx
RFQWzg/8C+SG/RvqyrFa4JlHr2eZc3ayFSxNi3SzlhST6BsCZNLxQecT6JBw4CTZ
IP5h0kGHMWgal/NafRpNTJWxZNH4N056/21EebweCPkQzTqTgjN6EUGc/I+bCBi9
DYvdVpmN9obtccdUJqxcSfCyt1fadCAUBEdfl/7VhZGasLUfBTeE2jYDolrYXqOe
RffoWkxgx4APOIEOClCNcPT5A7tPF5SK7asXz4nzmJfZVCYJQYfI/ARyS6KIYwGa
lg78PZnlM5X6TA7iiwT3X6UN77dn+RqbV4lDllEhMls1SkbeZ6FduYAQEh6nnst3
Dnin7WZ2EF/529lh1p9+z00EwE71RqPEYe2XSmETcwFuXkUUHDIzv6eJCJvfhcMK
8E/wSaD6xF8cROglANek4vTySn1tOlet3V/tiw86W2x4iVwoG93CbCd/YPvbvQLK
DzLAn1CzLfptDDmcQ9AlzpjguYknQ6sW9tlO4E9Ywlog6Np7Rtx45CwA6L+5nVch
v946RaM6yhHCITBYR0TyxBpr5rgzpQk3dqVgAeVYagF9kTxNSBJfS41YYgaNlZAp
BJLausgVtHe7kPHKZE4D/QplavEsKF6Yqe1og/57+X5osN0c4rDCRPr/eIdlJMnf
n15OqCcPOHA//WzFVU3PLHM+y50ULN2FD6EW68a+ZhNtOYocYEA=
=NlTM
-----END PGP SIGNATURE-----

--Jv1MhoSrpZ8tmrmSw8GbpTGw0JKyHAgwS--

