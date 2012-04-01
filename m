Date: Sun, 1 Apr 2012 13:37:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120401113759.GZ1359@...1296...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-2-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VousOZe2B5HJrJZY"
Content-Disposition: inline
In-Reply-To: <1333012602-5419-2-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] cleanup: avoid using ~0 - generic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--VousOZe2B5HJrJZY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 29, 2012 at 11:16:39AM +0200, Alon Bar-Lev wrote:
> Use limits.h for maximum value.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>

I like this approach - it is a maximum value, so UINT_MAX is making this
obvious.

ACK.

There is a similar bit of code in the win32 section, in=20
get_default_gateway_row():

get_default_gateway_row (const MIB_IPFORWARDTABLE *routes)
{
  struct gc_arena gc =3D gc_new ();
  DWORD lowest_metric =3D ~0;

... which might also be a candidate for this change.  As I'm not sure
whether UINT_MAX is appropriate for a DWORD, I'm not proposing anything
particular for this occurance.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VousOZe2B5HJrJZY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3g+F6kuBuNlUUl1AQKcCgP/f1kFb6hyy7+PC8xddSwm5ESS9j5aOQZS
T1SVNmhyAqRKgAiOQ9N7/YTeza283l56xcBz/xoLrCLzTYRymIvUQKBLRuAILYpr
6oMqGblKgYzHwkcFM7DwwyQeQBowvl9OPUFX+rFAq1Twad0B8XxsiDgXST+S3NGf
mP3u+hh1ntA=
=2McH
-----END PGP SIGNATURE-----

--VousOZe2B5HJrJZY--

