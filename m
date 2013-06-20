Date: Thu, 20 Jun 2013 21:44:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130620194412.GZ20843@...1296...>
References: <20130620180244.GV20843@...1296...>
	<1371753560-23939-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6IeHAMkZHKx0vIy5"
Content-Disposition: inline
In-Reply-To: <1371753560-23939-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH v3] plugin: Extend the plug-in v3 API to
	identify the SSL implementation used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--6IeHAMkZHKx0vIy5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 20, 2013 at 08:39:20PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> OpenVPN would segfault unexpectedly if it would be compiled against Polar=
SSL
> and the plug-in would expect OpenSSL, or vice-versa.  This segfault would
> not appear before the plug-in would try to access functions which would
> be available if the plug-in and OpenVPN uses the same SSL implementation.
[..]
>  v3 - fix bug in plug-in init, as the SSLAPI was located wrong in the
>       args struct sent to the openvpn_plugin_open_v3() function.

ACK.

As, I think, 2.3.x will be with us for quite a while, I'd consider this
a bugfix to the new feature in 2.3.x (namely, polarSSL support) and would
put it into master and 2.3

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6IeHAMkZHKx0vIy5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUcNbjKkuBuNlUUl1AQK9WQQAnPkwlRNLFSBXT+ECtgPO36erArOuauMu
Q9bOLNpvEMM7vftN+8dxq8NT+efIJd/YyGTwgA4DH1G1cScmVb6pLJIApMicjT/f
RqFNxo2fy3UILx3QlaeUJ8tMuisfiPotDPVEcEa5jKIzsIsekZgCotrG3OCcaveJ
DhSaDtkq898=
=K9ht
-----END PGP SIGNATURE-----

--6IeHAMkZHKx0vIy5--

