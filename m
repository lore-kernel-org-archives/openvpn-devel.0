Date: Thu, 9 Jun 2011 19:48:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110609174852.GZ8496@...1296...>
References: <4DF0FEC8.4040105@...1465...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80wSvbVxSilpZkXN"
Content-Disposition: inline
In-Reply-To: <4DF0FEC8.4040105@...1465...>
Subject: Re: [Openvpn-devel] Why no ipv6 support for tap?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sergey Matveychuk <sem@...1465...>
Cc: openvpn-devel@lists.sourceforge.net

--80wSvbVxSilpZkXN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 09, 2011 at 09:11:36PM +0400, Sergey Matveychuk wrote:
> It's really weird that I can't set up IPv6 address for tap interface.=20

You can, but you need the "top of the tree" code, not 2.2 release.

> server-ipv6 turns a tun mode,=20

Actually, it doesn't.  server-ipv6 will use whatever is configured as=20
"device" (device tun / device tap).

> ifconfig-ipv6 suppose p2p interface and=20

No.  It will work in p2p and p2pm mode.

> even 'push route-ipv6' misticaly discards because of some flag=20
> (tt->ipv6) has been unset.

push route-ipv6 will fail if you have no ifconfig-ipv6 on the interface
(because then it would not work anyway).

First get the ifconfig right, then worry about the routes.


> Looking on added ipv6 support I have only one question but many times=20
> "why? why? why?".

"Something is wrong in your setup".

It works nicely for a number of people in p2mp tun mode, and it works
to some extent in p2mp tap mode (pushing routes does not yet, you need
to add them manually / by script after the interface is "up" - but=20
that's a documented limitation of the current state of the code).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--80wSvbVxSilpZkXN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTfEHg6kuBuNlUUl1AQI+EQQAoNYLmk6Zutjyszv72VtM4EvHZXRu9b7t
5gCdSFdQO1O7+USS2Pcm7TCNX7FsLWzMBgaysVKZsd5iRII9eyACPFhaLmiCo2/7
G+JhSQ+A73crkh9F04LMsTJRed3ykmQ5+30/dFeQzIGNL5a5fVmuuxJB7R9ylp5/
4WX74/fLEMg=
=sO78
-----END PGP SIGNATURE-----

--80wSvbVxSilpZkXN--

