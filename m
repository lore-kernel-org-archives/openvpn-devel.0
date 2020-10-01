References: <0175aef6-8f4c-c482-12d7-189c677085ab@...2181...>
 <20200924091004.29065-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5104bc2f-95ac-3b5c-6246-77b1b3482d48@...1227...>
Date: Thu, 1 Oct 2020 16:50:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200924091004.29065-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u4WTnba05GMvY90Wk7Ker0n7Vd3RSTiDV"
Subject: Re: [Openvpn-devel] [PATCH v7] Selectively reformat too long lines
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u4WTnba05GMvY90Wk7Ker0n7Vd3RSTiDV
Content-Type: multipart/mixed; boundary="7XEqiBiql5olqjjpGEXtLieXktrscyVH9"

--7XEqiBiql5olqjjpGEXtLieXktrscyVH9
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 24.09.20 um 11:10 schrieb Vladislav Grishenko:
> Per https://community.openvpn.net/openvpn/wiki/CodeStyle the maximum line
> length is 80 characters. This patch allows to split upcoming changes into
> CodeStyle-conformant (w/o real code change) and more feature-specific.
> Upcoming changes adds new PROTO_AUTO, so existing proto_names array is
> reformatted as well.
>=20
> v7: prefer line breaks before long string parameters
>     reformat proto_names array
>=20

Acked-By: Arne Schwabe <arne@...1227...>

Also Antonio has no further concerns.




--7XEqiBiql5olqjjpGEXtLieXktrscyVH9--

--u4WTnba05GMvY90Wk7Ker0n7Vd3RSTiDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl917NMACgkQFRhsZwKx
RFT1OxAAnxYOXukjV7CtMNu9ZwFuq9dCmf7xiwD5lmB4dgEoFOCcGVxRXDTD7pkA
1J7oBi8DsLt/3o+9OmSh7XXinLvgVi3ovPSk122eYfQf2EBnmaAhrcPa0eWKtFmz
lP8F2zzQ5IjgBhT/c2yjk4YsQ6qKZ1kwk7cWCw97TSiK9HY1guqiCEl7VMUrxVZj
KFQ9nOD9KK3UBDvSkGjzaexNmN3fhDIW0gk97GB/Nw+KQX/QBzslrDUKrD0ubIJg
7OMH573OGmwqquTfMksa7TSXwRr/Zn5OxOyi4MeZ8gXc8qK19MHTTvZDyu2Gi6rW
p7sJIg5GEnq0AQGNt+MgxuU7VcrHyLIDdY4uIZS8s6+eZECQrQAwXipokrRRvT5n
ZZsBMMgjVBMHh03CjBAktvpFiEZ0ix2vasy9GPQKf+GXQmZ5Wf94dXX07VpWIAxY
4baux2PMz2TEXl7377t+V22ucEF6Ij40qW5x0n/Rjn6a+QlzZaJfo2piZ/TnTucE
1lCWP6pZYlCIl70fV+o3hnC1v19Vg+9/i9/WqTNmlZ6lHOyigAz3bkPytCIHaAXH
Ce/OsX8cMlE5b9WY3sR5CoSSDjVsmTIuRmFTjNdpr97cXDUxBmRL9ih/+Cxybk5x
wtcaOemt8LkxgDdHjceQvDbpUE34WQVSPwYOHyEp6kF2+eUkKYk=
=IWUO
-----END PGP SIGNATURE-----

--u4WTnba05GMvY90Wk7Ker0n7Vd3RSTiDV--

