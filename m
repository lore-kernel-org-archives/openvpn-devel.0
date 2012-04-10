Date: Tue, 10 Apr 2012 10:04:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120410080400.GQ1359@...1296...>
References: <4F7DA7EF.1010709@...515...>
	<CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
	<CAHyOtRmSpUxdtGeFYbu=CQ-erZMS54hXG9zxOC=cDO9vXnBn0A@...278...>
	<CAOazyz0WbwVO4QGDomZWycfwhmb_eHHVZpyQqpD0FDOqpt+1Xg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BhCmZxNx01sRldsR"
Content-Disposition: inline
In-Reply-To: <CAOazyz0WbwVO4QGDomZWycfwhmb_eHHVZpyQqpD0FDOqpt+1Xg@...278...>
Subject: Re: [Openvpn-devel] ACK system review finished
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Adriaan de Jong <adriaan@...1475...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--BhCmZxNx01sRldsR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 07, 2012 at 07:30:42PM +0300, Alon Bar-Lev wrote:
> Gate keeper of what? See the recent merge of polarssl, unicode and
> IPv6, these are all none clean in term of implementation, David done
> his work, merging whatever ACK, but this ACK system lead to even more
> complex OpenVPN implementation, not that the legacy OpenVPN was
> perfect, but I would have expected new functionality to not make
> things more complex.=20

As for IPv6 payload, if you double functionality, you can't expect complexi=
ty
to "not go up".  It's a different network protocol that needs to be handled
very differently, and there is not much that can be shared with IPv4 as
far as routing, interface config, config file parser, etc. goes (and every
single supported operating system uses a different ifconfig/route style...)

As for the actual implementation of the IPv6 payload stuff: it's closely=20
following the IPv4 code style, with as little intrusive changes as possible.

Of course it would have been possible to rewrite larger chunks of stuff=20
- leading to "it is never finished" and "it will be much harder to merge=20
due to people not being able to see what is new and what is old".

> This system is not working, it is not too late to
> realize that and decide how to proceed.

The current system is working quite well.   A number of important features
that people have a need for *TODAY* (not "when it's perfect, in 10 years
time" - actually, the IPv6 stuff was already needed 4+ years ago) got in,=20
and stuff has been tested quite thoroughly, thus not creating new breakage.

If anything, we're not following the Open Source mantra "release early,
release often" close enough.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BhCmZxNx01sRldsR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT4PpcKkuBuNlUUl1AQKNPAP7BVHmUQxUFtcnEQ1gLK2lCfhjhpV4AGJ0
si911+GJVXMQ43N7xO0OoBqOfEjl41NQWhEYKjzU6dXuXsd74GhJwcJBwmXofRzk
rR/v4wmhk+kKe8m/7U+0r8qY9OThMDj6ycauhJTBxwYWB/TIgSRfm1jxfBgcJXBj
G6ouaG//6nk=
=9JGy
-----END PGP SIGNATURE-----

--BhCmZxNx01sRldsR--

