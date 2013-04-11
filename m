Date: Thu, 11 Apr 2013 11:36:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130411093607.GK569@...1296...>
References: <20130411083001.GI569@...1296...>
	<20130411083657.GD6312@...1820...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D9sZ58tf58331Q5M"
Content-Disposition: inline
In-Reply-To: <20130411083657.GD6312@...1820...>
Subject: Re: [Openvpn-devel] users of the OpenVPN management interface?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, openvpn-devel@lists.sourceforge.net

--D9sZ58tf58331Q5M
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2013 at 10:36:57AM +0200, Samuel Thibault wrote:
> Gert Doering, le Thu 11 Apr 2013 10:30:02 +0200, a =E9crit :
> > Now, I'm wondering who is actually *using* the management interface on
> > the server side (where stuff like "status 2" makes a bigger difference).
>=20
> We use kill to shut down the current VPN session of somebody who has
> stopped paying for the service.

To clarify: of these variants are you using?

kill cn                : Kill the client instance(s) having common name cn.
kill IP:port           : Kill the client instance connecting from IP:port.
client-kill CID [M]    : Kill client instance CID with message M (def=3DRES=
TART)

all but "kill IP:port" work fine with clients connecting over IPv6, just
"IP:port" breaks.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--D9sZ58tf58331Q5M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUWaEB6kuBuNlUUl1AQInngP9Ehqvr/phSfW9B2dSnzJsBVztKyriPeeb
Hxs0iLC5TLsHsuHeJpP4RmTCxxFaXt4xpljp+jwl2kXoIYierIPIip4TiJg5fUDt
rl9zqEYnSN1ix7fe4gHXiAIMvW7q1cEp28C+76w3Tnp8XfjPKzBTeVzFRSUE8o01
4JUqDY++JFo=
=JIRR
-----END PGP SIGNATURE-----

--D9sZ58tf58331Q5M--

