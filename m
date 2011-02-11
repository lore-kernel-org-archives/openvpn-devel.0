Date: Fri, 11 Feb 2011 23:40:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110211224046.GP13740@...1296...>
References: <4D53FD4B.8050302@...515...> <4D540B3B.5040602@...1147...>
	<4D54F653.4040809@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <4D54F653.4040809@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2-rc Windows installer ready
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 11, 2011 at 10:41:55AM +0200, Samuli Sepp=E4nen wrote:
> The older TAP driver probably works fine for the 2.2 branch. However, it
> won't work properly in 2.3, which will contain IPv6 support.=20

It will just not do IPv6, but the code in tun.c checks for this, and
will print a warning so users can see why IPv6 is not working.=20=20

It won't explode or break IPv4.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTVW67qkuBuNlUUl1AQI0zAP/XNzPM0cXwTTdX6Grqcq89BOhkXquu3Rv
nAUXDD/CWmAybpR2O8DOs0fhmpgddhLKr6GRRA8o9YUH+9EG2G7+IMfzPa34y1BK
sgE5eKT2B58SlU+vFGMesjKpbaicTMwpytW17gH1ejRo23ghN5W9ZyPjcty1977B
f0pLLiI2IyQ=
=URcZ
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

