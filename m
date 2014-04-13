Date: Sun, 13 Apr 2014 21:17:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413191759.GY16637@...1296...>
References: <1397389435-20170-1-git-send-email-gert@...1296...>
	<20140413115257.GO16637@...1296...>
	<20140413130102.GR16637@...1296...>
	<534A9635.2090704@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1aK428jFOAUOzjjs"
Content-Disposition: inline
In-Reply-To: <534A9635.2090704@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix SOCKSv5 method selection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Yawning Angel <yawning@...1897...>, openvpn-devel@lists.sourceforge.net

--1aK428jFOAUOzjjs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 13, 2014 at 03:50:45PM +0200, Arne Schwabe wrote:
> Am 13.04.14 15:01, schrieb Gert Doering:
> > On Sun, Apr 13, 2014 at 01:52:57PM +0200, Gert Doering wrote:
> >> I'll amend that when committing.
> > Here is the patch with the MSVC build change, plus some changes to the
> > commit message to point to the pull request and trac.
> >
> ACK from me for the patch. It looks reasonable and if the change breaks
> configs than these configs were fishy to begin with.
>=20
> Please compile test the const ssize_t size; size =3D ... split. I think
> you need to drop the const keyword.

Thanks.  Right you are, if the line is split, the "const" will give a
compile error at assignment time.  Learned something new today...

Build and t_client tested, including the tcp- and udp-socks-tests (but
only "with no authentication", as my test bed doesn't have a socks proxy
with auth).

### test run 1d: 'tcp4 / socks proxy / p2pm / top net30' ###
### test run 2d: 'UDP4 / socks proxy [on TCP!] / p2pm / top net30' ###

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1aK428jFOAUOzjjs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0ri56kuBuNlUUl1AQJsjAQAhUQVhMELLYnSOZ4JbtnoD+bRvrpK2BbM
oSPaLWOa/A2ZG6l8lCzE//hx/KzHES+OMcnDgYSKqzoxAsIeFd9DiIlTQIz04FAk
U5dWVUzUK5olwyBRAOBSCAvhHoU21IQTpakbpPFAYKsqeyeEaeWmMc2Gx7Kot2a3
NJn0QvIHf7A=
=ryWJ
-----END PGP SIGNATURE-----

--1aK428jFOAUOzjjs--

