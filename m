Date: Sat, 10 Jun 2017 19:46:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170610174642.GK97029@...1296...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
	<CADxRZqwYw0RLxCDB-u3NmrLUBONng5DyT-1e9q-37HDHPpnCrQ@...278...>
	<877f0jvmwi.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vWwfxLGz5ocz9zEe"
Content-Disposition: inline
In-Reply-To: <877f0jvmwi.fsf@...2274...>
Subject: Re: [Openvpn-devel] Alignement crash on sparc64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Anatoly Pugachev <matorola@...277...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, Stefan Sperling <stsp@...2273...>

--vWwfxLGz5ocz9zEe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 10, 2017 at 06:16:13PM +0200, Jeremie Courreges-Anglas wrote:
> Loaded symbols for /usr/libexec/ld.so
> #0  write_tun_header (tt=3D0x1ddd4e1900, buf=3D0x1d336921c5 "E", len=3D84=
) at tun.c:1661
> 1661            if (iph->ip_v =3D=3D 6)
> (gdb)
>=20
> buf points to an odd address.

That's a single-byte access...?  Nothing to be aligned here.

On FreeBSD, ip_v is defined as such:

 * Structure of an internet header, naked of options.
 */
struct ip {
#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
        u_char  ip_hl:4,                /* header length */
                ip_v:4;                 /* version */
#endif
#if BYTE_ORDER =3D=3D BIG_ENDIAN
        u_char  ip_v:4,                 /* version */
                ip_hl:4;                /* header length */
#endif
...

... so whatever it is, it's part of a single uchar at the very=20
beginning of that header...  strange.


OTOH, the compiler might assume 16bit-alignment here and use a 16bit-
access to get the first word, then bit-shift (someone who understands
sparc64 assembly around to check?) - in this case, the following=20
change should help:


old:
    if (iph->ip_v =3D=3D 6)

new:
    if (OPENVPN_IPH_GET_VER(*buf) =3D=3D 6)

this is an existing macro which takes an int argument, shifting and
masking the right bits, and since *buf is "uint8_t *buf", this should
both be correct and alignment-ignorant.=20=20

It might be less efficient than accessing the bit field - but then, it's=20
the same work to do, so hopefully the compiler is smart enough to compile=20
it to the same instructions.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vWwfxLGz5ocz9zEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZPDCCAAoJEB2Cnv7KVigSMagL+wUhv6qr+D86HeKcizZKokwt
mnWQK3uqWUDGbvg+joee3zn2XrASpvCLjbMjC9OO/9sN1bD4PS2ASm1bSeNkss5Y
8f+dzJtwkFlyx6vMh9FQ94+M9YEOIpFLZuI3uWTeFMol7QtTX0CO6gxmCsUrcKzC
FgswCaXi25YesMeRkRdudEXMlOSwEkxMq+7ztg9hCekUYTfGV3copIUR9iAbgy73
hVtuZ+8wo7Cnc5p7SvjqNPDBmKBqnUTYGuupn/CzzGE+wTh2c8IOQxxXTn0dQdWg
+AhMZ6752RB2M/oNKXAagTCGwSw3pJAVeLX3TYuiHjFfezfBBomDz6uAKJmCnxKS
KyM3OKDUiIkbLl/YdxryNNwQJsWOoGgfN0M7XHAXStO7gJFYJEX7Jb0MPDRsx0I6
huYFgiCt3ymKjtM9vzVPlh56vB4tQQ9IuJ0LdXNXMMk/50xl3fFTQxDJ38J4Z4WZ
n3KieUqMdALL1uGyEdOi8hQVWTDcu4Hgd/zUEYZQgg==
=/XH5
-----END PGP SIGNATURE-----

--vWwfxLGz5ocz9zEe--

