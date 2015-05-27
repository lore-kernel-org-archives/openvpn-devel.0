Date: Wed, 27 May 2015 21:31:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150527193152.GA3558@...1296...>
References: <20150524193011.GK382@...1296...>
	<5565B65A.1000501@...1114...>
	<20150527184124.GT382@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20150527184124.GT382@...1296...>
Subject: Re: [Openvpn-devel] rfd: 'serial-tests' automake option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 27, 2015 at 08:41:25PM +0200, Gert Doering wrote:
> On Wed, May 27, 2015 at 02:19:38PM +0200, David Sommerseth wrote:
> > This makes a lot of sense to me.  Our project doesn't really benefit in
> > general of running our tests parallel.
> >=20
> > This gets an ACK from me.  I just tested your change locally, and it
> > seems to work very well.=20=20
>=20
> Thanks :-)  (and of *course* I tested this before posting...  sometimes I
> actually remember to run "make test" before pushing out broken commits...
> *ahem*)

Unfortunately, this was just *too* easy - in other words, if you happen
to build with an older version of automake that does not understand the
"serial-tests" option, it will just blow up...

autoreconf: running: automake --add-missing --copy --no-force
tests/Makefile.am:12: option `serial-tests' not recognized
autoreconf: automake failed with exit status: 1

... haven't seen *that* much "red" in the buildbot status in quite a while
- basically, everything older than a few years (FreeBSD 8, CentOS 6,
Debian 7, Ubuntu 12.04...)

David suggested making this conditional, but I couldn't find anything in
the docs, so I think I'll revert the patch tomorrow-ish and reopen the=20
trac ticket... :-(

(Buildbots can be fixed, of course, but what we have now would blow up in=20
the same way for all users of a git checkout.  Thankyouverymuch, dear=20
Autotools community...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVWYbqKkuBuNlUUl1AQJjYQP/SlSw4FUFL5WdeufdgafVHo3fZIh7KLxy
FxB+fdAx+j1qFUYzskfUzL4gcSwInhgM0Fhjbe7zoXnFII/rMl/2Ylv2R7Jzi1u1
mpFUT3Ai5bu7dvZQehGL3LzwWW0Va9rstOm7LGH56Y/j19xksSp3dIVky+58oGLs
Bkje8uzEneQ=
=x4Y6
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

