Date: Tue, 21 Oct 2014 23:06:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141021210653.GG396@...1296...>
References: <20141021091159.GY396@...1296...>
	<CAEsd45SOhJcowu27gs6Be5YShph91pUBwq4eBfhGtpCT2MXo1w@...278...>
	<20141021104308.GZ396@...1296...>
	<CAEsd45Qa34HsKZ6rwhuF5qnvBBnsFVeaJcRConfLEjXOdu+StQ@...278...>
	<CAKuzo_juo92ZC8aGjE4FN=EFnw1WMczE_noX7Aa2m+wQEXeJfQ@...278...>
	<20141021142617.GD396@...1296...>
	<CAKuzo_jU0AL9w1MZ-mCfp5_+Q=v2xhYfN1L+eKgN1ZsKtUmzLQ@...278...>
	<CAKuzo_gHOM3ZJfK5Shu4XcCcuG3qPadwsbQHpNCNwFBR67N4fg@...278...>
	<20141021192844.GF396@...1296...>
	<5446B7DE.4030903@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FC8SlEHQ+Zonp6pC"
Content-Disposition: inline
In-Reply-To: <5446B7DE.4030903@...515...>
Subject: Re: [Openvpn-devel] Fwd: New OpenVPN Windows installers (I004 and
	I604) released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--FC8SlEHQ+Zonp6pC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 21, 2014 at 10:45:34PM +0300, Samuli Sepp=E4nen wrote:
> Speaking of 2.4... besides the interactive service what is missing?

redirect-gateway ipv6

(strictly speaking, any sort of "push route-ipv6" where the pushed route
overlaps with the ipv6 address of the VPN server, while using IPv6
transport)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FC8SlEHQ+Zonp6pC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEbK7akuBuNlUUl1AQJBOAQAwbDVdZ0NejM7qO+Ex7yv8BahYtJbj81b
YGamg4BkGbsvYOF+9g3VAhA7NUeK4eyiAYOm2BORvYeF5pUHJKtBS6G7x4NiVech
rJ0Ju2KUbRYjmlt8D+xJVJCF1Q2eezpdMaMccOA/2YuT6i1DLeeiPRo8wM1yZu6J
p/7DN/J46/o=
=HeJB
-----END PGP SIGNATURE-----

--FC8SlEHQ+Zonp6pC--

