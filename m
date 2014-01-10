Date: Fri, 10 Jan 2014 14:49:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140110134947.GC226@...1296...>
References: <52CFF667.7080600@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pMRnfHSWYEVtk438"
Content-Disposition: inline
In-Reply-To: <52CFF667.7080600@...1790...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--pMRnfHSWYEVtk438
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 10, 2014 at 02:32:23PM +0100, Tore Anderson wrote:
> If I connect to an openvpn server using "proto udp6" and "multihome", it
> instantly crashes with an assertion failure:

Just to be sure I understand: it works for "proto udp6" if you do *not*
use --multihome on the server?

> This works with openvpn 2.3.2 so it's a regression.

Definitely (... and as much that code has been rewritten, I'm not fully=20
surprised that some of the server-side things broke in the process).=20=20

Thanks, we'll go work on it.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pMRnfHSWYEVtk438
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUs/6e6kuBuNlUUl1AQL80wQAhRmAeWC3D9SkyEReR3Y1Xc2VMKxgnDz0
hhXyEnmX/8y1kAJNCc9TZNOvJG2jZMP6JxuU3gychn27x+eWNqVZprpsSUmoO/Yl
O39Zuj5dgZcW9sEJahQWe8JqE5RBd+FNVNy/ovipF7uFwvrIn8d/jrELEk/m2V5W
vMQ8851RnIs=
=64ff
-----END PGP SIGNATURE-----

--pMRnfHSWYEVtk438--

