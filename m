Date: Sun, 17 Jun 2018 21:15:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180617191500.GY57262@...1296...>
References: <20180612074240.18865-1-a@...2181...>
 <20180613135516.5614-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZTHbbs+MWzvHIsK/"
Content-Disposition: inline
In-Reply-To: <20180613135516.5614-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4 1/8] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--ZTHbbs+MWzvHIsK/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 13, 2018 at 09:55:16PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> This change ensures that an interface is properly brought
> up and down even when only IPv6 settings are configured/pushed.
>=20
> At the same time, some code restyling took place to ensure the new
> generic logic is easier to read. Both do_ifconfig() and close_tun()
> (Linux only) functions have been rearranged by splitting the logic
> into a v4 and a v6 specific part. Each part has then been moved
> into an idependent helper that can be invoked as
> needed.
>=20
> This makes the code easier to read and more "symmetric" with
> respect to the two address families.
>=20
> Trac: #208
> Signed-off-by: Antonio Quartulli <antonio@...515...>

Thanks.  Can I have a v5, please, that has been buildbot-compile-tested...?

This version breaks OpenSolaris, as

> +#elif defined(TARGET_SOLARIS)
> +    argv_printf(&argv, "%s %s inet6 unplumb", IFCONFIG_PATH, ifname);
> +    argv_msg(M_INFO, &argv);
> +    openvpn_execve_check(&argv, es, 0, NULL);
>=20=20
> -        if (tt->did_ifconfig_ipv6_setup)
> +    if (tt->type =3D=3D DEV_TYPE_TUN)
> +    {
> +        const char *ifconfig_ipv6_remote =3D print_in6_addr(tt->remote_i=
pv6, 0, gc);
> +

... this has to be "&gc"...  so, I do understand that you really do not
like this line, but please...=20

Besides this, I've not only compiled but actually tested IPv6-only mode
on Linux (Gentoo), FreeBSD (10.4), NetBSD (7.0), OpenSolaris (with the
trival patch), OpenBSD 6.0, MacOS X (something current, Arne's box).

Haven't tested Windows yet as we know it will not work until 2/8 is merged
(IPv4-only or IPv4+IPv6 is expected to be unaffected) - but it builds=20
fine, so no larger accidents.


All the other code changes look reasonable ("git diff -w --color-moved=3Dze=
bra"
plus "visually comparing with a pre-patch tun.c").


Since we're a bit strict about code changes that are bigger than whitespace
and comments... can I have a v5, please?

gert

PS: Side note 1: MacOS is actually slightly strange and needs repair - the=
=20
call to (e.g.) "ifconfig utun1 delete" actually doesn't "delete" anything=20
but tries to find a host named "delete" and ifconfig it on "utun1"... but=20
this is old stuff which propably worked 5 MacOS versions ago...  and the
on-link route might also no longer be needed.  Need to test this on "more
MacOS versions", plus look at the MacOS patch that is lingering on the
list...
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZTHbbs+MWzvHIsK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbJrM0AAoJEB2Cnv7KVigStlYL/3hONHuBLuVB2l0dKSdxGijH
tc40UFCFVN4NsL8XDsMgAMJ037FKR+ryAMqny0YBrulchYw8UM96TD46eNxpHA+A
sda31AP6eWsPYda2ouQ3uwJc31Urp85xXVv/DOAKy8Pxv3Xvx3gTrNNsPotpLzJL
ckHDN35IzuQAunCIlPSJol5lQ3tKAZEAQ8+OfmH1QAOqWoAG849AWfjttgDUN/tb
9KvEbbFekKLSH0ZbsxOnbTWuiWhiTXIKj4Ia7QJfi/H09qU57zoPQuDioLarjFdH
mx6IBG2jmDVtoiM+W9hZBzQHBkX3+BfdnZIKlIXKDRGzDnN9NEdI8agENOzogwsp
zxsMzCJExPDkwma77sHEIOpZF+CZU3xsFWgUhpDz6RNW6dYV+vMWIPeTJaCkwBEd
LEzw2hxT3w51uYz/Z+qSxqcKrmi4C8DjINvoy61T5gkiq6xnTzTyfh4lh/82d5w6
JAPxNSuALzup9iMX7MSENzp2inzPYcw57VE/+pIEag==
=Seu7
-----END PGP SIGNATURE-----

--ZTHbbs+MWzvHIsK/--

