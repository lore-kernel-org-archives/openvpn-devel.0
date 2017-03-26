Date: Sun, 26 Mar 2017 12:32:13 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170326043213.GH974@...2182...>
References: <1490461418-30154-1-git-send-email-chipitsine@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
In-Reply-To: <1490461418-30154-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] v2: resolve format string warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, Mar 25, 2017 at 10:03:38PM +0500, Ilya Shipitsin wrote:
> [src/openvpn/options.c:1163]: (warning) %x in format string (no. 1) requi=
res 'unsigned int *' but the argument type is 'signed int *'.
> [src/openvpn/route.c:3187]: (warning) %d in format string (no. 5) require=
s 'int *' but the argument type is 'unsigned int *'.
>=20
> v2: use "uint8_t" in options.c, thanks to Gert Doering

just my 2 cents here, but comments like the one above ("v2: ......") should=
 go
after the "---" marker, because this way it does not get included in the git
message when committed in the repository.

version comments are useful during review to explain what was changed, but =
not
useful to the git history per se.

> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---

vX: change X, Y and Z.



Again, this is nothing important, but I thought it could be useful to share.

Cheers,


--=20
Antonio Quartulli

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbWDi87MfnL20Ye22noXXMbYnI6wFAljXREoACgkQnoXXMbYn
I6yymA/9HIsqNTec6Txk5FYZlMsZzvEd8+dpkQsICmAHF/ety7ZqxnHOmF4BlEhQ
ofuice1CipLoyIci+U5e6DsvoC3wfupLtYXVd9asEJMThsan8A0jZK8Y8FB5NMWu
ZeeKMMauL+WPjWnwuv0cUiJS/UYwcRjzYFvrA/EpaZ9oAetyF2eK9skihhrskz5J
PcLeudnbCVCVzMXp6eM2irHqU5MyAN/P+Q6xcB0T8OhoGoGyWTI5ZmPdahQm2Tzt
NF3vzrjiIEZtTKZEomeqMERX/184QmJzX4DeYbrlTesViMfpnf5PDUhgsLSv/FLy
WugR1sUgfkovKIfS2vrMC1iL0WmQNqzcEo8v7GqxdQW8mKqTmcAGjZLXVE+J1duD
xNDID5vF+LY55H2KFKzqd3NzpeP2oL1qOMo5FrGoDc95d3HTZ1yP8iT0q7Pkn6h5
O6dK3/mJ8oIdqAVGKq1HPxFTXfvzuPh+BQ/y5w5xeE2t/UJttal/e8Se8uPUtH0A
Zgil1Pr+2FNUb0rcXgFMtuXAyrgOJKCO3sRGzhlf9A/W4U7p5dIfRU1HK9/D9D8I
DfdJbDZZaGfDvoWletzhVIOffgbBeJB65z0Je8LpWoLGCghSaBD24CWzCv/mEVjm
Acrz5ud1GHkxNrwtmUkEBIhvwbCNBRuIxatjzbUnpMj7N6z2+8c=
=FNvn
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--

