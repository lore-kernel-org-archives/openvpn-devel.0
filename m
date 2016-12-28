Date: Wed, 28 Dec 2016 22:03:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161228210345.GM78624@...1296...>
References: <20161228130721.683-1-list@...1798...>
	<20161228185700.GJ78624@...1296...>
	<20161228203748.3ef54708@...1799...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1NucUmLGa7VWJfBD"
Content-Disposition: inline
In-Reply-To: <20161228203748.3ef54708@...1799...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] fix timeout in non-TLS mode with
 systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--1NucUmLGa7VWJfBD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 28, 2016 at 08:37:48PM +0100, Christian Hesse wrote:
> > We definitely need a better approach than "litter ENABLE_SYSTEMD all
> > over the code".
>=20
> Well, openvpn supports a number of modes of operation... Some of these ha=
ve
> other requirements than others.

This I understand quite well :-)  (look at the discussions surrounding
NCP and poor man's NCP, and why that ended up patch version 7 or so)

[..]
> IMHO we should go with option three. Given the number of #ifdefs all over=
 the
> code - is this really an issue? My patch increases the number of sd_notif=
y()
> calls from four to five.

Especially given the high amount of #ifdef we already have, every additional
one is "one too many" - doubly so for platform-specific stuff in otherwise
platform-independent code like init.c

While technically not "platform", nothing else but a subset of Linux
distributions use systemd today, so I consider this to be in the same
league as #ifdef TARGET_FREEBSD or #if _WIN32, which both should not
appear in generic high-level code.   tun.c, route.c, platform.c are
unavoidably bad...  but this should serve as a bad example, not as=20
"match this!" target :-)

[..]
> For informational purpose we could add even more calls. That would allow =
to
> set intermediate status message, something like: "Up and running, current=
ly
> serving 25 client connections."

True, and I think that is a useful feature - but it needs an abstraction
layer somewhere in between.  Adding #ifdef ENABLE_SYSTEMD all across the
code is something that is not a good approach for long-term maintainability,
and to support *other* interfaces to status reporting - like dbus, or
whatever interesting APIs other operating operating systems come up with
one day .

We already update our status file regularily, so maybe this is a reasonable=
=20
point in the code to abstract out something like "platform_notify_status()"
(or whatever good name you can come up with), which could then go to,
like, "platform-notify.c", and have all the #ifdef ENABLE_SYSTEMD that
are needed.

[..]
> > (Also, this is the wrong check anyway.  p2p mode can go along with
> > TLS just fine - what you need to check for is --server or --client,
> > which is something else than --tls-server / --tls-client)
>=20
> No, the check is correct.
>=20
> In server move openvpn reports ready when it finally is ready to handle
> incoming connections. That is fine.

"server" or "TLS server"?  These are not the same :-) - you can have
p2p mode with --tls-server.

But I'll accept that you're likely right there, and --tls-server reports=20
"ready" when it's set up and ready to go, not having to wait for a packet
from the tls-client - this stuff has bitten us in t_client.rc recently
(p2p startup not reporting "ready!" and t_client.rc then aborting the
test run).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1NucUmLGa7VWJfBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYZCiwAAoJEB2Cnv7KVigSwNML/1F/Z8aFBpWepQZGfudmM109
TWYTTZq3HafBuzm94VCzkjtllO5EvYEwsWId/RNvOSCipEE12P4LbzpGOgXecdO3
MXJ8K/TqzmjS6sbscW48o3n2gOrw57yphZMaT0nMjY0Kcmmu6iKdlHcqCBqmeLJL
KxjIlPC0dwEqNFJceuR3skes4/1YPggrk8s4apTOmWX5BOdk+2nr0WZE4YZyoo/6
H8Y3o7tS0M8K2cSFpPfyxJOBI0ZD2iTx7GdPNRzqDhVEi038WM/0C2vNjXScliAR
ovlMP7DeLVQhyMuy2XYSMDyUjc0eqtx/U/6hP8gV0lwpauA1To+JULTHE4L5hBmT
016VeIwnHZEiy3DxFyYbf6vGAAQXEHbmMLerZ4wSGih6tSXWkgtSaGa1ms54WzA5
wbZDoiW2nOrYrdwiO1G2Cj4sW3dm+b8buF8tqyjlgE2F3yirL8n+1xP1m3SA4Ret
ecLRzKk6ziqIwF+ic2A/WGx6SuaElpxWjXqpMf/o9Q==
=pXJJ
-----END PGP SIGNATURE-----

--1NucUmLGa7VWJfBD--

