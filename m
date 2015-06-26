Date: Fri, 26 Jun 2015 13:28:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150626112850.GV382@...1296...>
References: <558C0F5D.9060104@...2039...> <558C143F.30400@...1147...>
	<558C217F.7080607@...2039...>
	<558D268B.2070809@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FA4APBijtXe2jGIE"
Content-Disposition: inline
In-Reply-To: <558D268B.2070809@...1114...>
Subject: Re: [Openvpn-devel] Windows build fix for CVE-2015-4000
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--FA4APBijtXe2jGIE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 26, 2015 at 12:16:43PM +0200, David Sommerseth wrote:
> * Exploitable out-of-bounds read in X509_cmp_time (CVE-2015-1789)
> This might be an issue on OpenVPN on the server side.  However,
> --tls-auth will reduce the attack vector to one of your own users.

As we're not using X509_cmp_time()...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FA4APBijtXe2jGIE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVY03cqkuBuNlUUl1AQItnQP/WCg4Z58Agh3W26hyZu1i/i0bFatUpYju
gEzDs7SIdYC9FUJBvAE1Q/X2yLcDdnhhIyGjVJG0ISz2GWmyxvWzbTJCJFksbjJE
hyyIvyVt+b++S5N9wPzQsunfVqHOA4p5rFnFWVu8qSQ2Y7bEFEdTc93IEbHwAcu/
aHbOhRswRFE=
=ksC7
-----END PGP SIGNATURE-----

--FA4APBijtXe2jGIE--

