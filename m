References: <98f65e22-a66c-aeea-f705-ad5a0f7a2e28@...1227...>
 <20200814171204.22289-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <18c95bb9-408c-a608-fd2c-9f8b5f6f88eb@...1227...>
Date: Fri, 14 Aug 2020 19:35:24 +0200
MIME-Version: 1.0
In-Reply-To: <20200814171204.22289-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Tf06XGF0MI9viPKH9yKyLGZghNIr17jGA"
Subject: Re: [Openvpn-devel] [PATCH v2] Allow management to kill client
 instances by CN wildcard
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
--Tf06XGF0MI9viPKH9yKyLGZghNIr17jGA
Content-Type: multipart/mixed; boundary="xn3cov7iqnV9FyGA66WYxaWULOCG3lse8"

--xn3cov7iqnV9FyGA66WYxaWULOCG3lse8
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.08.20 um 19:12 schrieb Vladislav Grishenko:
> In case of some permanent part of common name (ex. domain) and/or
> long complex common name consisting of multiple x509 fields, it's
> handly to kill client instances via management interface with just
> prefix of common name, not by exact match only.
>=20
> Patch allows to use asterisk as wildcard placeholder in the last
> trailing symbol of kill command parameter.
> Single asterisk - empty prefix would be too greedy and can be too
> harmful, therefore not allowed. Wildcards in the middle of
> parameter string are not supported to keep the the things simple at the m=
oment.
>=20
> v2: fine tune comments
>

Thanks for v2,

Acked-By; Arne Schwabe <arne@...1227...>


--xn3cov7iqnV9FyGA66WYxaWULOCG3lse8--

--Tf06XGF0MI9viPKH9yKyLGZghNIr17jGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl82y10ACgkQFRhsZwKx
RFS+wRAAqx7ZU6KmhJkmWCjDpgJ1ZEqcz7vhJNaZ7KTgC0z7mWMAtQ/dI4SDR5Xj
8xWCyx+NVVDu8udmFdTM5K5ghPSYqQpc4isSYevVeIqtLq+AlFO+RUmevnd2HTte
1NsXcAaQi0H/mDHweTa35HdLq+nIBhxTKqOAAFHh8WWZz+3MLCQ4A9OCztoK3sze
/c6mQw8wjSfJ7GRQP5dzjtMAlhkwGz5IoMWZCZTYF8vyQGa3kyT79t3WfVcKJaYV
0sqQpggWN7JZI7TkyQZzwULxQyuuwwjV5g19q7fz7EAiU2eMLm78xunbb9Kz5kRW
NQE30NsfdZvqR6FXL8JgEfeQAHHRwQ/ciSfTu7N1ykcmngwiVbVBCOIw7GscyRcl
5k+SGNspPOcjhFUY0ieS1cGhmHPAcV6gTXjmKo6bCPt1249Qt3AG1soEVNEmZtjv
UpKWxKdT4Solt1bvP+Mmvon/QHSkQuniG8FD5mP5JqDFGJVu27O1dIUcVT2XA3PE
MjRknbpWfpQ54BTZEzvxmJ8wg/ahAN15j5JQhAyVeuoxSXpHGH6rcPngs1tU0sed
3qQB9ifU5r7bjNlHJ/rE5GxeTF+bNK8MWsn2w+xSG4Cod5HZLo/KJemvXF5F872A
njwvEzzguHBaTdcg+clfEu/Mmfuo1GyF+60NyA+2wVefuljcAQA=
=nV5u
-----END PGP SIGNATURE-----

--Tf06XGF0MI9viPKH9yKyLGZghNIr17jGA--

