Date: Fri, 23 Mar 2012 16:41:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120323154120.GE1359@...1296...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-50-git-send-email-alon.barlev@...277...>
	<4F58B5D3.8030805@...515...>
	<CAOazyz2TVnmZ0EEisRJRV2hi2VT3L5=01dgVjHC9us_1toZBVQ@...278...>
	<4F59BE3E.9000807@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c2qmoHupxsh34lk8"
Content-Disposition: inline
In-Reply-To: <4F59BE3E.9000807@...515...>
Subject: Re: [Openvpn-devel] [PATCH 49/52] build: move wrappers into
	platform module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--c2qmoHupxsh34lk8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 09, 2012 at 10:24:30AM +0200, Samuli Sepp=E4nen wrote:
> I give this one a feature-ACK, but could somebody else take a better
> look at the actual code changes?

code ACK.

Verified that code is just moved + function names renamed, and in
a few places, parts of functions moved to a new platform_... function
that has the same code.

That was a long one... :-o

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--c2qmoHupxsh34lk8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT2yZoKkuBuNlUUl1AQIsSAQAqDH69FR9vP0XoHJfOfg0P8Fyg6TpJ6yl
84V1AC21Yy2CAnKPMizod4aYkR2v+gqzoSUg+JEMow7zOMQL9E5w53wex5BYqtT4
IOzXySy5Waa/+qvpwWed4KNTgavWZtW+5iQ6VP8icH2WgnlQJIEdH6+YGATGtDS8
jCB1+ab2UNs=
=V2Il
-----END PGP SIGNATURE-----

--c2qmoHupxsh34lk8--

