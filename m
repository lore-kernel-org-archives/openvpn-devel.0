Date: Sat, 26 Feb 2011 11:45:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110226104526.GT9835@...1296...>
References: <AANLkTikHd0G_8-JAkXTojetsG7-w5TV3j9fdUwx309A+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <AANLkTikHd0G_8-JAkXTojetsG7-w5TV3j9fdUwx309A+@mail.gmail.com>
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

--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 26, 2011 at 10:05:58AM +0000, Olivier Van Acker wrote:
> Are there any plans to support the sctp protocol in openvpn?

I would find that a useful thing, but admit that I have only theoretical
knowledge about SCTP (and have no time to work on it).

The code parts in question inside OpenVPN (socket.c) are somewhat
complicated due to lots of existing options and lots of existing=20
operating systems being supported, so this will not be a trivial
task.

What I'd definitely recommend to do is base your work on JJO's IPv6=20
transport patches, because he already changed large parts of socket.c
- so if you base your work on "plain 2.2", there will be endless conflicts.

(Personally, I hope that such an overhaul of socket.c would bring in
functionality to listen on multiple sockets in parallel, like "listen on
udp/1194 for normal connections, plus tcp/443 for those behind too-strict
firewalls").

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTWjZxqkuBuNlUUl1AQKVlAP/bhUxqybw5Hg0WBZ3UJXCn/X9t+cN+Mk6
g73s9RMV8iF/+hJtVF9tzUN4nBf5g/X17eoc4Qiq8XA46d40B5qBjjmMLR8+YZed
SBlZbdEnW81FwtmVRFNM56kYpL64ElkuTG/5h7MV9LSzse+0Az+zbQkvxgzK74h6
WU0lGgKNfcw=
=HCA4
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--

