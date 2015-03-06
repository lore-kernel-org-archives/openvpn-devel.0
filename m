Date: Fri, 6 Mar 2015 20:22:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150306192248.GZ21893@...1296...>
References: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline
In-Reply-To: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
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

--o71xDhNo7p97+qVi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 06, 2015 at 01:07:38PM -0600, Nicholas Hall wrote:
> Autotools configure check fails to detect res_init on recent glibc
> versions.  It appears that resolv.h in recent glibc maps res_init to
> __res_init which autotools doesn't catch.

Thanks for your patch.

Looking at it, I wonder why we're calling res_init() anyway.  From a=20
cursory reading of "man res_init" it seems to be a prerequisite to=20
calling stuff like res_query(), res_search() or dn_comp() (etc) - but=20
we actually call *none* of them, nor do we intend to...

We use getaddrinfo() and getnameinfo() extensively, which do not require
res_init() to be called first...

So, instead of adding more convolutions to configure.ac, I propose to
throw out res_init() and everything related to it :-) - much easier.

Arne, what do you think?  You're the last one to have touched the code :-)
(though you didn't introduce res_init(), that came into 2.1_rc8, back
in the SVN days)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVPn+h6kuBuNlUUl1AQIeHgQAovgMHHYKbU9IqoajOC+UxOjB8ZV4T622
UZe9mceeUsDLW2v7aQRRNeudquSSbt1s6qVgOTogSGsI0DqitaXyUyKZtTIAcCX2
5iVFlQH/IYLrxhOju8NPV+lNqoYOI7EUYwNC6+1AMoIQGG2Rt+c0BVDqbehSs7YT
zLK0a4mO+EE=
=nYqr
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--

