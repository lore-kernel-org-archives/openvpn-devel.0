Date: Tue, 17 Jul 2012 18:52:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120717165248.GZ22125@...1296...>
References: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
	<1342542316-32563-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vwmj/TXzE7NEH899"
Content-Disposition: inline
In-Reply-To: <1342542316-32563-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCHv2 2/2] don't treat socket related errors
	special anymore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--Vwmj/TXzE7NEH899
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 17, 2012 at 06:25:16PM +0200, Heiko Hund wrote:
> WSAGetLastError() is just a wrapper for GetLastError(). So, there's
> no need to differentiate between socket related and other errors.

ACK on current version.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Vwmj/TXzE7NEH899
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUAWYYKkuBuNlUUl1AQKB1wP/Z4vZg8std0+PCozrbt4n3Q7HM3rLvcxa
KfEbGmkr/arHGdicRdL4lgqE1sjJS/qX9JiVbT92RKef0ehiSTk711NVNKue05er
tJNeI3nQSj7nfVWiBEIzq7B4FyDe5Jl5zZn4O1BRuPDFbDlnUaEN+TQtuhkui72O
ylKCnd6bQUg=
=CP6N
-----END PGP SIGNATURE-----

--Vwmj/TXzE7NEH899--

