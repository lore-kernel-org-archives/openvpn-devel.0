Date: Tue, 12 Jun 2018 11:27:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180612092730.GZ57262@...1296...>
References: <20180608052017.6696-2-a@...2181...>
 <20180612074240.18865-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1Morrmav4zT5FEml"
Content-Disposition: inline
In-Reply-To: <20180612074240.18865-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] tun: ensure interface can be
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
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>

--1Morrmav4zT5FEml
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Tue, Jun 12, 2018 at 03:42:40PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> This change ensures that an interface is properly brought
> up even when only IPv6 settings are configured/pushed.
>=20
> At the same time, the do_ifconfig() function has been rearranged by
> splitting the logic into a v4 and a v6 specific part. Each part has
> then been moved into an idependent helper that can be invoked as
> needed.
>=20
> This makes the code easier to read and more "symmetric" with
> respect to the two address families.

Thanks for the update with a somewhat more verbose commit message, and
including the "changes from v2" bit.

Most of the changes are good, so "close to ACK"...


Staring at the resulting code, I saw something I hadn't noticed in v1/v2 -
"MTU handling".  For example, on Linux with IPROUTE, we now call this
twice, once for IPv4 and once for IPv6

    /* set the MTU for the device and bring it up */
    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, ifname,
                tun_mtu);
    argv_msg(M_INFO, &argv);
    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");

not sure if this has adverse effects, but it looks a tad silly in the
logs...  other platforms just set the MTU in the actual "ifconfig" call
(if at all) so it's no new calls.


Another thing I noticed is that we really love to set tt->did_ifconfig
(in every single platform branch in do_ifconfig_ipv6()) - maybe that
one should be *renamed* to did_ifconfig_ipv4, and set only once...


... and of course close_tun() (all of them) needs to be adapted for the=20
ipv6-only case.  It currently does cleanup at program end, and that depends=
=20
on "tt->did_ifconfig", which is only set of there is IPv4...

Looking more closely at Linux' close_tun(), I think tt->did_ifconfig can=20
just go, and be replaced by=20

  if (tt->did_ifconfig_ipv4_setup)
    { cleanup ipv4 }
  if (tt->did_ifconfig_ipv6_setup)
    { cleanup ipv6 }

(in each close_tun() function, for all platforms that have cleanups)

The idea behind tt->did_ifconfig seems to have been "only cleanup for
those platforms that actually have an ifconfig strategy" - but since
nobody except linux close_tun() ever *looks* at tt->did_ifconfig, it's
just leftover bloat.


While at it, we might want to replace the big "if(tt) { ... }" wrapper=20
around most of the close_tun() functions with a quick exit...

close_tun(...)
{
    if ( !tt )
    {
         return;=20
    }



Or if we are daring, with an ASSERT(tt)... not sure if close_tun() can
ever be called without a valid tuntap pointer... - well, the normal
caller of close_tun() is "do_close_tun_simple()" in init.c, so we could
just move it as "if(c->c1.tuntap) { close_tun(c->c1.tuntap); }" there...
(there are also tuncfg() and solaris_error_close(), which both have=20
a valid tt, always).


Reading through this, I think it would make sense to have a "0/8" pre-patch
that gets rid of tt->did_ifconfig and gets rid of the if(tt) indentation
in close_tun(), and then rebase 1/8 on top of that, and add ipv4/ipv6
differenciation to close_tun() where needed.


Anyway, at least the interface address removal bits need a v4 of this=20
patch...


> Cc: Gert Doering <gert@...1296...>

And please no cc:' to me in commit messages - it slightly annoys me to=20
receive mails twice with different headers, and serves no useful purpose.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1Morrmav4zT5FEml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbH5IBAAoJEB2Cnv7KVigSzoML/RSXWLNLZWvAxp2raJc2OEQm
MVJxZj+P13pyx/zjpcgxqdOlJVwd6BoimpZftP6lfXyzIW6FfrEN0zZnA2CFPcao
v+yzUjji0uRHbbhfSrlAYRXzS6mx1RZCvrgli6drc95r/BjKw0h5tCI5Z1kKunBh
j+UYNTNzKMQ5PEY3pWOPywRrJmGyCZJn3g7bSpVpwErJK2IPjmQSafFePfFx+Px6
O84Tk/KerbHv+7IgUp8wgJ8wY2P+KQZNdfQKe6Y926i1XsatfQD64fhkD0QgK2kh
TSLpI3m+cHEk1U5RVWvw67v1P7Wx+MYOvcHPL4nt0rXGMZOXFcFPmnIryqePEQZy
PboseYVhQiRzXBH+wW5SjWwWTg/q9ACinLz2gV73qlci27P5jBirlslgSucjl/wD
EMOHJf5yUdg31Twr+zdhnqIA5dEGHioz/fr2cMP1Ih9NCE3xbWkuguzv3etSLWy1
inAlafFucXNadPqySdSnu37pz6MemcvvS7SrTmWW3g==
=2WMa
-----END PGP SIGNATURE-----

--1Morrmav4zT5FEml--

