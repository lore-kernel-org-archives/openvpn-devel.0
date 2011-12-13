Date: Tue, 13 Dec 2011 21:09:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111213200915.GP18948@...1296...>
References: <1323796440-15966-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Content-Disposition: inline
In-Reply-To: <1323796440-15966-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Only warn about non-tackled IPv6
	packets once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--v541l457l4DThMFo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 13, 2011 at 06:14:00PM +0100, David Sommerseth wrote:
> When using OpenVPN 2.2 on clients and server with Windows based
> clients, it will try to push IPv6 packets through the tunnel.  This
> causes the server log to be filled up with log entries like this:
>=20
>  Wed Jun 29 22:12:51 2011 username/1.2.3.4:56990 Need IPv6 code in mroute=
_extract_addr_from_packet
>=20
> This patch modifies this message to state that IPv6 packets are not
> tackled in tun mode, and prints it only once.

ACK.  I thought this was on my work plate, but I'm fine with your patch,
and that leaves me more time to work on other issues :)

thanks,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v541l457l4DThMFo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTuew66kuBuNlUUl1AQLHhAP7BOsEsJ6ic4foeGFHu0OFUvdSSexRohT5
Cz8Cr8c84AJ3KUb9lrQZmsJGuxVg218FtsP7IixyiaCEdn/S8g5Wav0sjdj4Uvpi
ABrqsM6LSOTw52o4KD0ZLtbWYcqPe4vwozDUUwWKDR/7cz10KgC/vHxPjseurnDn
yRStLhax6ow=
=M401
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--

