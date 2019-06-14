References: <20190409143438.25348-1-soltys@...2503...>
 <20190409143438.25348-2-soltys@...2503...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <42b1cead-31e0-b382-9573-626517c89526@...1227...>
Date: Fri, 14 Jun 2019 12:15:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190409143438.25348-2-soltys@...2503...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uYcqwZeSoBjDj1L6bksJoqSvOBThhN3Vu"
Subject: Re: [Openvpn-devel] [PATCH 1/1] man: correct the description of
 --capath and --crl-verify regarding CRLs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michal Soltys <soltys@...2503...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uYcqwZeSoBjDj1L6bksJoqSvOBThhN3Vu
Content-Type: multipart/mixed; boundary="Tcwdv3oVn1XumsBlxdifkGXptSZen5yEe";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Michal Soltys <soltys@...2503...>, openvpn-devel@lists.sourceforge.net
Message-ID: <42b1cead-31e0-b382-9573-626517c89526@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] man: correct the description of
 --capath and --crl-verify regarding CRLs
References: <20190409143438.25348-1-soltys@...2503...>
 <20190409143438.25348-2-soltys@...2503...>
In-Reply-To: <20190409143438.25348-2-soltys@...2503...>

--Tcwdv3oVn1XumsBlxdifkGXptSZen5yEe
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.04.19 um 16:34 schrieb Michal Soltys:
> The man page states that when using --capath, the user is required to
> provide CRLs for CAs. This is not true and providing CRLs is optional -
> both in case of --capath as well as --crl-verify options. When relevant
> CRL is not found OpenVPN simply logs the warning in the logs while
> allowing the connection, e.g.:

I cannot get my OpenVPN to fail without CRLs, so it might be change in
OpenSSL or OpenVPN but this patch changes to documentation to reflect
current behaviour, so

Acked-By: Arne Schwabe <arne@...1227...>



--Tcwdv3oVn1XumsBlxdifkGXptSZen5yEe--

--uYcqwZeSoBjDj1L6bksJoqSvOBThhN3Vu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl0Dc9cACgkQFRhsZwKx
RFQ5rA/9Guq2sxUPz42IXdPh8kedSo1WNhdstsKucALYkzelGNiHSz925tiwrps1
Rl4nTODTF+aw5+7nbYmQUQ2ZwNWjZIZunQa9FnqLC9VF0cpFgqrXF2i8IkYm11mN
dErSa1JSX9QZYICvCKMsHElXw722Y6GqQifIV5ROWNTOnF/digwXIUPDOzkVkikR
py+2zWyA5c7tPxX0Kxnm0gonyL7REfSPUo6EmpdoRrkfMhbNj7f6QQ3QDoz457VX
BoswoiHP/INL+dgYezpMyJ5J8BNExPfgufHOSQSbAe4zw0NqsDl++XHySnwod2kr
wrbZIb1S8+cZRTQk4mkd6eE+tdz5weaCoedKJxa/yMvYl6azbcQGaolFVfnFtSY1
Nt2QCMSjlB7u/nP8P2iFuE/kLY+UH9h+rYTC28yBZBjfu2riW59ra48+PHfZbn5o
5gLh/N9l+9GXT/r5YEQ2/OND13c9RcYm0s4yVesEVIGRuI2Tk28C6k8FxYlF/Ijh
WJ0jB8z637Z6MfwOaqC3JPifPvXiepQC+m5+wIyxR2YHfrUD0OrVTX0lDaGAcCPz
tpKUZtv8ylmoMfMOXxpIbxb+ACFZK9KptGAR0AiTATEyQYgA7UIL4etypnnQRv+K
heq5jzbugY0Ja67nj6JhUUeGIswcY5bdgiHufvvYPxDtl7ZoH7c=
=/a2o
-----END PGP SIGNATURE-----

--uYcqwZeSoBjDj1L6bksJoqSvOBThhN3Vu--

