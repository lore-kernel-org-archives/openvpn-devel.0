Date: Fri, 24 Oct 2014 11:15:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141024091528.GZ396@...1296...>
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
	<20141023192811.GU396@...1296...>
	<CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>
	<20141023211259.GV396@...1296...>
	<CAAA5faFzhCkqxe4j24C25b8JaLSgj2HeD5s2i31Em-UQOPURAg@...278...>
	<20141024054814.GX396@...1296...>
	<CAAA5faFEzEUdfixd5bhTY_9wg49VxCO+ZRWHMtoqJ07g6ouDmA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EEnv9zyGND1dPpWR"
Content-Disposition: inline
In-Reply-To: <CAAA5faFEzEUdfixd5bhTY_9wg49VxCO+ZRWHMtoqJ07g6ouDmA@...278...>
Subject: Re: [Openvpn-devel] man page and options.c contradict
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Reinoud Koornstra <reinoudkoornstra@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--EEnv9zyGND1dPpWR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 24, 2014 at 01:04:17AM -0600, Reinoud Koornstra wrote:
> I understood the term mode wrong.
> So the main mode can be p2p or server to denote the openvpn protocol insi=
de
> tcp or udp(stateless) session. Initially I thought the term mode is used =
to
> denote server, client or udp.

OpenVPN has the modes "peer2peer" or "(multi-)client to server".

The "client" mode differs from "peer2peer" only insofar as it expects
to receive confings from the server, while the "server" mode is intended
to handle multiple clients, send them configs, and so on.


If you run OpenVPN as "--server", it will also default to "--tcp-server"
if you only tell it "use TCP", because it knows that tcp-client is not
useful in OpenVPN server mode - but that's just a shortcut to ease the
config, and it can be a bit confusing, yes.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EEnv9zyGND1dPpWR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEoYsKkuBuNlUUl1AQJJTAP/UJWLz8LgUh54SFRm2mp4vvHST8i3KWcQ
c0HY9e7765rF1xnhcXOoGlfP69xji1N3Xp1VIoeliMP8SdNYEQoN095IR0BNsvvm
axdPxwbI2sjKWW1CjortzVbfjAHmxejJXLiXccIw2gGhoJ3coLkuMZaBn0LvJb5r
RY6xlNMtZ5s=
=qgQQ
-----END PGP SIGNATURE-----

--EEnv9zyGND1dPpWR--

