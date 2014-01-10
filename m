Date: Fri, 10 Jan 2014 15:07:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140110140728.GD226@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlZi+g8Ywt2nzGP6"
Content-Disposition: inline
In-Reply-To: <52CFFAF4.8050306@...1227...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Tore Anderson <tore@...1790...>, openvpn-devel@lists.sourceforge.net

--HlZi+g8Ywt2nzGP6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 10, 2014 at 02:51:48PM +0100, Arne Schwabe wrote:
> That is very weird. I would expect it to fail for both cases in the same
> way. The codepath should trigger the same ASSERT(0) in both cases (or
> work in both).=20

... unless something is overwriting to->ai_family, for example by copying
a too-large address structure.  There is a trac bug about --multihome that
says we're using the wrong size (#327) which could be an indication.

(I have not yet investigated #327 more closely - that one is about=20
sendmsg(), but maybe we do bad things on receive as well)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HlZi+g8Ywt2nzGP6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUs/+oKkuBuNlUUl1AQJ29wQApMyXJir6UAr2rglO9vXSgXzbjtMM/CXe
ZidpBc7h65jMxPvQCpyHZSdCs55rPDR5rRjoC+8id8+DU2MC0hi9jkBrl/FoE8Ni
hA+0tUDjjMq+kL7WCKyHZ50UcVlXrgtyHjSj8UIdqGyfYg8umQ3OCB4LnzKj+RER
JELtMt3p3Bo=
=Y6qd
-----END PGP SIGNATURE-----

--HlZi+g8Ywt2nzGP6--

