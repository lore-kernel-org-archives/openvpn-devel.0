Date: Fri, 25 Apr 2014 20:28:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140425182803.GA16637@...1296...>
References: <1396001222-5033-1-git-send-email-arne@...1227...>
	<CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
	<20140330134619.GT16637@...1296...>
	<534F898A.3060607@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3zaowp3fdBRYvZvo"
Content-Disposition: inline
In-Reply-To: <534F898A.3060607@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix man page and OSCP script:
	tls_serial_{n} is decimal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--3zaowp3fdBRYvZvo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 17, 2014 at 01:58:02AM -0600, James Yonan wrote:
> If we keep the current behavior (PolarSSL serial numbers are hex while=20
> OpenSSL are decimal) then we should at least mark the serial number when=
=20
> it's hex, so client software can distinguish it.
>=20
> This very simple patch does that.

As discussed yesterday on the IRC meeting, NAK on this - Steffan promised
to send a patch that will change PolarSSL to provide decimal serial
numbers as well (*nudge*), so we're fully consistent.

> RFC 5280, published in 2008, decrees that serial numbers can be
> up to 20 bytes long, hence it is necessary to support SSL
> libraries that return the serial number as a hex string.

Emphasizing this again, don't use "%d" on serials :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3zaowp3fdBRYvZvo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1qpM6kuBuNlUUl1AQJqTAP/RWzoxqyt6Aj08mH3bKLatqQ5tft0aBE8
Mnb52eWhq6Pzylz1MAQxj4KYNLeAc4lbl6H/sNPC1rebBDuBtHuGyXSgIfF3IiYz
tGbNEjffcJBGEWGvUsn94FMBab2mwknKPi4DU5HqYoUj1p941I/h6flXLIVMX1dn
EcKsNDX3gkU=
=4c7k
-----END PGP SIGNATURE-----

--3zaowp3fdBRYvZvo--

