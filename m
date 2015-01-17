Date: Sat, 17 Jan 2015 12:21:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150117112123.GC8134@...1296...>
References: <1421434930.394813972@...2013...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U1t7w//IUm8YcF8e"
Content-Disposition: inline
In-Reply-To: <1421434930.394813972@...2013...>
Subject: Re: [Openvpn-devel] Windows TAP driver profiling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dan Moulding <dan.moulding@...2012...>
Cc: openvpn-devel@lists.sourceforge.net

--U1t7w//IUm8YcF8e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

On Fri, Jan 16, 2015 at 12:02:10PM -0700, Dan Moulding wrote:
> I have been extensively testing OpenVPN recently, for potential
> deployment with some other systems I have been developing. One
> thing I have noticed during this testing is that performance of
> Windows clients connected to a Linux server is significantly slower
> than the performance of Linux clients with identical configurations.

This is the nagging suspicion we had, but nobody had enough idle time
yet to properly quantify it.

One of the things you could do if you have a reliable test bed is to
test the effects of increasing

 --sndbuf
 --rcvbuf

on the windows side (which default to smaller values than under Linux,
see the log for actual values used).


> I'm suspecting that it's either the Windows network stack itself
> (seems a little doubtful) or the Windows implementation of the TAP
> driver that is causing the poor performance. I'm hoping I can
> profile the TAP driver code to see if I can confirm the latter (and
> maybe contribute some optimizations if it all works out).

Have you tried the old or new TAP driver?  (In the OpenVPN installers, this
is "I00x" for the old TAP driver, and "I60x" for the NDIS6 based new TAP
driver).

In any case, the NDIS6 driver *should* perform better, if(!) it is really
the TAP driver where the bottleneck is.  My gut talks more about sockets
and buffers and "not saturating available link bandwidth due to small
buffers", but I have not measured that yet.

> Has anyone here ever tried profiling the Windows TAP driver code
> before? Any pointers or suggestions from someone who is familiar
> with the TAP driver would be really appreciated.

I have *no* idea how to do that...  I'm a unix guy :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--U1t7w//IUm8YcF8e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVLpFs6kuBuNlUUl1AQJgcwQArrHG1jUGeUO0alDQzhcWV105Avi4u+j3
QBGg+nD47wp0+K3g6bTQGzpkaZBHvYiASBj9UUTXbCnMdLX6sH1HG+8WpU7Oi32h
9NsX/ZCJQbNSAr1gytgkvsgZMFf1jgz8pvq/FzdZocwBnygI0LswicljruvOrgPK
zOWJZChQ7tE=
=eN/E
-----END PGP SIGNATURE-----

--U1t7w//IUm8YcF8e--

