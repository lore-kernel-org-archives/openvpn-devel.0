Date: Sat, 20 Aug 2022 23:02:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwFL9rEyCr+RfaaV@...1296...>
References: <20220810153006.18860-1-maximilian.fillinger@...2507...>
 <202208191704.27JH4qSZ095097@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FcgQBLzIYRJlNGQ1"
Content-Disposition: inline
In-Reply-To: <202208191704.27JH4qSZ095097@...2054...>
Subject: Re: [Openvpn-devel] Followup work on "Don't undo ifconfig on exit
 if it wasn't done"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--FcgQBLzIYRJlNGQ1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 19, 2022 at 07:04:52PM +0200, Gert Doering wrote:
> The change is as we have discussed, and I still think it's a good and
> clean way forward.  The "undo_ifconfig_ipv4() / _ipv6()" functions
> are as they have been before (except that they now get compiled for
> all platforms except WIN32 - the "linux only" part was a 2.5.0 oversight),
> and the calls moved 1:1 from (TARGET_LINUX) close_tun() to a new
> undo_ifconfig() function.  tun.c is still a mess, but this helps a bit.

I did lots of testing on FreeBSD today, and it turns out that the
generic "undo" code is just a mess and clutters the log with garbage...

2022-08-20 22:58:02 /sbin/ifconfig tun4 0.0.0.0
ifconfig: ioctl (SIOCAIFADDR): Destination address required
2022-08-20 22:58:02 Generic ip addr del failed: external program exited wit=
h error status: 1
2022-08-20 22:58:02 /sbin/ifconfig tun4 del fd00:abcd:194:2::103d/64
ifconfig: del: bad value
2022-08-20 22:58:02 Generic ip -6 addr del failed: external program exited =
with error status: 1

... not Max' fault, but I wonder if this ever did something useful...

(I'm fairly sure "set ipv4 address to 0.0.0.0" was a valid way to undo
IPv4 ifconfig, but I do not think "del" was ever a valid ifconfig IPv6
syntax on *BSD)

So - this needs fixing, and platform-by-platform testing...

Technically, for most cases this won't be actually needed - if the
tun/tap interface is destroyed at program end ("ifconfig tun4 destroy"),
the IPv4/IPv6 config is gone anyway.   Only for persistant interfaces
it makes a difference.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FcgQBLzIYRJlNGQ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjAUv2AAoJEB2Cnv7KVigSii8MAJbq8Z5tcErkM4NKpNbK7pkE
PmtKlsBzijG61SVeTB0s587imUwIFNZRmDg9eQ4vIYuoZeZe/UqcAILCC05obCza
Tq30vdW9sOg5mhgroPtdr0kxS9TMt6vU7ZrTotbWUkhg8wHbnNRcxTevorJXJwQz
l9UHzjHgeO7PCxQbJeWtiIZgXikBAzXMpT/jNWPvvPX9XLMXqTTAUV+mCWwjF5Cg
ANutU9lwDjkjdmvIILZasNR2ErFr4++y9W6ovQuFwDBWE0mmMYxBJzAR8oo7ww/m
f3wQXXP3x2ZsxtUjzgcINGxYZmGne3JRhbVAYM8Sya8goB6XaysQOCw0PbhAxtoz
l9CK9UZ0f0g7t/ZJxchvtckbeJkAeYIt9S43aSWfH0Nu8EEEW6eU42fdEc7wATIU
7ML7ZCS/vmYpuleWYtqd9IQsgamvLNsp8GZE8596YabRYlqJaOiSsGmwbKRFoZNQ
i0B9EZeypBqZ7oybtU95udhF3x6LFhO+jffATVexwQ==
=0GHM
-----END PGP SIGNATURE-----

--FcgQBLzIYRJlNGQ1--

