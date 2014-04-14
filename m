Date: Mon, 14 Apr 2014 11:42:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140414094223.GH16637@...1296...>
References: <534B98A4.7020806@...515...>
	<20140414082858.GB16637@...1296...>
	<534BA045.50503@...1435...> <534BA2CB.3030300@...515...>
	<20140414092928.GV13903@...1894...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mLpLBONkrWOwHKmY"
Content-Disposition: inline
In-Reply-To: <20140414092928.GV13903@...1894...>
Subject: Re: [Openvpn-devel] OpenVPN PolarSSL builds?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--mLpLBONkrWOwHKmY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 14, 2014 at 11:29:28AM +0200, Alberto Gonzalez Iniesta wrote:
> There're already packages for PolarSSL in Debian (and thus, in Ubuntu).
> So I don't think there's need to maintain different ones.

What's Debian's stance on PolarSSL 1.2.x vs. 1.3.x?  This is something
that had me worried for a while, as they are plain incompatible - so
if we finally merge Steffan's patch for Polar 1.3.x support to git master,
different OpenVPN versions will require different PolarSSL versions as
well

  openvpn 2.3.x -> needs PolarSSL 1.2.x, will not build or run with 1.3.x
  openvpn 2.4.x -> needs PolarSSL 1.3.x, will not build or run with 1.2.x

(the decision to not-support PolarSSL 1.2.x in parallel to 1.3.x saves
OpenVPN a lot of #ifdefs in our code, but pushes the burden to the
distribution maintainers)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mLpLBONkrWOwHKmY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0utf6kuBuNlUUl1AQIq7QP9Fqiu50K+vOnHdxN2QR/xGWBMLCn5X/oo
baC6OksBdWuIcOl4FGB1BkYo4AzVTbc1euHkVSCrcTTAdnyNnltlHzfmNGPhIdEC
sF85jafeeElkQARDRIm/BFtLi4Q2eQVhQhQfXBv/yB8hZwGsU9wozCFWZUEp7c1X
o/truwxgDeg=
=K4JG
-----END PGP SIGNATURE-----

--mLpLBONkrWOwHKmY--

