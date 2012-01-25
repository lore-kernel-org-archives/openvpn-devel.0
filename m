Date: Wed, 25 Jan 2012 23:18:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120125221803.GE5060@...1296...>
References: <1327405130-22393-1-git-send-email-davids@...1347...>
	<CAEsd45R22XK71TEfe8rVCooQ65XsKDTCW_QB9p06VuQmQK0C3g@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gi8aKAu241S2WqNd"
Content-Disposition: inline
In-Reply-To: <CAEsd45R22XK71TEfe8rVCooQ65XsKDTCW_QB9p06VuQmQK0C3g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add
	--route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN script/plug-in hook
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--gi8aKAu241S2WqNd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 25, 2012 at 11:08:42AM -0500, Jonathan K. Bullard wrote:
> This is great. Two comments:
>=20
> 1. Is the man page (i.e., the page shown at
> http://openvpn.net/index.php/open-source/documentation/manuals/openvpn-22=
.html)
> part of the source code repository?=20

It is...

> If so, shouldn't patches that
> change the interface include appropriate changes to the man page?=20

... and so does the patch.  At least my copy of it had a section starting
with

diff --git a/openvpn.8 b/openvpn.8
index 4a86ce7..a6d7567 100644

> 2. Can this be used to release a DHCP lease? That would be wonderful!

Sure, just add a script that signals the dhcp client...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gi8aKAu241S2WqNd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTyB/m6kuBuNlUUl1AQJZEwP/aXaBtzU+yk9FQGqq7dEYVQHA3za0r7WH
9QKz8DqcxGHyXA95GFy1DUWxRIxhN0h2hailm98yccCYlCiifyIBPN3+sgvaEv2i
UU0gZI0bowxxezDK0rGKD4N+u0AbJ0vSrGTVlfjColQP3q5XDVFD0T42DjbdOiRh
TTcsiKVXDig=
=fcsr
-----END PGP SIGNATURE-----

--gi8aKAu241S2WqNd--

