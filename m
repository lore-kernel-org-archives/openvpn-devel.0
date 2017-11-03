Date: Fri, 3 Nov 2017 20:09:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171103190946.GU958@...1296...>
References: <20171005232542.30007-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NphB68aIrRU2wdue"
Content-Disposition: inline
In-Reply-To: <20171005232542.30007-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] man: Describe --proto options better
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--NphB68aIrRU2wdue
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 06, 2017 at 01:25:42AM +0200, David Sommerseth wrote:
> The --proto options changed a bit in OpenVPN v2.4.  This tries to
> expand this section, explaining the new variants and how they
> related to older OpenVPN versions.

As discussed on IRC, this is not fully right yet.  I'm somewhat too
lazy to write up a proper patch, so I'll just write it up again.

Client and server are slightly different, as are 2.3/2.4.  So:

 client/2.3
    --proto udp/tcp    -> IPv4-only
    --proto udp6/tcp6  -> IPv6-only
       (no way to get "use what the server advertises in DNS")

 client/2.4
    --proto udp4/tcp4  -> IPv4-only
    --proto udp6/tcp6  -> IPv6-only
    --proto udp/tcp    -> "ask DNS, and try IPv6 and/or IPv4, whatever
                          comes back from DNS and works"

 server/2.3
    --proto udp/tcp    -> IPv4-only
    --proto udp6/tcp6  -> IPv6-only *or* dual-stack, depending on=20
                          "net.inet6.ip6.v6only" sysctl (1 -> ipv6-only)

 server/2.4
    --proto udp4/tcp4  -> IPv4-only
    --proto udp6/tcp6  -> dual-stack or IPv6-only, depending on the
                          setting of "--bind [ipv6only]" (default is dual)
    --proto udp/tcp    -> "ask getaddrinfo() what the recommended value for
                          a listening socket is, and use that" - this can
                          result in an IPv4-only (INADDR_ANY) or an IPv6/
                          dual-stack socket (IN6ADDR_ANY_INIT)

                          So, for best results, use "udp6/tcp6" on machines=
=20
                          that have IPv6 active, and only fallback to "udp/=
tcp"
                          when you *know* that udp6/tcp6 isn't working (e.g.
                          because some smart guy removed ipv6.ko from the=20
                          system).

The slightly undefined behaviour of the 2.4/server side wrt "udp/tcp" is
something we should fix to always get dual-stack unless that fails, and
then fall back to IPv4-only - but that's slightly complicated (socket.c)
and needs lots of cross-platform testing, so "nobody has done it yet"

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NphB68aIrRU2wdue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ/L76AAoJEB2Cnv7KVigSCx8MAJqmJc8SeEeWiH0BuClTXC4a
EIvWcXiwzleIIqHnVMLQryNSOIPslRERdSegL3Row3o4MO+0qIIdOzI6WgHR9IAv
QwbtdcyvoXL6vafABlQnF+Px0nOetp54qA7ppM+a0DVcjWSgseMxQDHMFj1aPgzf
ifGm/5Xp3uMKtO7WqD1Owd20D1is9jqtfvM5T7Os5SW9KIvG7Je7BeyLKmmUGYn9
11WhLvhh16Qj+FUaNcTmXarYbDEpoHQizlJ6hdLgyB73Eal7DBzCbF52DfFpphb7
SRlQ9DS+v5EZRarGknEWu+Goq7ckceOt+S/GLBBdSHFbUoMoqdcS1p9xR4J+bvgS
AFKIyV/5hGtDaBgb+R6HZllpOSA2sw45jxN+Eslb1sHi3S2lX4x8JBGYyd5tC4El
Zat7Dj3ijG5S3snkILEPx9iqnYmlDb/fh4qRdlrVu2l97fAIAEaQUvmyS3hnj6wg
mzkf5Mg2zzQrt+5id0r5Slnbic5yEVtRz7zbYzqiDQ==
=Mr9c
-----END PGP SIGNATURE-----

--NphB68aIrRU2wdue--

