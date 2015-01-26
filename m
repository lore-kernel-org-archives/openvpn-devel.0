Date: Mon, 26 Jan 2015 20:14:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150126191432.GX8134@...1296...>
References: <1422261503-1412-1-git-send-email-samuli@...515...>
	<1422277453.5382.25.camel@...1866...>
	<54C64B78.1070602@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5XwDZYQieeN6n9K"
Content-Disposition: inline
In-Reply-To: <54C64B78.1070602@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Add more dash escaping to the man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net, David Woodhouse <dwmw2@...1866...>, Colin Watson <cjwatson@...334...>

--f5XwDZYQieeN6n9K
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 26, 2015 at 04:13:12PM +0200, Samuli Sepp=E4nen wrote:
> I tried to reproduce the problem on Ubuntu 14.04, Debian 6 and CentOS 6
> and was unable to. Having or not having escaped dashes made absolutely
> no difference. Note that I only tested "less" as the pager. In any case,
> it looks like the problem got fixed outside of OpenVPN, which leaves us
> with an inconsistent escaping style on the man-page.

In that case, I'd actually prefer to have everything *un*escaped, as it
makes handling of the manpage slightly easier.

If that does the right thing, that is :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--f5XwDZYQieeN6n9K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVMaSGKkuBuNlUUl1AQLnDwQAiv9ppWV41yjruc5R2RGmzkUHo4FOWxH/
bRtaaj/ekD8n3JzsBsM+DdirGB5CcYYijiB3aH3ER/YSGT6Xot86LAak6wnZqnSO
mmSJfBCuXE+ryxJT/Df+FLje6hCqOffGAJBPx6mSdNNQeuxcJoqpyJvSicZqG19S
y5sDrLCvggw=
=Q9IZ
-----END PGP SIGNATURE-----

--f5XwDZYQieeN6n9K--

