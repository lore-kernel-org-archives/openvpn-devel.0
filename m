References: <20200908111511.9271-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <13843e71-6707-bda4-1b5e-62c484ac9c26@...1227...>
Date: Tue, 8 Sep 2020 15:09:42 +0200
MIME-Version: 1.0
In-Reply-To: <20200908111511.9271-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ij2WN8sXOX4LwdjDsoYQOECdNgRevl8Xk"
Subject: Re: [Openvpn-devel] [PATCH] Document that --push-remove is
 generally more suitable than --push-reset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ij2WN8sXOX4LwdjDsoYQOECdNgRevl8Xk
Content-Type: multipart/mixed; boundary="dmiitf8pdG5HCMweGxmc6966dE5IM30bV"

--dmiitf8pdG5HCMweGxmc6966dE5IM30bV
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 08.09.20 um 13:15 schrieb Gert Doering:
> It's a long-standing and well-known problem that --push-reset removes
> "critical" options from the push list (like "topology subnet") which
> will then lead to non-working client configs.  This can not be
> reasonably fixed, because the list of "critical" options depends on
> overall server config.
>=20
> So just document the fact, and point people towards --push-remove as
> a more selective tool.
>

Acked-By: Arne Schwabe <arne@...1227...>


--dmiitf8pdG5HCMweGxmc6966dE5IM30bV--

--Ij2WN8sXOX4LwdjDsoYQOECdNgRevl8Xk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9XgpYACgkQFRhsZwKx
RFTwdA/+KKWsnh+tVP2NhF3KoGWY1/ZAXh6RTfnprH8Rf61hkA+RCi5uuU9Jz3SG
sz6c7xSX1M+6rQNvdPLc3QjMAC3RXbJ+9MhZ4IROrNbrpraNT779+nkwxKNFWcNc
cYJ517R26n+IhletuXNgeBgL25SkbEvq2aiAAKkzI2sk7f7Bj3pSCcuyg/Zp4nMS
5JPh2jzOyvUZTDh5BCQyXLXdXKAcf6ArXgYwPRE88Z6LiqsASc9MnIy1iM8FelWy
Efn+y/QGnVzz1duyxYTGEYesyaoTKlo6EZxIzf27sKCu2JCKI0fqktil8nNIUUqB
RAY31cxi2l3IrqWLcgQeUXiLAOYALQaygoDT/8HQq9Nu2XgEG5UwDBwVqUdOXM9R
8kp27SnGu0oRneZwoi2T4PGMMLXyLgMiYwy1AP5lKjtnealYoYKDDpXpqd6iYLFE
3KM/3XxTE4Vm6Xz4UePepNysiLzLLz0hYnXlXy/0+yzBRcbK+1CMo2XPjwbuKYp1
ZxMcdmzLatbiFAHsZZ0Me43x97G1ajxFaV38AiWrhOQ2SQyaxiFltqQ/YTU4U3eP
KkdOoZLQfMLYvguaMBfputnqHMG+cEKcpTFirYesVoTIyatbhzY9gbIPwE6lLYpQ
JPvoLqP1DB60FS/+Or6FCh7FDdi1OwDAllt/3HgXTx1NTtX83Lw=
=BTT1
-----END PGP SIGNATURE-----

--Ij2WN8sXOX4LwdjDsoYQOECdNgRevl8Xk--

