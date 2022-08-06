Date: Sat, 6 Aug 2022 16:20:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yu54qgtQzBvK0hJ3@...1296...>
References: <20220629170555.116087-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="V1kMJ1WqZJeML5Uw"
Content-Disposition: inline
In-Reply-To: <20220629170555.116087-1-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [Patch v5] Don't "undo" ifconfig on exit if it
 wasn't done
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--V1kMJ1WqZJeML5Uw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Wed, Jun 29, 2022 at 07:05:55PM +0200, Max Fillinger wrote:
> When running with --ifconfig-noexec, OpenVPN does not execute ifconfig,
> but on exit, it still tries to "undo" the configuration it would have
> done. This patch fixes it by extracting an undo_ifconfig() function from
> close_tun(). The undo function is called before close_tun(), but only if
> --ifconfig-noexec isn't set. This is symmetric to how open_tun() and
> do_ifconfig() are used.
>=20
> v2: Fix tabs-vs-spaces.
> v3: Fix another style mistake.
> v4: Move undo_ifconfig{4,6}() out of #ifdef TARGET_LINUX.
> v5: Keep ctx argument in close_tun().

I did what I promised too many weeks ago, and pushed this change
towards the buildbot army...  alas, they did what I was afraid they
would do: complained.

+-DPLUGIN_LIBDIR=3D\"/usr/local/lib/openvpn/plugins\"  -Wall -g -O2 -std=3D=
c99 -MT
+tun.o -MD -MP -MF .deps/tun.Tpo -c -o tun.o tun.c
tun.c:1656:73: error: passing 'struct gc_arena' to parameter of incompatible
+type 'struct gc_arena *'; take the address with &
    const char *ifconfig_ipv6_local =3D print_in6_addr(tt->local_ipv6, 0, g=
c);
                                                                        ^~
                                                                        &
./socket.h:391:88: note: passing argument to parameter 'gc' here
const char *print_in6_addr(struct in6_addr addr6, unsigned int flags, struct
+gc_arena *gc);


so the "non-linux" bits of undo_ifconfig_ipv6() have been broken since
ever - but the patch now actually shows that to the compiler...

> +#elif !defined(_WIN32)  /* if !defined(TARGET_LINUX) && !defined(_WIN32)=
 */
> +    struct gc_arena gc =3D gc_new();
> +    const char *ifconfig_ipv6_local =3D print_in6_addr(tt->local_ipv6, 0=
, gc);
> +    struct argv argv =3D argv_new();

... and inded, this needs to be "&gc"...


Can you please send a v6 that changes this, and also rebases against
master?  The context has changed a bit, and one hunk (#endif /* comment */)
is no longer relevant, as that #endif never came into existance :-)

We should then be able to proceed more quickly...

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--V1kMJ1WqZJeML5Uw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi7niqAAoJEB2Cnv7KVigS04cMAKiYVqgOjp9JH0aQqNNY74mU
F21lZhTZcFlDrbkp6V808Rnon4cwFSNbmf7gcz1G0STB4RLRd7SFDDOvMnXGO3lY
cDLljikr0b1EmLfk1AQIfj6n8D4WnbbQcIdOb8VH2SOmj278b09VnNgoZQRpfWQE
QFA+QHY9P2fuQHC+IOHsC6Zcn1bSZ1MbIAlUfioo73NChHkGqwFKPAr72kVJylhU
Q2KUZK/AY5K3tBXb/s229kJOS4zo0/11sX4eTUB7R8U+bhcNxiK6zZFdwo+XV9Rx
KLLoACHqdEPaAjMrVdsLqOITJmtrZB+BHq2KC3e94bwyjAsq+sMs9wXhMwG1H/Xl
aQE/QMaAjUvgxjcoHRxVKxiIexe/DwGcMN6kShauEbo7UwS+WU1h4NwOJqDkB+tq
vZgSqUSJO7Qh2JSxxa8gQqT/K3lw8Ice1z8jwXwi52tEWK4sPGUqwOJq3ZHwh+4h
F373Uha/piDMBLA3oliAWgz2Munlwte2UIrYwtd9tA==
=sHoS
-----END PGP SIGNATURE-----

--V1kMJ1WqZJeML5Uw--

