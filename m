Date: Sun, 26 Feb 2023 11:02:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y/suKJIyDKICDxXu@...1296...>
References: <20230130172936.3444840-1-arne@...1227...>
 <20230130172936.3444840-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uBBTh+8NfYLNYWr7"
Content-Disposition: inline
In-Reply-To: <20230130172936.3444840-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Fix unaligned access in
 macOS/Solaris hwaddr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--uBBTh+8NfYLNYWr7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 30, 2023 at 06:29:33PM +0100, Arne Schwabe wrote:
> The undefined behaviour USAN clang checker found this.
>=20
> This fix is a bit messy but so are the original structures.

I wonder...

> +                    struct sockaddr_dl sdl =3D { 0 };
> +                    memcpy(&sdl, &ifr.ifr_addr, sizeof(ifr.ifr_addr));
> +                    memcpy(rgi->hwaddr, LLADDR(&sdl), 6);
>                      rgi->flags |=3D RGI_HWADDR_DEFINED;

... why you keep the "sockaddr_dl" intermediate - this was useful
for "we use it as a pointer", but doing two memcpy() with a huge
explanation above looks weird.

LLADDR on FreeBSD is

#define LLADDR(s) ((caddr_t)((s)->sdl_data + (s)->sdl_nlen))

(to operate on a "struct sockaddr_dl")

struct ifaddr has=20

struct ifaddr {
        struct  sockaddr *ifa_addr;     /* address of interface */
        struct  sockaddr *ifa_dstaddr;  /* other end of p-to-p link */
        struct  sockaddr *ifa_netmask;  /* used to determine subnet */

... so the first memcpy() isn't actually copying the MAC address around,
just a bunch of pointers, and then we dereference the first of them
for the second memcpy(), using the dereferencing macro for a=20
"sockaddr_dl" structure.

FreeBSD also has

#define IF_LLADDR(ifp)                                                  \
    LLADDR((struct sockaddr_dl *)((ifp)->if_addr->ifa_addr))

which sounds like "feed in an *ifr, out comes a pointer for the
memcpy() to rgi->addr".


I'll check the other BSDs if LL_IFADDR() is available everywhere, but
if not, we can just do the same thing (struct ifr is aligned) and
get rid of the "sdl" and the first memcpy().

(Am I overlooking something?)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uBBTh+8NfYLNYWr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj+y4oAAoJEB2Cnv7KVigSd2cL/AzP4SufF9uheLQXnkIOsnEM
dZlKF+WsoaIgj/SYu9dlCyJfy+jeSjqSY77OE/8szs4HFSwaZX5H2XycDaGwdsG1
qd1TtIaIVhYelMdletLV7qGOdYPc3bVQpr76WzarlKPsw9a0e4feA0De86ZK/AZJ
xv/w1Mwt+daFTVFBPtxWxYqPeKPCimoTZQIvG/gsjm/raHRChMl2dNlsuput4win
lVZuuWD2g/okASzPCsrv2/+1JOggh0DXtAOpJ/oycEr2loM+pR6+QBWyb02XjW+1
0qSgPJ1lGrPX6jkl1Wht8zGzZnPfyW23aWkyHtSr8nPzVnwePGcMANm5AjmHlieZ
ToHO9Y7j7PdovTDrGdHbdpqxyKmV740U0AkoHl5T3UEwzWCIUzisTyxQS/MhFS5y
MGQ6MoFealN5vcfapMkJzqiZtt2YzTm+nIHKz5QQ9PJJNkbaUSJbuLuXoTcbCCOK
1dKZkOzZYQB0JDhm+xAfLU7NFsBhpL8saNH1cDhg2Q==
=rlPL
-----END PGP SIGNATURE-----

--uBBTh+8NfYLNYWr7--

