Date: Fri, 24 Jun 2016 17:29:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160624152932.GW79504@...1296...>
References: <20160624140526.GV79504@...1296...>
	<CAFHpkQEtXO1aWSF5v=ivNCx2TzK870tm_StjComxrNWLp1_9LQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oh6wehMCKJhhoxlo"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEtXO1aWSF5v=ivNCx2TzK870tm_StjComxrNWLp1_9LQ@...278...>
Subject: Re: [Openvpn-devel] brainstorming: t_client system test equivalent
 for windows?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Oh6wehMCKJhhoxlo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2016 at 07:44:18PM +0500, ???????? ?????????????? wrote:
> I would suggest powershell instead of perl. I can write powershell stuff

Fine with me, if someone else writes and maintains it...  I can do a
bit of .bat scripts, but no powershell.=20=20

Perl has the advantage of being available on all platforms (or at least
"you can install it", I know it's not there out of the box everywhere)
so maybe we can do a common test driver implementation that runs on
windows and unix, so less maintenance...

But first and all, we need something.  We have no perl, and no powershell,
so having a working powershell implementation is much better than a non-
existing perl script :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Oh6wehMCKJhhoxlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV21R3KkuBuNlUUl1AQIoagQAmTU8Rdy7E6eAO4Fs8XqKdGbfLu9sGIAM
kAlVSb3oewluSvUmdFW+UZY+eNM7eWDOuLplp6K5Mvufnp6k5vAFFCXz+7V1MTSE
pztKotk8bmyFnKMwAbL+YA+Wisz9c4aWhPBi2nRB7dz+npJzAnJPpN+jgxl1SR0s
oo6BTAsCebU=
=KE/O
-----END PGP SIGNATURE-----

--Oh6wehMCKJhhoxlo--

