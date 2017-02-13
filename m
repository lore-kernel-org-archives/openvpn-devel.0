References: <20170213201758.0a04ecfa@...1799...>
	<20170213193338.GV93896@...1296...> <20170213204947.10458306@...2245...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5b9e3a6f-f317-6b71-3cc9-7537c56b0137@...2080...>
Date: Mon, 13 Feb 2017 21:16:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170213204947.10458306@...2245...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OXHClecDXrK2JEbBfTrO4Rp6GuIf8VXo3"
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OXHClecDXrK2JEbBfTrO4Rp6GuIf8VXo3
Content-Type: multipart/mixed; boundary="XbQNhup2EIc0fWjiIKH1ABsbxUcqNvPu1";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <5b9e3a6f-f317-6b71-3cc9-7537c56b0137@...2080...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
References: <20170213201758.0a04ecfa@...1799...>
	<20170213193338.GV93896@...1296...> <20170213204947.10458306@...2245...>
In-Reply-To: <20170213204947.10458306@...2245...>

--XbQNhup2EIc0fWjiIKH1ABsbxUcqNvPu1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/02/17 20:50, Christian Hesse wrote:
> And a lot more has to be done... There's a long list of packages to be
> fixed. Sadly openssl developers do not care about ABI and API stability
> or compatibility. :(

I do understand the frustration ... but lets be fair too.  OpenSSL v1.1
is considered a major upgrade from v1.0 and they don't guarantee API/ABI
stability across major upgrades.

And the v1.1 API does indeed try to clean up a lot of the API mess and
confusions.  So it is a move in the right direction.  I attended an
OpenSSL v1.1 talk at devconf.cz in the end of January this year, I'll
try to dig up the slides from Tomas Mraz who had the talk.  It was quite
informative why it was needed to break several APIs in v1.1.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--XbQNhup2EIc0fWjiIKH1ABsbxUcqNvPu1--

--OXHClecDXrK2JEbBfTrO4Rp6GuIf8VXo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYohQnAAoJEIbPlEyWcf3yooEP/RSPcTkuq/JYc48ytgUcLkFo
TgpWOIDSjgxgDGSg0c0IieKxHsLKXOK1YWlEbNBQX1MeUmjKC6D8++zG1QNjMUGH
axoe2cIRz1Bamy9O80TZPlBOJa6ktmE6xdiUhBmxd+L02IOreHTqYQzYAwNeENj6
9aSUJQg0A57eUH7++WLMNglYGqXFhkodCnrr7pP23SaYiR1Oqh1cr8RLaeFfQQq1
FJzfrRixO0sgMhVvWEnPLejatT9XEF5oBZoJ/jiZryhl3tFGCqaevnRUvyY5ie1+
M2IAMKi5KaFCBEA7BxUzpoEbdzefwn0PKW05dkAU93nWBHIiXAHXNSinuhsWoFM6
D+kyim8+tvOppe2ATkcuQdQn7uLT9syw/bSY7HumBb5SrwCUK887KCEZZhXfb+a7
sgLNw6Sj3DuIdrtWba6O4XVFCpzuAOAKtJ8f+ywXOX7PdteK82Qmqyo9Gp2COOWK
hneIrsRBtYTrr50bwqFwY9Ot8s6DDX9F/1GTiqEzLG+ACE9kaUsSt+yilOZYi6FA
DGiasA8uQBb2cdcnmz/QsUzqkrvymT3i2ZsBFZHCz3fmpJYRfihUTtRGHguNoe2p
zoE95dU6kcFrt8SBUy3c+fNNHHwHNTzmY04CANPimBoR8vmn6LiECjBZPYckbihv
RMO5csky+aRuRjQjECr8
=I8fI
-----END PGP SIGNATURE-----

--OXHClecDXrK2JEbBfTrO4Rp6GuIf8VXo3--

