Date: Sat, 14 May 2011 18:01:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110514160158.GQ8496@...1296...>
References: <BANLkTimDEA004RuTcUBKDXPWffEWBo3-iw@...278...>
	<20110514120304.GO8496@...1296...> <4DCE76E9.4070806@...68...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L977DYpOHGH1NqKf"
Content-Disposition: inline
In-Reply-To: <4DCE76E9.4070806@...68...>
Subject: Re: [Openvpn-devel] [PATCH] fix 2.2.0 build failure when management
	interface disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--L977DYpOHGH1NqKf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 14, 2011 at 02:34:49PM +0200, Matthias Andree wrote:
> Cutting down complexity (i. e. cutting out branches in the decision
> and/or option trees) is going to help more than just trying to cure the
> symptoms.

Preaching to the choir...  I'm all for getting rid of #ifdef variants
where possible.

I'm not exactly sure why one would want openvpn without management
interface, except for "embedded systems, as small as possible" - and=20
we have "--enable-small" for those already.  So maybe one could merge=20
"--disable-management" and "--enable-small"...  one less variant.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--L977DYpOHGH1NqKf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTc6ndqkuBuNlUUl1AQIeXAP9EecD9B5tfT2xXelEbIXOWWs82PqC8nBR
FbafTke56lzeQFYnJzME0Q8Fd/ulne8GIui5cdnaToseuuhmWLd81J+3VXQNK9Tj
f0cq6+VEUt9feaLA5hQD3K67AtBUzKA1geFjps7nA2KbplcyZmIcm1k6WTktVaha
7ILH26xdu7E=
=EUn/
-----END PGP SIGNATURE-----

--L977DYpOHGH1NqKf--

