Date: Fri, 19 Jun 2015 22:04:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150619200445.GS382@...1296...>
References: <20150617100752.GG382@...1296...> <55843EAD.6010305@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tk6QM1MMR8QQKbMj"
Content-Disposition: inline
In-Reply-To: <55843EAD.6010305@...1147...>
Subject: Re: [Openvpn-devel] why is "route add failure" considered not an
	error?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--tk6QM1MMR8QQKbMj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 19, 2015 at 06:09:17PM +0200, Jan Just Keijser wrote:
> I don't know what the reasoning was behind making "route failures"=20
> non-fatal, but strictly speaking the tunnel is functioning - it's just=20
> the routing that failed :)
> I'd be in favour of adding  YetAnotherOption to override the "route=20
> failure" behaviour - but the real solution on e.g. the Windows side is=20
> to alter the GUI to pick up any routing failures and warn the user.

The GUI has no say here... OpenVPN calls route.exe (or /sbin/route) and
just ignores errors (logs, though) - so the GUI would have to parse the log,
or we would have to add special signalling towards the management interface.

Which wouldn't help the "there is no GUI" case...

> As a side note: I've gotten my hands on Windows 8.1 for my laptop. I'll=20
> install win8.1 (dual boot) on it shortly, so that we can debug the=20
> routing/ipconfig issues.

Well, for *this* issue, there's not much to debug - it's a conscious
decision in the code to call openvpn_exec_check() with the flags set to
"errors are not fatal"...

OTOH, it seems that Steffan and Heiko might have a testable interactive
service soon - which would solve the permission issue on windows nicely :-)
(Heiko: how does the iservice handle failure to install a route?)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tk6QM1MMR8QQKbMj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVYR13KkuBuNlUUl1AQJeagP/ci2idNphw/+od1HtD1wXFhRdS7CwdzQq
p8hWyPEA7ms+SEulKzzVAfuHmAh7xOiZmGigUT8Ocs2Ykuz8ZQ1XvsCbI/t4liIG
HWChqmW+qD4M3Lmgj0geBl2mBPO1hyhUO+OsfKjVoljALe8gDwgCoipslnnHt5wn
cwqu5iKDoQs=
=J2Np
-----END PGP SIGNATURE-----

--tk6QM1MMR8QQKbMj--

