Date: Sun, 30 Oct 2016 15:20:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161030142030.GW28918@...1296...>
References: <20161021154630.GT25148@...2038...>
	<20161021165926.GV25148@...2038...>
	<20161030134825.GB1791@...2038...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExIO7AL6tcaLjJBF"
Content-Disposition: inline
In-Reply-To: <20161030134825.GB1791@...2038...>
Subject: Re: [Openvpn-devel] [PATCH] Allow to specify bind interface for
 outbound/inbound connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ExIO7AL6tcaLjJBF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 30, 2016 at 02:48:25PM +0100, Maximilian Wilhelm wrote:
> Can I motivate anyone on commenting on or applying this? :)

You're keeping me busy on multiple fronts :-9 - and since this is networkin=
g,
it's mostly me who gets to review this.

What's complicating this is that it's also "infrastructure work" (as in
lying the groundworks for a new class of system-dependent features) so
we should get it right.  "Bug fix" is much easier to review ("reproduce,
apply, see it fixes the bug, done").

Not forgotten, though.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ExIO7AL6tcaLjJBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWBYBrakuBuNlUUl1AQKbBQP/e/agkX5fDR2awf6rCPynhpej0LGnj5dE
9J6YmGzobljfwiiXi2RKyVijVgIyN9O0Hf7L4yb9vQNvFTwEyRWr2yLbk2g4INaS
1sHzWa4LXE+kY+OuDbmw5BWXuYm7/6pVTm2hZh62DOuiGA1Qyi9pekjqcE6h5D0w
DZesOW/fdLw=
=R//1
-----END PGP SIGNATURE-----

--ExIO7AL6tcaLjJBF--

