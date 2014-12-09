Date: Tue, 9 Dec 2014 21:51:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141209205112.GB17158@...1296...>
References: <54833CC6.8010507@...1490...> <5486B561.8080104@...515...>
	<20141209190918.GA17158@...1296...>
	<54874E0F.2070400@...1490...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2kvLHdEX2DcGdqq"
Content-Disposition: inline
In-Reply-To: <54874E0F.2070400@...1490...>
Subject: Re: [Openvpn-devel] feature request: get openvpn to use closest
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason_Haar@...1490...>
Cc: openvpn-devel@lists.sourceforge.net

--G2kvLHdEX2DcGdqq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 10, 2014 at 08:31:27AM +1300, Jason Haar wrote:
> LOL! It took Gert to spot the most obvious scenario ;-)=20

I'm good at breaking things :-)

> That really
> re-enforces what I think about this needing to be an "openvpn ping" type
> solution: it is irrelevant if the server is up or even if openvpn tcp
> ports appear to be open, it's only evidence that openvpn is working that
> should be taken as evidence that openvpn is - well - working :-)

Indeed.

I think what you're proposing is quite a cool feature, but it is not easy
to implement.

The "ping" could actually be fairly easy, though it might need protocol
changes (to permit a quick health check - for tls-auth authorized clients -=
=20
without a full TLS negotiation taking place).

More work is the connection loop on the client side - right now, OpenVPN
walks the list of "remotes" sequentially, and if one fails, tries the next
one.  This would need to be changed to try them "all at once", at least
for the "ping" check, and then decide on a connection order for the real
connection...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--G2kvLHdEX2DcGdqq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVIdgwKkuBuNlUUl1AQKtFgP/c/BLrxFYBDkbXsA5rmz7wkZoWNyg6pFZ
xfTvZusfl3+QUhN3yWs7WfwOebKvfdmOYLG1MN7Gd5blhHaYpPN6au/RNTRrb4NW
O01SkefGrSuwvfqRaGLNbW+q97OXlRS6m6bj9qGfk+VJdAYwM+5jSgM9jto68i+R
o+qIU3Q1LZc=
=1pn1
-----END PGP SIGNATURE-----

--G2kvLHdEX2DcGdqq--

