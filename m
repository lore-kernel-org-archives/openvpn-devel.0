Date: Mon, 1 Apr 2013 13:12:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130401111231.GD428@...1296...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <1364762609-30320-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add support of utun devices under Mac
	OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 31, 2013 at 10:43:29PM +0200, Arne Schwabe wrote:
> Mac OS X 10.7+ natively supports tun devices (called utun). The "standard=
" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko =
do not work together).
>=20
> When OpenVPN is compiled with utun support it will if no dev-node is give=
n first try to use utun and if that is not available will try the tradition=
al tun devices

I'm not fully sure whether I like this or not, but I can see the necessity
if tun.ko is just not working in certain circumstances.

I'd very much like to hear from "GUI authors" for MacOS X about this,
though - copying Jonathan: what do you think is the way forward here,
and should this go into a soon-to-be-released 2.3.2, or is this "long-term
future" material for 2.4?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUVlrn6kuBuNlUUl1AQL3UQP/f+rRNSDCxag5zuPQDzQZ7rOH6eWRBpEz
/JDockuMyv6SLz4FaPcEwfAHcCzvhfGFYjaK4IivQHku45WouHLcUc00IEIc51gp
HieYSUwYcykyk8kthRPVjmSAI+tVeY7O6eN6J5wlcyJOv69a6AzD8SoB6sNXBw9S
6xfKT6Ijf68=
=ZzXD
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

