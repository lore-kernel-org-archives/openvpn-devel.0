Date: Sat, 28 Apr 2012 10:05:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120428080508.GG1359@...1296...>
References: <CAOazyz02OcvCdJJ-JHBZWcxB-99nEBOXUcCHE6fkN4eGUkyCgQ@...278...>
	<1335479238-26420-1-git-send-email-alon.barlev@...277...>
	<CAOazyz26b+W+_5_Sb4xhnWWXgAV5ENAxPTyNqyDAUYMbhUoucw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SB3YF6DP/s+9nxGh"
Content-Disposition: inline
In-Reply-To: <CAOazyz26b+W+_5_Sb4xhnWWXgAV5ENAxPTyNqyDAUYMbhUoucw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: use stdbool.h if available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--SB3YF6DP/s+9nxGh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 27, 2012 at 01:28:31AM +0300, Alon Bar-Lev wrote:
> On Fri, Apr 27, 2012 at 1:27 AM, Alon Bar-Lev <alon.barlev@...277...> wro=
te:
> > If stdbool.h is available use it, otherwise create emulation.
[..]
> I took the easy approach.
> I think this is the simplest it can be.

Even if David has already committed it - thanks, this looks good.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SB3YF6DP/s+9nxGh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT5uks6kuBuNlUUl1AQIYeQP/QOtEc7wjj61mLRulPULXQpQp5wz0KnfR
e/L5y3ELzHdPFlwcJM5JuZzXhl5SXJukN2cTAe+xdM8zSQ4XQBg2oywOSMFNL892
MWC3FqX3XHquqF4Bz/JKO0wJxWDlaxLbv9LyAULewN45/irDaALYxlaOFgeKxv02
4Be11LkR2z0=
=Lp86
-----END PGP SIGNATURE-----

--SB3YF6DP/s+9nxGh--

