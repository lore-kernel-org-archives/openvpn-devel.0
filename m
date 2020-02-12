References: <20200206132103.15977-1-davids@...515...>
 <20200206132103.15977-4-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3d08526c-3abc-7f2f-cded-a17b3c8dd757@...1227...>
Date: Wed, 12 Feb 2020 13:44:37 +0100
MIME-Version: 1.0
In-Reply-To: <20200206132103.15977-4-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3WsCGit2PGMEjOWkXQyaCZk1mhsEyrTA1"
Subject: Re: [Openvpn-devel] [PATCH 3/4] Add gc_arena to struct argv to save
 allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3WsCGit2PGMEjOWkXQyaCZk1mhsEyrTA1
Content-Type: multipart/mixed; boundary="nUXTsXK8GPiPDx2MQZ9YNbWZ8WVwq6lLQ"

--nUXTsXK8GPiPDx2MQZ9YNbWZ8WVwq6lLQ
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 06.02.20 um 14:21 schrieb David Sommerseth:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> With the private gc_arena we do not have to allocate the strings
> found during parsing again, since we know the arena they are
> allocated in is valid as long as the argv vector is.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> Signed-off-by: David Sommerseth <davids@...515...>

Acked-By: Arne Schwabe <arne@...1227...>

I don't feel it is really necessary but it is slight improvement and
this been too many revisions already, so get it in.




--nUXTsXK8GPiPDx2MQZ9YNbWZ8WVwq6lLQ--

--3WsCGit2PGMEjOWkXQyaCZk1mhsEyrTA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5D8zUACgkQFRhsZwKx
RFSAlg//W+p8qEh4grs23WVtu3l90eWVNxgPKkZO6Zrcn5kdnsrXwIbdpiofqEb2
rEHVHkNsZQEH5j9BM7mWsEiciMsGpl7MQlcwPYEES+SP20CeevXBZyl5zOdSGQz1
oiQWl5EL3fhWNCYMA+YQCAR2Q9fn/w9Bc5YPYrJGzKGn/oMtunIKzarIzHktkS5u
Cg2Zma004ZQcwNGtkKLnvXlogY1U3pNhXp0x3Jm9jBLFXo3DRW+GimGawH2KvPvN
cLQ+rl7ac+Xh1rmfn4tCjqp9hGiV/9kUY2It+G8Ppe53wLBlv/pP8nnVcEtJ0hW7
wkB9LcJVj5ps6iNOx8vy/oDv47S2QZOIE7e98G61CNrI042ca8GlDV6bLg6+EGPh
tNz9TX0lx4cj30Jq8zkM4eRRQjhFw5lVBjTsJeR3kx16P5b42HSRS9uBCZCprRT9
xNQ6sd3hIZZ3y/u5JLm2sy39tV1d84skJzcxcu61pbkeVkyabBxXniuIt4/HbyLd
ONZvDSDdigG6SThzJteUYOkcWk89WkcAkBnOGjL88ovsTCrk0zKvpDHKVUrFtguP
duXWwJHNtm7+Zz+aGua2yHVyliiaqUj++b/SU9kQcuCsppnZCwzcgaj8/5K+lCU4
rl1OeCityrq+IbdxUNKuR4WDwujv7VeCTvXlIuq1zQumnuvlbSc=
=MO62
-----END PGP SIGNATURE-----

--3WsCGit2PGMEjOWkXQyaCZk1mhsEyrTA1--

