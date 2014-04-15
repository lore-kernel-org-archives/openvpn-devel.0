Date: Tue, 15 Apr 2014 21:31:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140415193132.GY16637@...1296...>
References: <20140415110052.GB25405@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0I3XpSxCEfqL2LaD"
Content-Disposition: inline
In-Reply-To: <20140415110052.GB25405@...1296...>
Subject: Re: [Openvpn-devel] RFD: "--ignore-ipv6-failure" switch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0I3XpSxCEfqL2LaD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 15, 2014 at 01:00:52PM +0200, Gert Doering wrote:
> a few of my users are driving me nuts, by unchecking "[ ] IPv6" in their
> windows TAP adapter settings, and then complaining that their OpenVPN
> is not connecting to this customers' server properly (because netsh.exe
> fails to add an IPv6 address, and this is considered fatal).

Turns out that this wasn't the actual problem, but the problem was=20
"gui not run as administrator".

Which actually moves the issue (for me) towards=20

 - why can't we report a useful message if netsh.exe fails due to lack of
   permission?

 - why do we happily ignore IPv4 route.exe failures due to lack of=20
   permission?  (Which means that the IPv4 case actually hides the problem,
   the GUI and OpenVPN pretend that "all worked!" but if you try to connect
   something behind the VPN, the routes are just not there...)

Hrm.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0I3XpSxCEfqL2LaD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU02JFKkuBuNlUUl1AQJbBgQApz1xzzpywEx0TIuiADiW6ORdvGJ3ANn5
KMZaTlNaQelB4dlOhhAgRwYTA+5TW7VRouoMJBQlMEXmRMzpEgJng8Yfuc2g9z+2
Eucr4zocBnJooiAisWNGH04WMAH9N2loB0NnM1QlsAPhEUs5WfkVErjkswZgKMdr
rY7py30+lOk=
=hCVe
-----END PGP SIGNATURE-----

--0I3XpSxCEfqL2LaD--

