Date: Wed, 28 Mar 2012 19:16:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120328171611.GH1359@...1296...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332797200-9295-7-git-send-email-alon.barlev@...277...>
	<4F72CE7E.90704@...1114...>
	<CAOazyz1+EhRwVUhjm5SSQ9_s8+=5MxMT3ptkt89Pv+jmvY4RZg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fGgPh72jpYMjtj0O"
Content-Disposition: inline
In-Reply-To: <CAOazyz1+EhRwVUhjm5SSQ9_s8+=5MxMT3ptkt89Pv+jmvY4RZg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] cleanup: ~0 is too large for 32bit
	ipv4 address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--fGgPh72jpYMjtj0O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 28, 2012 at 11:03:43AM +0200, Alon Bar-Lev wrote:
> 0xffffffff as-is is valid ipv4 address/netmask...
>=20
> I found only this warning, if there are more places, I guess these
> needs to be fixed as well. So if you agree to the above, I will find
> the other places.

I'd opt for having a well-understandable define, like

#define IPV4_NETMASK_HOSTONLY 0xffffffffU

(note the "U", that will make sure all compilers know "hey, unsigned!")
and use that constant in places that use ~0 today in this very specific
meaning.

A quick grep turned up places in pf.c, route.c (where some places actually
seem to mean "-1", like in windows-route_find_if_index()?!?), tun.c

I'd rather not tackle "those other places" in this go, just the "this is
a host-only netmask!" bits.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fGgPh72jpYMjtj0O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3NHW6kuBuNlUUl1AQJdQwQAqoFeabJEYPx4RI4wBR3W9BB45kqSEWDw
2tTuBWSckf56/rVwF8bsksLPP1whIlw3xBJIfwvGr5kLSfFb8tpJ+g2fkmxXTNS8
/MGfn7EdtFxgpGoyr8lA6GfYlSjqK+jX58SEbmsRyjuyJHvCIK3UvTTYDDd/EiUG
wxo8GcXxxwM=
=M4lE
-----END PGP SIGNATURE-----

--fGgPh72jpYMjtj0O--

