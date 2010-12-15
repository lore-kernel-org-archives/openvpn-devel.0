Date: Wed, 15 Dec 2010 09:56:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20101215085647.GY12709@...1296...>
References: <AANLkTimYvqT7KLT0bwJQzMmNC2vcnbBaZY7NEN36JvAD@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fzZfjcV6kaBgkq89"
Content-Disposition: inline
In-Reply-To: <AANLkTimYvqT7KLT0bwJQzMmNC2vcnbBaZY7NEN36JvAD@...278...>
Subject: Re: [Openvpn-devel] Getting src-IP/port from 'struct context'...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vineet Kumar <vineet.kumar@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--fzZfjcV6kaBgkq89
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 14, 2010 at 03:16:53PM -0800, Vineet Kumar wrote:
>   Is there a straightforward way to print source IP address and port
> given a 'struct context' pointer?

If I read code and structures right, it's in

  context_pointer->c2->to_link_addr->dest

and there's a number of calls in forward.c that do:

  print_link_socket_actual (c->c2.to_link_addr, &gc),

(which doesn't actually *print*, but return a string that can be used
in msg() - see the code examples in forward.c)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fzZfjcV6kaBgkq89
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTQiCz6kuBuNlUUl1AQLF3QP7BoHoK3pbyCuq7ttOUSdUk9NPXFoO+oc5
RiJSHV9Tn2Xjzv3ICYxABqP+cBrAs19L4mGT4M3cU/4m85WOmKQ1uql+NZw/CpQP
HPRImL3PkKGcRJF7CVreqN1fXkb1MjuzZj2Auru6VcW1XiDuNp1/D5STJW6Fd/Ic
gxdThWVE7I0=
=vK/u
-----END PGP SIGNATURE-----

--fzZfjcV6kaBgkq89--

