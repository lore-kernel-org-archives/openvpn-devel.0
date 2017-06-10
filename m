Date: Sat, 10 Jun 2017 20:11:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170610181126.GN97029@...1296...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
	<CADxRZqwYw0RLxCDB-u3NmrLUBONng5DyT-1e9q-37HDHPpnCrQ@...278...>
	<877f0jvmwi.fsf@...2274...>
	<20170610174642.GK97029@...1296...>
	<8760g3u3m2.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZyxZXZIJnjGEVj9R"
Content-Disposition: inline
In-Reply-To: <8760g3u3m2.fsf@...2274...>
Subject: Re: [Openvpn-devel] Alignement crash on sparc64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Anatoly Pugachev <matorola@...277...>, openvpn-devel@lists.sourceforge.net, Stefan Sperling <stsp@...2273...>

--ZyxZXZIJnjGEVj9R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 10, 2017 at 07:58:13PM +0200, Jeremie Courreges-Anglas wrote:
> OpenBSD:
>=20
> struct ip {
> #if _BYTE_ORDER =3D=3D _LITTLE_ENDIAN
> 	u_int     ip_hl:4,		/* header length */
> 		  ip_v:4;		/* version */
> #endif
> #if _BYTE_ORDER =3D=3D _BIG_ENDIAN
> 	u_int     ip_v:4,		/* version */
> 		  ip_hl:4;		/* header length */
> #endif
> ...
>=20
> u_char -> u_int.  Dunno if it matters to the compiler, I can take a look
> later.

I'm fairly sure it does matter.  An int is likely to be at least 16 bit,=20
maybe 32 bit, so the compiler can assume "word aligned" - and *boom*.

(Wonder why it doesn't crash for Mator, as our buffer alignment in memory
should be fairly consistent - it might depend on crypto and compression
options, though)


> > old:
> >     if (iph->ip_v =3D=3D 6)
> >
> > new:
> >     if (OPENVPN_IPH_GET_VER(*buf) =3D=3D 6)
> >
> > this is an existing macro which takes an int argument, shifting and
> > masking the right bits, and since *buf is "uint8_t *buf", this should
> > both be correct and alignment-ignorant.=20=20
>=20
> See my proposed patch, also in this thread.=20=20

"Copying around 20 bytes to ensure a single-byte access is really a
single-byte access" is definitely *not* the right way here.  So NAK on
that patch.

It will stop the crashes, of course, but since no other parts of=20
struct ip are ever needed, it's just waste of CPU cycles.


> I merely copy/pasted the NetBSD code.

Uh?  Is this from the NetBSD ports tree?  Because our tun.c does not
have a single memcpy() today... :-)

Actually, my tun.c's TARGET_NETBSD version of write_tun() has something
similar to what I suggested:

        struct openvpn_iphdr *iph;

        iph =3D (struct openvpn_iphdr *) buf;

        if (OPENVPN_IPH_GET_VER(iph->version_len) =3D=3D 6)

... slightly more speaking, and since "openvpn_iphdr" is a locally=20
defined structure with "uchar version_len" at the very beginning, this
amounts to the same thing.


> > It might be less efficient than accessing the bit field - but then, it'=
s=20
> > the same work to do, so hopefully the compiler is smart enough to compi=
le=20
> > it to the same instructions.
>=20
> master (32 bits access):
> 0x0000000000081844 <write_tun_header+100>:      ld  [ %i1 ], %g1
> 0x0000000000081848 <write_tun_header+104>:      sethi  %hi(0xf0000000), %=
g2
> 0x000000000008184c <write_tun_header+108>:      sethi  %hi(0x60000000), %=
g3
> 0x0000000000081850 <write_tun_header+112>:      and  %g1, %g2, %g1
> 0x0000000000081854 <write_tun_header+116>:      cmp  %g1, %g3
>=20
> patched:
> 0x0000000000081844 <write_tun_header+100>:      ldub  [ %i1 ], %g1
> 0x0000000000081848 <write_tun_header+104>:      srl  %g1, 4, %g1
> 0x000000000008184c <write_tun_header+108>:      cmp  %g1, 6

Sounds like an improvement, at least in code size :-)  (but I have no=20
idea how the performance of these operations compares)

... and I can see that the "master" version is going to fail on
unaligned packets...  so, needs fixing.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZyxZXZIJnjGEVj9R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZPDZOAAoJEB2Cnv7KVigS8GQL/AoiA0jOaxDmmJylY9QkDoDK
y18EJ+/w2z/Ynl37BKHX/OlU721YGWmkIvmtMbG3tA9LM19jaOXjWWgcSgMzapIq
vBpPuNJXtVYipZwbMfFfRHzhL6aml25HLgmSr0ATEQSS/SjaqB05sRt9s9QE27Hj
2BZSIGUnNB6kGJy2LRZlmsHoM1fAzryet71lH+CGqGo03HQm/bWYRUeVNGDUn5W9
wrBevs2akCH5MmLgb4vKRhdX8psLI+AAKVP8nUFBmAQXoIpOq8ssVOotk+3Q1/pz
QU92VQZ+Tkw+e/GLaCzcs/YTOIkuZ30tdc5jTnqEBonJBxZu420eetHLByrBVqB8
by+lE/8XsUtuTbTD7QWIhSQky3AtQKTB0XSewf9l44dz3PmveYQUAxQbZN8HP5cH
rVLYNjITC3tLLmczbqvLV93aLCqX982QfLPgSRqFtTQmyZjxufQmEDmiSpbGHt+H
qIDDBEb4GdOXnZ5/6m/BsU6XOJFquywLeZ7PdaWc9w==
=bvBA
-----END PGP SIGNATURE-----

--ZyxZXZIJnjGEVj9R--

