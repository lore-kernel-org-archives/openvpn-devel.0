Date: Fri, 24 Feb 2012 18:13:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120224171343.GC7024@...1296...>
References: <4F438CF2.1060305@...515...> <4F4601A5.3080203@...1549...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MmaWY3eZhcRnoVUs"
Content-Disposition: inline
In-Reply-To: <4F4601A5.3080203@...1549...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 preview 1
	installer now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Freek Dijkstra <public@...1549...>
Cc: openvpn developers <openvpn-devel@lists.sourceforge.net>

--MmaWY3eZhcRnoVUs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 23, 2012 at 10:06:45AM +0100, Freek Dijkstra wrote:
> Running Mac OS 10.7.2:
> % uname -mrsv
> Darwin 11.3.0 Darwin Kernel Version 11.3.0: Thu Jan 12 18:47:41 PST
> 2012; root:xnu-1699.24.23~1/RELEASE_X86_64 x86_64
[..]
> NOTE: explicit support for IPv6 tun devices is not provided for this OS

Huh.  No idea where that is coming from.  (Well, I know where it is=20
coming from, but it really shouldn't be printed, as IPv6 on OSX is fully
supported...)

I'll look into it and send a patch.

> Cannot allocate TUN/TAP dev dynamically

That one is related to no tun/tap driver loaded.  In my tests, I always
fired up tunnelblick first to make it load the driver :-) and then it
works from the cli as well.

> My recommendation is to:
>=20
> 1. Remove the "NOTE: explicit support for IPv6 tun devices is not
> provided for this OS"

ACK.

> 2. If possible, add a message about the cause to the "Cannot allocate
> TUN/TAP dev dynamically" message (e.g. "permission denied" or "no tun
> interface available" ,...)

I'll look into it.  (Been in that same situation with tap on *BSD, where
you need to kldload if_tap first...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MmaWY3eZhcRnoVUs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0fFR6kuBuNlUUl1AQIJ0gP9E2sT8KvLzdROeT+FQ3vNucEISxXw5h08
/9afB/VtLVqTY6emf4IGebr9wvBV0MmjvgzTKrlJcAOSuAd7jt9DJHwtRMkZ9qzG
imChhiPXk5E4WTg4t6Ea0zOSih9BzNxjQ15KaksgC4Xb6iWMLH9asPtT/HluHuM1
5t4i4mvuSjY=
=7/cA
-----END PGP SIGNATURE-----

--MmaWY3eZhcRnoVUs--

