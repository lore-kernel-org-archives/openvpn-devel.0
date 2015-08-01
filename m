Date: Sat, 1 Aug 2015 15:07:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150801130709.GM382@...1296...>
References: <20150730233727.GW3676@...2049...>
	<CAFHpkQGqdJdpz_FTPWzsziNHbMCt3DOwkLHA8BXU9M+-+Cv_mA@...278...>
	<20150731091257.GC3164@...2050...>
	<CAFHpkQFk5nB9U655hh3TKn_BsVVBR_q8tibVDc7XhYTgKC1Jkg@...278...>
	<20150731095726.GL3164@...2050...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yultHY/4CFYhURo5"
Content-Disposition: inline
In-Reply-To: <20150731095726.GL3164@...2050...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, ???????? ?????????????? <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--yultHY/4CFYhURo5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 31, 2015 at 11:57:26AM +0200, Samuel Thibault wrote:
> But without a central repository where people would get to know about
> your version, then it's even more probable that you'll remain the only
> user...

Indeed.  Who *is* maintaining the radius plugin these days?  What is=20
"the official" repo?

I found some stuff on

http://www.nongnu.org/radiusplugin/=20

(no change since 2010, but the debian package has "more recent" updates,
and the ubuntu package even has a patch from Samuel Thibault :-) )

http://www.bytebucket.org/02strich/openvpn-auth-radius/src

(this seems to be a fork, many of the files have the commit message
"initial commit - based on 2.1 Beta", but there has been a bit of activity
in 2012 and 2014...  not very much, so merging the stuff back should not
be very hard)

gert=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yultHY/4CFYhURo5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVbzEfakuBuNlUUl1AQJxVQP/f0Efstt1YgKQWWK1a3UBUCsDm1OxqvW3
0G8/22qjZJyntKHla286Ip16+SwuFEwUVAXhqMum5CTW/rOviyAyzbkOC+pVfaN4
0OHtVzwSe1744Lf5dGm/oMJBYUaE4xcKqR8Xkylwnk/AFxAYu6ZYRJE8i8xc2Mhq
Q/ftWRIlQXY=
=pNn9
-----END PGP SIGNATURE-----

--yultHY/4CFYhURo5--

