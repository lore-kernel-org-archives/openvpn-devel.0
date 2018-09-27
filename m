References: <20180926192706.29460-1-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e466521c-dc45-a780-0264-4e827236d250@...1227...>
Date: Thu, 27 Sep 2018 18:39:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180926192706.29460-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bKo4ZM2in2cRf8Tru9tecgzi3VWg2vROH"
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in
 SSL_CTX_use_certificate
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
--bKo4ZM2in2cRf8Tru9tecgzi3VWg2vROH
Content-Type: multipart/mixed; boundary="XNWDSvu7xsF2Vl2jGmwDUsdBMgYImKTUY";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e466521c-dc45-a780-0264-4e827236d250@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in
 SSL_CTX_use_certificate
References: <20180926192706.29460-1-steffan@...1856...>
In-Reply-To: <20180926192706.29460-1-steffan@...1856...>

--XNWDSvu7xsF2Vl2jGmwDUsdBMgYImKTUY
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 26.09.18 um 21:27 schrieb Steffan Karger:
> Commit 98bfeeb4 introduced a memory leak in SSL_CTX_use_certificate by
> removing the "if(x509) { ... }" bit while not changing the
> "else if(x) {}" right after to an "if(x) {}".

Hmpf, I should have spotted that.

Acked-By: Arne Schwabe <arne@...1227...>

Arne


--XNWDSvu7xsF2Vl2jGmwDUsdBMgYImKTUY--

--bKo4ZM2in2cRf8Tru9tecgzi3VWg2vROH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQReA6r9qqhQzJnD/WZ7z5ww1LjNFwUCW60HvAAKCRB7z5ww1LjN
FzCoAJ9QKQyc3Og5eIhRrH4STNUev84WCwCdHAyzAtskggVi7ZJO8VJmfiy23PQ=
=J/ee
-----END PGP SIGNATURE-----

--bKo4ZM2in2cRf8Tru9tecgzi3VWg2vROH--

