Date: Fri, 6 Mar 2015 23:17:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150306221754.GA21893@...1296...>
References: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
	<20150306192248.GZ21893@...1296...>
	<CAK6ywb+kAQ+DrLWoQyAfKfMmXqz1278OYRWiYmw4TZ9cn-F3Uw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Content-Disposition: inline
In-Reply-To: <CAK6ywb+kAQ+DrLWoQyAfKfMmXqz1278OYRWiYmw4TZ9cn-F3Uw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix autotools check for res_init
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Nicholas Hall <ngharo@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--yzvKDKJiLNESc64M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 06, 2015 at 01:45:16PM -0600, Nicholas Hall wrote:
> > We use getaddrinfo() and getnameinfo() extensively, which do not require
> > res_init() to be called first...
> >
> > So, instead of adding more convolutions to configure.ac, I propose to
> > throw out res_init() and everything related to it :-) - much easier.
>=20
> res_init seems to be necessary to pick up changes to /etc/resolv.conf
> mid-process (without some low-level caching like nscd). As of master
> right now, OpenVPN never recovers when it's started with bogus
> nameservers in /etc/resolv.conf.

OK, i see.  So getaddrinfo() is affected by calling res_init() repeatedly,
even if it's not necessary for the initial call.

> The steps I describe in bug report #523 is still valid, even though my
> description of the implementation of openvpn_getaddrinfo() was wrong.

I see that we need to fix finding res_init() then.

I'm not sure the patch is the right approach, though - it brings in
system dependent stuff for MacOS to work around a Linux problem, which
can't be right.

Turing around the question: is there any system out there that has=20
tun/tap support but not res_init() (=3D do we need the HAVE_RES_INIT stuff
anyway, as opposed to "just find the right library")?  What about Windows?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVPonkqkuBuNlUUl1AQJCiQQArVvGFh5PSRvBUIF5Fl+tiHt0YJ6tvbk9
MJNvVSnk1qwl19zqTpLn+yyidDaRJY3tOwQnWk//cR6UtcXa8OsTiME1sfwFNIBo
nir6O+ICr45oW0eXhmrKethEHIlptOlV7FCoAJsf4EFiIG+JPswLd0NUh1w3ho99
UbpXSHX48dQ=
=VM+6
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--

