Date: Tue, 17 Nov 2015 14:03:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151117130353.GO24952@...1296...>
References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XLWMkxR+mZNQ4WTO"
Content-Disposition: inline
In-Reply-To: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Pellegrin <chripell@...410...>
Cc: openvpn-devel@lists.sourceforge.net

--XLWMkxR+mZNQ4WTO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 17, 2015 at 12:32:16PM +0000, Christian Pellegrin wrote:
> Looks better than just adding AF_UNSPEC case but I noted many other
> FIXMEs about AF_UNSPEC that could be solved this way. So let me know
> if there is any reason to not use the ai_family field (and just add
> the AF_UNSPEC case in set_mtu_discovery)

Why are you seeing AF_UNSPEC there?  This is actually more interesting
to me right now than debating possible avenues to fix this :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XLWMkxR+mZNQ4WTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVksluKkuBuNlUUl1AQItLgP/cPeGBTth3KShioMMblBq9EcG8Az9Z2EO
9xpcXetXQC+6dVvBcwTIWwYplafx/6iMgsCrLI0wFTyxD+pc4wpeSR5+o1ykMWIT
BR34ZPQFtbcXgPqqalZsq6WSFdG2NFMNcTZGJ77k88PRoyl0up6QUEKVLc96TCxx
llUOmsVQTO4=
=MtXC
-----END PGP SIGNATURE-----

--XLWMkxR+mZNQ4WTO--

