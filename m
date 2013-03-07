Date: Thu, 7 Mar 2013 20:40:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130307194033.GH953@...1296...>
References: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ewIlFbbLnYFKahON"
Content-Disposition: inline
In-Reply-To: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] revamp X.509 name verification option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--ewIlFbbLnYFKahON
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 22, 2013 at 10:44:19AM +0100, Heiko Hund wrote:
> This patch set tries to do X.509 name verification right. As discussed
> during FOSDEM 2013, changing --tls-remote to support RFC 2253 style
> subject DNs only was too radical as it broke more configurations than
> expected.

Acked by Arne, now all committed and pushed.

(I have reviewed the code as well, and even test compiled the trees
before pushing them :-) - so not just relying on the ACK)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ewIlFbbLnYFKahON
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUTjtMakuBuNlUUl1AQJy7wP9FZ6PI96DnaPzWp0oHO2LTGHnjC2Lr1EV
yjGf58XHvkoIIrVl2l6xR9PYSVFqGpsUT45aLOsM2/RLRD+DFbezPDKxr/4166ME
EaLCP0tyjsG2asvOMQP7pFeGrFGcOxSqbB7nlPmMFUkS/pnP+zTCz0TuIubxbhrZ
qmPgUGxQ/oQ=
=D/uO
-----END PGP SIGNATURE-----

--ewIlFbbLnYFKahON--

