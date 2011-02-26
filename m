Date: Sat, 26 Feb 2011 12:25:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110226112534.GV9835@...1296...>
References: <AANLkTikHd0G_8-JAkXTojetsG7-w5TV3j9fdUwx309A+@mail.gmail.com>
	<20110226104526.GT9835@...1296...>
	<AANLkTik-vCrO=yQW7FNiUXyrXfKjNe-3Dq4aGUkHsfT5@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Content-Disposition: inline
In-Reply-To: <AANLkTik-vCrO=yQW7FNiUXyrXfKjNe-3Dq4aGUkHsfT5@...278...>
Subject: Re: [Openvpn-devel] sctp in openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olivier Van Acker <cyberroadie@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 26, 2011 at 11:19:19AM +0000, Olivier Van Acker wrote:
> > The code parts in question inside OpenVPN (socket.c) are somewhat
> > complicated due to lots of existing options and lots of existing
> > operating systems being supported, so this will not be a trivial
> > task.
>
> Would it be a good idea to limit the scope of this project by concentrati=
ng
> on one OS first? I was thinking FreeBSD first since that contains the
> reference implementation of SCTP.

Well, you'd certainly start with one OS, but in the long run, you'd want
the mainstream OSes (Linux and Windows) as well...

[..]
> > functionality to listen on multiple sockets in parallel,
>=20
> This is somethings SCTP has build in.
> One SCTP association (connection over one or more nodes) can contain
> multiple independent data streams.

This doesn't help me a single bit if I'm sitting behind a firewall that
doesn't even let UDP/1194 pass - listening on SCTP *and* UDP/TCP in parallel
will be necesary, because too many clients won't be able to use SCTP, at
least when starting this.

Or are you implying that by listening on a SCTP socket, the kernel
machinery will also handle incoming "plain UDP" and "plain TCP" connects
via that SCTP socket?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTWjjLqkuBuNlUUl1AQJhdQQAov+PHIsQ3hZuCwtS+ofPXVV3eVfLhpgV
DA1oCo6zJK+oivLLP+imThPtzJI49zMHmDx2jkDz9qXkEBgzriSCYTR1J4qs8Gv7
PypZ+SYDAJHVK3ucy8z5DM5jPWVfWui85q76FKtFOrePelw4E9KFkC5HYC9UKZjS
+6kcxAXnUvY=
=ZAFw
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--

