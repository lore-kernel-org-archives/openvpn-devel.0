Date: Mon, 17 Jan 2011 22:23:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110117212323.GG12114@...1296...>
References: <4D34A90F.7080008@...1194...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <4D34A90F.7080008@...1194...>
Subject: Re: [Openvpn-devel] openvpn FreeBSD kqueue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Roman Vasilyev <roman@...1194...>
Cc: Openvpn-devel@lists.sourceforge.net

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 17, 2011 at 12:39:43PM -0800, Roman Vasilyev wrote:
> I want to try FreeBSD with OpenVPN on high load, checked event.c ???=20
> found that it can work only with epoll, just want to ask is it possible=20
> to use kqueue in openvpn?
> If not, what people thinking if I'll add this support there?

We'd need to see some profiling that shows that the change is making
a noticeable performance (or load) difference.  This sort of system
dependent code can be a burden for a project, because it is hard to=20
maintain if you don't develop on FreeBSD - but if it's a significant
gain, it could be worth the effort.

(Speaking my personal opinion here, not for all the developers)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTTSzS6kuBuNlUUl1AQK3wAP/ejkFzjVJiNghwCr5sBbuOFlS6TGxaD7q
esveVTWQuHbYDcE0TCH26B1PFUjX+8BL2r8KbAcgWseyqaUcV12kNxVh7Rx0Wr39
ZODlnFvUUL8gZfYbi9/Smbywwyuw/AZT9DC2pgKwwDVc3zELP2m8UJ6LIm8IsVT1
tIfICa9oVt8=
=Iwzi
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

