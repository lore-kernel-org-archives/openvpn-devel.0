Date: Fri, 2 May 2014 09:23:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140502072322.GT16637@...1296...>
References: <535ECBB0.2060709@...1901...> <5362D3E9.3090001@...1114...>
	<5362FA6D.904@...1901...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KGt0Im7S7Eoj4IjE"
Content-Disposition: inline
In-Reply-To: <5362FA6D.904@...1901...>
Subject: Re: [Openvpn-devel] [Openvpn-users] [PATCH] Add support for
	specifying the syslog facility, as requested  in trac #188.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timothe Litt <litt@...1901...>
Cc: openvpn-devel@lists.sourceforge.net

--KGt0Im7S7Eoj4IjE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(why is this being discussed on -users?  Taking it over to -devel)

On Thu, May 01, 2014 at 09:52:45PM -0400, Timothe Litt wrote:
> e.g. the following are valid:
>           --daemon
>                     Daemonize, use the default progname (from PACKAGE)=20
> for syslog
>=20
>           --daemon my-vpn-daemon
>                     Daemonize, use "my-vpn-daemon" for the syslog prognam=
e.
>=20
>           --daemon [local1]
>                     Daemonize, use the default progname, use the local1=20
> syslog facility (unless --syslog-facility already specified one)
>=20
>           --daemon my[local1]-vpn-daemon  --daemon=20
> [local1]my-vpn-daemon --daemon my-vpn-daemon[local1]
>                     Daemonize, use "my-vpn-daemon" for the syslog=20
> progname.
>                                          Use the local1 syslog facility=20
> (unless --syslog-facility already specified one)

Uh.  Feature-NAK - especially the last one really makes me want to throw up.

Using [] as part of an option string is a bad idea, because it is commonly
used for optional arguments (as you saw in David's question), and intermixi=
ng
option argument "A" and "B" in the same string is not going to help anyone.

If we take this at all - and I have reservations, because the amount of
code it brings in is quite significant - it should not touch the --daemon
command line.  It brings it's own config statement (--syslog-facility),
so there really is no reason to mess up the syntax for --daemon.

Also, --syslog-facility should be more clean, like

 --sysloc-facility facility [progname]

with "progname" actually being *optional*, not "marked by using rectangular
brackets".


[..]
> As I explain above, this is to make it possible to specify a facility=20
> name in cases where the system init script uses --daemon before the user=
=20
> can put a --syslog-facility.  --syslog-facility must precede --daemon or=
=20
> --syslog because the latter two immediately switch logging to syslog;=20
> they are what consume the facility code when they call openlog().
=20
Init scripts can be adjusted.   Obscure code inside OpenVPN stays forever
(guess why the developers have so little time?  right, maintaining stuff
that someone else considered "a clever hack" 5 years ago).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KGt0Im7S7Eoj4IjE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU2NH6qkuBuNlUUl1AQL0dQP/dhqlefEiE9DFOYkHMA70uBlg6qNKPBJ6
nuWP5usteHI8qH/OpUgcZ7oj476Ic3r4gjmVcX6LfGHP6MQROeVT5+rnM0JRpmUa
oJFAM+GJV20zHGv8vYA+dYWxhZR7vVM8M+esY/cpGsGB5hmtZjEOzW31RHwoJr9z
YTck8bZ9LGo=
=EY50
-----END PGP SIGNATURE-----

--KGt0Im7S7Eoj4IjE--

