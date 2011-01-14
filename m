Date: Fri, 14 Jan 2011 23:03:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110114220302.GA300@...1296...>
References: <AANLkTi=O+pg_K-W4AkT=3__VymknQ5dK0tq3czxBjLXL@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GFPlsJ7YtLjXgs8j"
Content-Disposition: inline
In-Reply-To: <AANLkTi=O+pg_K-W4AkT=3__VymknQ5dK0tq3czxBjLXL@...278...>
Subject: Re: [Openvpn-devel] get_default_gateway for solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Magnus Lindholm <linmag7@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--GFPlsJ7YtLjXgs8j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 14, 2011 at 09:00:25PM +0100, Magnus Lindholm wrote:
> If anyone has the same problem on the Solaris platform and would like to =
try
> out the changes I made, let me know.

Please send the patch to the list.  I think its useful to have the same
functionality on all platforms, even if I don't currently need it myself
(I just send specific routes, never default, to my VPN users).

We'll review the patch here, and if it's good, we'll integrate it
(most likely not into 2.2 as that's too close to release, but into 2.3)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GFPlsJ7YtLjXgs8j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTTDIFakuBuNlUUl1AQJx3wQAgHAlK5bSr8V1wZlwY59z/qC51c2y+2qS
c8s01jShG9DlKy/SEjrewaY+NPtVMCvhUmyVYGJTS8h4pQ59Az4LtMGo+ShHsaZH
hbRB1pq7Ka++dZODIkAYTlDp50m4VZv1qkWZUGxFvln3qCBhCopfl00zrFdUr+oJ
KCjoaAtku6U=
=5Q6J
-----END PGP SIGNATURE-----

--GFPlsJ7YtLjXgs8j--

